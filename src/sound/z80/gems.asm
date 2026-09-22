; GEMS Z80 driver; assembled at Z80 RAM address 0.
; ROM storage: $02A470..$02BCFB. Explicit code/data partition.
; Self-modifying DAC paths are included: see docs/CODE_DATA_AUDIT.md.
        include "include/gems_voices.inc"
        include "include/gems_pcm.inc"
        include "include/gems_pitch.inc"
        include "include/gems_fm.inc"
        include "include/gems_psg.inc"
        include "include/gems_sequence.inc"
        include "include/gems_scheduler.inc"
        org 0


GemsReset:
        di
        im 1
        ld sp,zRamRomBusRequest
        jp InitializeGemsRuntime

; PsgCommand: Z80 $0009..$000C
z80Data_PsgCommand:
        db $00,$00,$00,$00 ; PsgCommand lanes0..3

; PsgLevel: Z80 $000D..$0010
z80Data_PsgLevel:
        db $FF,$FF,$FF,$FF ; PsgLevel lanes0..3

; PsgAttackStep: Z80 $0011..$0014
z80Data_PsgAttackStep:
        db $00,$00,$00,$00 ; PsgAttackStep lanes0..3

; PsgDecayStep: Z80 $0015..$0018
z80Data_PsgDecayStep:
        db $00,$00,$00,$00 ; PsgDecayStep lanes0..3

; PsgSustainLevel: Z80 $0019..$001C
z80Data_PsgSustainLevel:
        db $00,$00,$00,$00 ; PsgSustainLevel lanes0..3

; PsgReleaseStep: Z80 $001D..$0020
z80Data_PsgReleaseStep:
        db $00,$00,$00,$00 ; PsgReleaseStep lanes0..3

; PsgPhase: Z80 $0021..$0024
z80Data_PsgPhase:
        db $00,$00,$00,$00 ; PsgPhase lanes0..3

; PsgLatchValue: Z80 $0025..$0028
z80Data_PsgLatchValue:
        db $00,$00,$00,$00 ; PsgLatchValue lanes0..3

; PsgPeriodHigh: Z80 $0029..$002C
z80Data_PsgPeriodHigh:
        db $00,$00,$00,$00 ; PsgPeriodHigh lanes0..3

; PsgAttackTarget: Z80 $002D..$0030
z80Data_PsgAttackTarget:
        db $00,$00,$00,$00 ; PsgAttackTarget lanes0..3

; PsgVolumeDirty: Z80 $0031..$0034
z80Data_PsgVolumeDirty:
        db $00,$00,$00,$00 ; PsgVolumeDirty lanes0..3

; PsgStatePadding: Z80 $0035..$0035
z80Data_PsgStatePadding:
        db $00 ; PsgStatePadding

; CommandWriteIndex: Z80 $0036..$0036
z80Data_CommandWriteIndex:
        db $00 ; CommandWriteIndex

; CommandReadIndex: Z80 $0037..$0037
z80Data_CommandReadIndex:
        db $00 ; CommandReadIndex

GemsInterrupt:
; IM1 handler: save post-interrupt-push SP at$003E, then RETI; no counters, tempo, EI or sound writes here. Accepted maskable IRQ leaves interrupts disabled until ServicePendingGemsInterrupt executes EI. High byte of SP is the pending marker; normal stack is around$1B20. See docs/GEMS_SCHEDULER.md.
        ld (zRamInterruptStackPointer),sp
        reti

; InterruptStackPointerLatch: Z80 $003E..$003F
z80Data_InterruptStackPointerLatch:
        dw $0000 ; saved SP: high byte is pending IRQ marker

; PendingSfxTicks: Z80 $0040..$0040
z80Data_PendingSfxTicks:
        db $00 ; acknowledged SFX/PSG ticks, modulo256

ServicePendingGemsInterrupt:
; DI; if saved SP high byte!=0, clear ONLY high byte, increment pending SFX byte modulo256, add tempo increment to16-bit accumulator modulo65536. Preserve AF/BC/DE/HL; DAC serviced twice for a nonempty latch. EI occurs even if latch empty. No reconstruction of missed VBlanks.
        di
        push af
        push hl
        ld hl,zRamInterruptPendingHigh
        ld a,(hl)
        or a
        jr z,FinishGemsInterruptService
        ld (hl),0
        inc hl
        inc (hl)
        call ServiceDacSample
        push de
        ld hl,(zRamTempoAccumulator)
        ld de,(zRamTempoIncrement)
        add hl,de
        ld (zRamTempoAccumulator),hl
        pop de
        call ServiceDacSample

FinishGemsInterruptService:
; Restore saved HL/AF, then EI and RET. Low byte of saved interrupt SP is intentionally left stale; it is not an independent pending flag.
        pop hl
        pop af
        ei
        ret

ServicePsgEnvelopes:
; One processed IRQ tick for all four PSG envelopes, independent of music tempo/SFX selection. RAM is 11 parallel arrays of four bytes, not four contiguous records. Clobbers AF/BC/DE/HL/IY; noise kill/release end also IX. DAC is serviced between lanes. See docs/GEMS_PSG.md.
        ld iy,zRamPsgEnvelopes
        ld hl,0x7f11
        ld d,0x80
        ld e,4

ServiceOnePsgEnvelope:
; IY=zRamPsgEnvelopes+lane, D=$80/$A0/$C0/$E0 latch base, E=4..1. Consume and clear pending bits in order: kill(bit2), release(bit1), start(bit0). Start wins if combined; only one phase is advanced this tick.
        call ServiceDacSample
        ld c,(iy+psgEnvelopeCommand)
        ld (iy+psgEnvelopeCommand),0
        bit 2,c
        jr z,ApplyPsgReleaseRequest
; Kill: level=$FF, dirty=1, phase=idle. For noise, clear tone3 reservation. Does not prevent a simultaneously pending start.
        ld (iy+psgEnvelopeLevel),0xff
        ld (iy+psgEnvelopeVolumeDirty),1
        ld (iy+psgEnvelopePhase),0
        ld a,1
        cp e
        jr nz,ApplyPsgReleaseRequest
        ld ix,zRamPsgNoiseClockVoice
        res 5,(ix)

ApplyPsgReleaseRequest:
; Release only if phase!=idle. Set phase4; first release increment runs on this same tick unless a start follows.
        bit 1,c
        jr z,ApplyPsgStartRequest
        ld a,(iy+psgEnvelopePhase)
        cp 0
        jr z,ApplyPsgStartRequest
        ld (iy+psgEnvelopeVolumeDirty),1
        ld (iy+psgEnvelopePhase),4

ApplyPsgStartRequest:
; Start resets level to$FF, writes tone divider (2 bytes) or noise control (1 byte), sets attack phase. First attack decrement runs immediately. No initial silence-volume write before the attack result.
        bit 0,c
        jr z,AdvancePsgEnvelope
        ld (iy+psgEnvelopeLevel),0xff
        ld a,(iy+psgEnvelopeLatchValue)
        or d
        ld (hl),a
        ld a,1
        cp e
        jr z,z80_00C1
        ld a,(iy+psgEnvelopePeriodHigh)
        ld (hl),a

z80_00C1:
        ld (iy+psgEnvelopeVolumeDirty),1
        ld (iy+psgEnvelopePhase),1

AdvancePsgEnvelope:
        call ServiceDacSample
        ld a,(iy+psgEnvelopePhase)
        cp 0
        jp z,NextPsgEnvelope
        cp 1
        jr nz,CheckPsgDecayPhase

AdvancePsgAttack:
; Subtract byte attack step toward attack target. Borrow, zero, or result<=target clamps and enters decay. Step0 can leave attack stuck indefinitely.
        ld (iy+psgEnvelopeVolumeDirty),1
        ld a,(iy+psgEnvelopeLevel)
        ld b,(iy+psgEnvelopeAttackTarget)
        sub (iy+psgEnvelopeAttackStep)
        jr c,FinishPsgAttack
        jr z,FinishPsgAttack
        cp b
        jr c,FinishPsgAttack
        jr z,FinishPsgAttack
        ld (iy+psgEnvelopeLevel),a
        jp NextPsgEnvelope

FinishPsgAttack:
        ld (iy+psgEnvelopeLevel),b
        ld (iy+psgEnvelopePhase),2
        jp NextPsgEnvelope

CheckPsgDecayPhase:
; Decay moves attenuation toward sustain level in EITHER direction. Ascending equality enters sustain now; exact descending equality is stored in decay and enters sustain next tick. Step0 stalls unless already at target.
        cp 2
        jp nz,CheckPsgReleasePhase
        ld (iy+psgEnvelopeVolumeDirty),1
        ld a,(iy+psgEnvelopeLevel)
        ld b,(iy+psgEnvelopeSustainLevel)
        cp b
        jr c,RaisePsgAttenuationToSustain
        jr z,EnterPsgSustain
        sub (iy+psgEnvelopeDecayStep)
        jr c,EnterPsgSustain
        cp b
        jr c,EnterPsgSustain
        jr StorePsgDecayLevel

RaisePsgAttenuationToSustain:
        add a,(iy+psgEnvelopeDecayStep)
        jr c,EnterPsgSustain
        cp b
        jr nc,EnterPsgSustain

StorePsgDecayLevel:
        ld (iy+psgEnvelopeLevel),a
        jr NextPsgEnvelope

EnterPsgSustain:
        ld (iy+psgEnvelopeLevel),b
        ld (iy+psgEnvelopePhase),3
        jr NextPsgEnvelope

CheckPsgReleasePhase:
; Only phase4 advances here; phase0/3 hold. Release adds byte step, stopping only on carry beyond255. Reaching255 exactly is still release; step0 never completes.
        cp 4
        jr nz,NextPsgEnvelope
        ld (iy+psgEnvelopeVolumeDirty),1
        ld a,(iy+psgEnvelopeLevel)
        add a,(iy+psgEnvelopeReleaseStep)
        jr c,FinishPsgRelease
        ld (iy+psgEnvelopeLevel),a
        jr NextPsgEnvelope

FinishPsgRelease:
; Release overflow clamps level255, enters idle, and for noise clears tone3 reservation. This is separate from hardware voice availability set by note-off.
        ld (iy+psgEnvelopeLevel),0xff
        ld (iy+psgEnvelopePhase),0
        ld a,1
        cp e
        jr nz,NextPsgEnvelope
        ld ix,zRamPsgNoiseClockVoice
        res 5,(ix)

NextPsgEnvelope:
        inc iy
        ld a,0x20
        add a,d
        ld d,a
        dec e
        jp nz,ServiceOnePsgEnvelope

FlushPsgVolumes:
; After all four lanes, emit dirty volumes in tone1/tone2/tone3/noise order. Hardware attenuation is level>>4. Dirty is cleared even if quantized level did not change; phase1/2/4 can rewrite identical volumes.
        call ServiceDacSample
        ld iy,zRamPsgEnvelopes
        bit 0,(iy+psgEnvelopeVolumeDirty)
        jr z,FlushPsgTone2Volume
        ld (iy+psgEnvelopeVolumeDirty),0
        ld a,(iy+psgEnvelopeLevel)
        srl a
        srl a
        srl a
        srl a
        or 0x90
        ld (hl),a

FlushPsgTone2Volume:
        bit 0,(iy+psgEnvelopeVolumeDirty+1)
        jr z,FlushPsgTone3Volume
        ld (iy+psgEnvelopeVolumeDirty+1),0
        ld a,(iy+psgEnvelopeLevel+1)
        srl a
        srl a
        srl a
        srl a
        or 0xb0
        ld (hl),a

FlushPsgTone3Volume:
        bit 0,(iy+psgEnvelopeVolumeDirty+2)
        jr z,FlushPsgNoiseVolume
        ld (iy+psgEnvelopeVolumeDirty+2),0
        ld a,(iy+psgEnvelopeLevel+2)
        srl a
        srl a
        srl a
        srl a
        or 0xd0
        ld (hl),a

FlushPsgNoiseVolume:
        bit 0,(iy+psgEnvelopeVolumeDirty+3)
        jr z,FinishPsgEnvelopeService
        ld (iy+psgEnvelopeVolumeDirty+3),0
        ld a,(iy+psgEnvelopeLevel+3)
        srl a
        srl a
        srl a
        srl a
        or 0xf0
        ld (hl),a

FinishPsgEnvelopeService:
        call ServiceDacSample
        ret

ReadGemsCommandRing:
; Blocking read of64-byte ring. Preserve BC/HL; return A=byte, advance consumer modulo64. Empty wait services DAC samples/refills ONLY, not IRQ acknowledgement or music/PSG/voice/track updates. A first accepted IRQ stays latched and masks further IRQs until control reaches an EI/ack path.
        push bc
        push hl

WaitForGemsCommandByte:
; Repeatedly service DAC/refill then compare ring indexes. No timeout, no full/empty generation bit. A partial command can hold this wait indefinitely; normal complete BUSREQ-published API calls do not imply this stall.
        call ServiceDacSample
        call ServiceDacStream
        ld a,(zRamCommandWriteIndex)
        ld b,a
        ld a,(zRamCommandReadIndex)
        cp b
        jr z,WaitForGemsCommandByte
        ld b,0
        ld c,a
        ld hl,zRamCommandRing
        call ServiceDacSample
        add hl,bc
        inc a
        and 0x3f

PublishGemsCommandConsumer:
; Publish consumer modulo64 before loading return byte. Full producer wrap aliases empty; producer-side space checks do not exist. See docs/GEMS_PCM.md.
        ld (zRamCommandReadIndex),a
        ld a,(hl)
        pop hl
        pop bc
        ret

; RomCopySourceScratch: Z80 $01F7..$01F8
z80Data_RomCopySourceScratch:
        dw $0000 ; saved source low16; scratch for bank splitting

CopyRomBytes:
; A:HL=24-bit ROM source, C=count 1..255, DE=Z80 destination. Preserves IX; clobbers AF/BC/HL, advances DE. Split at a 32-KiB ROM window boundary; C=0 is NOT a general 256-byte contract. Saved source word is shared scratch.
        call ServiceDacSample
        push ix
        ld ix,zRamRomBusRequest
        ld (zRamRomCopySourceLo),hl
        res 7,h
        ld b,0
        dec c
        add hl,bc
        bit 7,h
        jr nz,CopyRomBytesAcrossBank
        ld hl,(zRamRomCopySourceLo)
        inc c
        ld b,a
        call CopyRomBankSegment
        pop ix
        ret

CopyRomBytesAcrossBank:
; Split requested interval at $8000; crossing $FFFF also increments the ROM high byte. Exact endpoint at bank end needs no second segment.
        ld b,a
        push bc
        push hl
        ld a,c
        sub l
        ld c,a
        ld hl,(zRamRomCopySourceLo)
        call CopyRomBankSegment
        pop hl
        pop bc
        ld c,l
        inc c
        ld a,(zRamRomCopySourceHi)
        and 0x80
        add a,0x80
        ld h,a
        ld l,0
        jr nc,z80_0237
        inc b

z80_0237:
        call CopyRomBankSegment
        pop ix
        ret

CopyRomBankSegment:
; B:HL=ROM address, C=nonzero length, DE=destination, IX=bus handshake. Serialize address bits15..23 to $6000, map source into $8000..$FFFF. Six-byte LDIR chunks (tail 1..6), interleaved DAC service. Copy-active bit clears while the 68000 requests ROM access.
        call ServiceDacSample
        push de
        ld de,0x6000
        ld a,h
        rlc a
        ld (de),a
        ld a,b
        ld (de),a
        rra
        ld (de),a
        rra
        ld (de),a
        rra
        ld (de),a
        rra
        ld (de),a
        rra
        ld (de),a
        rra
        ld (de),a
        rra
        ld (de),a
        pop de
        set 7,h
        ld a,c
        ld b,0
        call ServiceDacSample
        set 0,(ix+1)
        sub 7
        jr c,CopyRomFinalChunk

CopyRomSixByteChunk:
        ld c,6
        bit 0,(ix)
        jr nz,WaitForRomBusChunk

z80_0271:
        ldir
        call ServiceDacSample
        sub 6
        jr nc,CopyRomSixByteChunk

CopyRomFinalChunk:
        add a,7
        ld c,a
        bit 0,(ix)
        jr nz,WaitForRomBusTail

z80_0283:
        ldir
        call ServiceDacSample
        res 0,(ix+1)
        ret

WaitForRomBusChunk:
; Drop copy-active bit, wait for request bit0 to clear, then resume. DAC service keeps running while waiting; a hardware BUSREQ still halts the Z80 itself.
        res 0,(ix+1)

z80_0291:
        call ServiceDacSample
        bit 0,(ix)
        jr nz,z80_0291
        set 0,(ix+1)
        jr z80_0271

WaitForRomBusTail:
        res 0,(ix+1)

z80_02A4:
        call ServiceDacSample
        bit 0,(ix)
        jr nz,z80_02A4
        set 0,(ix+1)
        jr z80_0283

; SavedDacOpcodes: Z80 $02B3..$02B6
z80Data_SavedDacOpcodes:
        dw $0000,$0000 ; saved JR entry / saved JR packed-format path

ServiceDacSample:
; RAM overlays: RET=disabled; EXX / EX AF,AF'=sample service; original JR=re-arm only (slow divisors). Alternate B=$15, D=$1F, E=read index, HL=$4000; packed mode C=$AA. See docs/GEMS_PCM.md.
        jr RearmDacSample

PollDacTimer:
; Poll YM timer-A status bit0, acknowledge/restart with B=$15, then read buffer byte through DE. Busy wait has no software timeout.
; Runtime-patched entry; patch writer at Z80 $13F6.
        ld (hl),0x27

z80_02BB:
        bit 0,(hl)
        jp z,z80_02BB
        inc l
        ld (hl),b
        dec l
        ld a,(de)

DacFormatGate:
; Uncompressed format patches this JR into two NOPs. Packed format restores its original two bytes. Both overlays are executable RAM, not extra ROM instructions.
        jr DecodePackedDacNibble

WriteUncompressedDacSample:
; Runtime-patched entry; patch writer at Z80 $141F.
        nop
        inc e

WriteDacSample:
; A=unsigned DAC byte; write YM $2A, restore both register banks. $02CF=RET for divisor<10; NOP falls into RestoreDacPatch otherwise.
        ld (hl),0x2a
        inc hl
        ld (hl),a
        dec l
        ex af,af'
        exx

DacRateGate:
        ret

RestoreDacPatch:
; Restore original JR at ServiceDacSample after one output in slow mode. Next service only re-arms the EXX / EX AF overlay; it outputs no sample.
; Runtime-patched entry; patch writer at Z80 $140B.
        ex af,af'
        ld a,(zRamSavedDacEntry)
        ld (ServiceDacSample),a
        ld a,(zRamSavedDacEntryDisp)
        ld (0x02b8),a
        ex af,af'
        ret

RearmDacSample:
; Replace the original JR with EXX / EX AF,AF' and return without output. This alternates with real DAC writes for divisor>=10.
        ex af,af'
        ld a,0xd9
        ld (ServiceDacSample),a
        ld a,8
        ld (0x02b8),a
        ex af,af'
        ret

DecodePackedDacNibble:
; RRC C alternates carry (initial C=$AA): low nibble first shifted to bits7..4, high nibble second; increment E only after high nibble. This is packed 4-bit PCM, not differential ADPCM.
        rrc c
        jr c,z80_02F8
        rla
        rla
        rla
        rla

z80_02F4:
        and 0xf0
        jr WriteDacSample

z80_02F8:
        inc e
        jr z80_02F4

; DacStreamState: Z80 $02FB..$0301
z80Data_DacStreamState:
        db $00 ; next write half: $00 or $80
        dw $0000 ; next ROM source low16
        db $00 ; next ROM source high8
        dw $0000 ; bytes remaining to copy
        db $00 ; mode 4=one-shot,5=loop,6=finish loop,7=stop requested

ServiceDacStream:
; RET=inactive; NOP enters refill test. Write-half/read-index bit7 mismatch permits copying the free 128-byte half of $1F00..$1FFF.
        ret

ServicePatchedDacStream:
; Runtime-patched entry; patch writer at Z80 $13DE.
        push af
        ld a,(zRamDacWriteHalf)
        exx
        xor e
        exx
        and 0x80
        jr nz,RefillDacBufferHalf
        pop af
        ret

PrimeDacBuffer:
; Prime first half regardless of cursor comparison, servicing the pending IRQ latch first. DAC microservice is normally disabled during initial fill.
        call ServicePendingGemsInterrupt
        push af

RefillDacBufferHalf:
; Preserve AF/BC/DE/HL. Mode>=7 stops before another copy; otherwise copy up to128 and toggle write-half. E' advances during interleaved DAC calls, not during this comparison.
        call ServiceDacSample
        push bc
        push de
        push hl
        ld a,(zRamDacStreamMode)
        cp 7
        jp nc,StopDacStream
        ld hl,(zRamDacRemaining)
        ld bc,0x80
        scf
        ccf
        sbc hl,bc
        jr c,CopyDacTailOrLoop
        jr z,CopyDacTailOrLoop
        ld (zRamDacRemaining),hl
        ld d,0x1f
        ld a,(zRamDacWriteHalf)
        ld e,a
        add a,0x80
        ld (zRamDacWriteHalf),a
        ld hl,(zRamDacSourceLo)
        ld a,(zRamDacSourceHi)
        call CopyRomBytes
        ld hl,(zRamDacSourceLo)
        ld a,(zRamDacSourceHi)
        ld bc,0x80
        add hl,bc
        adc a,0
        ld (zRamDacSourceLo),hl
        ld (zRamDacSourceHi),a
        jp ReturnFromDacRefill

CopyDacTailOrLoop:
; Remaining<=128 (INCLUDING equality): copy tail, then stop immediately unless mode5. No drain phase: final queued data is not guaranteed to play. Mode5 rewinds to end-loopLength and fills the rest of the same half from loop start.
        ld a,l
        add a,0x80
        ld c,a
        ld b,0
        push bc
        ld d,0x1f
        ld a,(zRamDacWriteHalf)
        ld e,a
        add a,0x80
        ld (zRamDacWriteHalf),a
        ld hl,(zRamDacSourceLo)
        ld a,(zRamDacSourceHi)
        call CopyRomBytes
        pop bc
        ld a,(zRamDacStreamMode)
        cp 5
        jp nz,StopDacStream
        ld hl,(zRamDacSourceLo)
        ld a,(zRamDacSourceHi)
        push bc
        add hl,bc
        adc a,0
        ld bc,(zRamDacDescriptorLoopLength)
        scf
        ccf
        sbc hl,bc
        sbc a,0
        ld (zRamDacSourceLo),hl
        ld (zRamDacSourceHi),a
        ld (zRamDacRemaining),bc
        pop bc
        ld a,0x80
        sub c
        ld c,a
        jp z,ReturnFromDacRefill
        ld hl,(zRamDacRemaining)
        scf
        ccf
        sbc hl,bc
        ld (zRamDacRemaining),hl
        ld hl,(zRamDacSourceLo)
        ld a,(zRamDacSourceHi)
        push bc
        call CopyRomBytes
        pop bc
        ld hl,(zRamDacSourceLo)
        ld a,(zRamDacSourceHi)
        add hl,bc
        adc a,0
        ld (zRamDacSourceLo),hl
        ld (zRamDacSourceHi),a
        jr ReturnFromDacRefill

StopDacStream:
; Disable both RAM service hooks with RET, YM $2B=0, DAC hardware voice flags=$C6, duration=0. Does not wait for playback cursor to reach the newly copied tail.
        ld a,0xc9
        ld (ServiceDacSample),a
        ld (ServiceDacStream),a
        ld hl,0x4000
        ld (hl),0x2b
        inc hl
        ld (hl),0
        ld hl,zRamDacVoice
        ld (hl),0xc6
        inc hl
        inc hl
        inc hl
        inc hl
        ld (hl),0
        inc hl
        ld (hl),0

ReturnFromDacRefill:
        pop hl
        pop de
        pop bc
        pop af
        ret

ReadSequenceByte:
; IX=logical channel; zRamSequenceCacheBuffer points to its16-byte RAM window. Return A=next byte; advance24-bit ROM cursor with carry. Preserve BC/DE/HL/IX; flags are not preserved. Cache hit requires unsigned24-bit cursor-base<16. See docs/GEMS_SEQUENCE.md.
        call ServiceDacSample
        push bc
        push hl
        ld a,(ix+channelCursorLo)
        sub (ix+channelCacheBaseLo)
        ld c,a
        ld a,(ix+channelCursorMid)
        sbc a,(ix+channelCacheBaseMid)
        jr nz,RefillSequenceReadCache
        ld a,(ix+channelCursorHi)
        sbc a,(ix+channelCacheBaseHi)
        jr nz,RefillSequenceReadCache
        ld a,c
        cp 0x10
        jr nc,RefillSequenceReadCache

ReadCachedSequenceByte:
        call ServiceDacSample
        ld b,0
        ld hl,(zRamSequenceCacheBuffer)
        add hl,bc
        ld a,(hl)
        inc (ix+channelCursorLo)
        jr nz,FinishSequenceByteRead
        inc (ix+channelCursorMid)
        jr nz,FinishSequenceByteRead
        inc (ix+channelCursorHi)

FinishSequenceByteRead:
        pop hl
        pop bc
        call ServiceDacSample
        ret

RefillSequenceReadCache:
; Refill exactly16 bytes from current cursor; replace cached ROM base. Calls ROM-copy and pending-IRQ service; no stream-end check.
        call ServiceDacSample
        call ServicePendingGemsInterrupt
        push de
        ld de,(zRamSequenceCacheBuffer)
        ld l,(ix+channelCursorLo)
        ld (ix+channelCacheBaseLo),l
        ld h,(ix+channelCursorMid)
        ld (ix+channelCacheBaseMid),h
        ld a,(ix+channelCursorHi)
        ld (ix+channelCacheBaseHi),a
        ld c,0x10
        call CopyRomBytes
        pop de
        ld c,0
        jr ReadCachedSequenceByte

; SequenceCacheBufferPointer: Z80 $0454..$0455
z80Data_SequenceCacheBufferPointer:
        dw $0000

; CurrentPatchBufferPointer: Z80 $0456..$0457
z80Data_CurrentPatchBufferPointer:
        dw $0000

ServiceSequenceTracks:
; Scan16 logical channels in ascending order. Only running bit4 and selected tick (music bit1 / SFX bit0) gate execution; active/reserved bits are not checked here. Save loop counters around each track. Current cache/patch pointers finish at lane15.
        ld ix,zRamLogicalChannels
        ld hl,zRamSequenceReadCaches
        ld (zRamSequenceCacheBuffer),hl
        ld hl,zRamChannelPatches
        ld (zRamCurrentPatchBuffer),hl
        ld a,(zRamSoundTickFlags)
        ld c,a
        ld a,0x10
        ld b,0
        jr CheckSequenceTrackClock

NextSequenceTrack:
        call ServiceDacSample
        ld de,0x20
        add ix,de
        ld hl,(zRamSequenceCacheBuffer)
        ld e,0x10
        add hl,de
        ld (zRamSequenceCacheBuffer),hl
        ld hl,(zRamCurrentPatchBuffer)
        ld e,0x27
        add hl,de
        ld (zRamCurrentPatchBuffer),hl

CheckSequenceTrackClock:
        bit 4,(ix+channelFlags)
        jr z,FinishSequenceTrackSlot
        bit 3,(ix+channelFlags)
        jr nz,CheckSequenceSfxTick
        bit 1,c
        jr nz,RunReadySequenceTrack
        jr FinishSequenceTrackSlot

CheckSequenceSfxTick:
        bit 0,c
        jr z,FinishSequenceTrackSlot

RunReadySequenceTrack:
        call ServiceDacSample
        push af
        push bc
        call ServiceDacStream
        call AdvanceSequenceTrack
        pop bc
        pop af

FinishSequenceTrackSlot:
        inc b
        dec a
        jr nz,NextSequenceTrack
        ret

AdvanceSequenceTrack:
; Increment negative LE16 delay counter; decode only when it reaches0. Input0 waits65536 selected ticks. Duration and delay are separate; note duration is consumed later by hardware-voice timers.
        inc (ix+channelDelayCounterLo)
        ret nz
        inc (ix+channelDelayCounterHi)
        ret nz

ReadNextSequenceEvent:
        call ReadSequenceByte

DecodeSequenceEvent:
; High-bit bytes form groups of6 bits, modulo65536: $C0..FF delay, $80..BF duration. Store negated value and decode already-read lookahead byte in the same call. Zero delay can run arbitrarily many events without yielding.
        bit 7,a
        jp z,SequenceNoteOrCommand
        bit 6,a
        jr z,BeginSequenceDurationGroup
        and 0x3f
        ld e,a
        ld d,0

ReadSequenceDelayGroup:
        call ReadSequenceByte
        bit 7,a
        jr z,StoreNegativeSequenceDelay
        bit 6,a
        jr z,StoreNegativeSequenceDelay
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        and 0x3f
        or e
        ld e,a
        jr ReadSequenceDelayGroup

StoreNegativeSequenceDelay:
        ld h,a
        ld a,e
        cpl
        ld e,a
        ld a,d
        cpl
        ld d,a
        inc de
        ld (ix+channelDelayValueLo),e
        ld (ix+channelDelayValueHi),d
        ld a,h
        jr DecodeSequenceEvent

BeginSequenceDurationGroup:
        and 0x3f
        ld e,a
        ld d,0

ReadSequenceDurationGroup:
        call ReadSequenceByte
        bit 7,a
        jr z,StoreNegativeSequenceDuration
        bit 6,a
        jr nz,StoreNegativeSequenceDuration
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        sla e
        rl d
        and 0x3f
        or e
        ld e,a
        jr ReadSequenceDurationGroup

StoreNegativeSequenceDuration:
        ld h,a
        ld a,e
        cpl
        ld e,a
        ld a,d
        cpl
        ld d,a
        inc de
        ld (ix+channelDurationLo),e
        ld (ix+channelDurationHi),d
        ld a,h
        jp DecodeSequenceEvent

SequenceNoteOrCommand:
; Notes0..95 are suppressed by channel mute bit1, but delay still applies. Patch/priority/duration are consumed at note boundary. Note call preserves track IX/BC at this caller.
        cp 0x60
        jr nc,DispatchSequenceOpcode
        bit 1,(ix+channelFlags)
        jr nz,ApplySequenceDelay
        push bc
        push ix
        ld c,a
        call PlayInstrumentNote
        pop ix
        pop bc

ApplySequenceDelay:
; Nonzero stored delay is copied into countdown and returns; zero continues reading in the same invocation. Most commands consume this same delay, not only notes/rests.
        call ServiceDacSample
        ld e,(ix+channelDelayValueLo)
        ld d,(ix+channelDelayValueHi)
        ld a,d
        or e
        jp z,ReadNextSequenceEvent
        ld (ix+channelDelayCounterLo),e
        ld (ix+channelDelayCounterHi),d
        ret

DispatchSequenceOpcode:
        sub 0x60
        jp z,SequenceEnd
        dec a
        jp z,SequenceSetPatch
        dec a
        jp z,SequenceSetModulation
        dec a
        jp z,ApplySequenceDelay
        dec a
        jp z,SequenceLoopBegin
        dec a
        jp z,SequenceLoopEnd
        dec a
        jp z,SequenceSetRetrigger
        dec a
        jp z,SequenceSetSustain
        dec a
        jp z,SequenceSetTempo
        dec a
        jp z,SequenceMuteTrack
        dec a
        jp z,SequenceSetPriority
        dec a
        jp z,SequenceStartAnother
        dec a
        jp z,SequenceSetPitch
        dec a
        jp z,SequenceUseSfxTiming
        dec a
        jp z,SequenceSetDacRate
        dec a
        jp z,SequenceRelativeJump
        dec a
        jp z,SequenceWriteMailbox
        dec a
        jp z,SequenceConditionalSkip
        dec a
        jp z,SequenceExtendedCommand
        jp ReadNextSequenceEvent

SequenceSetModulation:
; Store envelope ID. If retrigger bit6 is clear, start modulation now; otherwise defer start until a note is committed. No such opcode in shipped tracks. See docs/GEMS_PITCH.md.
        call ReadSequenceByte
        ld (ix+channelModulation),a
        bit 6,(ix+channelFlags)
        jp nz,ApplySequenceDelay
        push bc
        push ix
        ld e,b
        ld c,(ix+channelModulation)
        call StartPitchModulation
        pop ix
        pop bc
        jp ApplySequenceDelay

SequenceSetRetrigger:
; Nonzero argument enables per-note modulation restart; zero disables that policy. Does not itself stop an existing modulation slot.
        call ReadSequenceByte
        or a
        jp nz,EnableSequenceRetrigger
        res 6,(ix+channelFlags)
        jp ApplySequenceDelay

EnableSequenceRetrigger:
        set 6,(ix+channelFlags)
        jp ApplySequenceDelay

SequenceSetSustain:
        call ReadSequenceByte
        or a
        jr nz,EnableSequenceSustain
        res 7,(ix+channelFlags)
        jp ApplySequenceDelay

EnableSequenceSustain:
        set 7,(ix+channelFlags)
        jp ApplySequenceDelay

SequenceEnd:
; End clears channel flags and its duration field only. Does NOT call note-off/voice cleanup; already committed notes remain governed by their own timers, envelope or later stealing.
        ld (ix+channelFlags),0
        ld (ix+channelDurationLo),0
        ld (ix+channelDurationHi),0
        ret

SequenceSetPatch:
        call ReadSequenceByte
        ld (ix+channelPatch),a
        push bc
        call LoadChannelPatch
        pop bc
        jp ApplySequenceDelay

SequenceLoopBegin:
; Four3-byte slots at channel+16,+19,+22,+25: count, cursor low16. Scan for count0 with NO depth bound. Count0 is indistinguishable from unused; malformed streams can escape the record.
        push ix
        pop iy
        ld de,0x10
        add iy,de
        ld de,3

FindFreeSequenceLoopSlot:
        ld a,(iy+sequenceLoopCount)
        or a
        jr z,StoreSequenceLoopStart
        add iy,de
        jr FindFreeSequenceLoopSlot

StoreSequenceLoopStart:
        call ReadSequenceByte
        ld (iy+sequenceLoopCount),a
        ld a,(ix+channelCursorLo)
        ld (iy+sequenceLoopCursorLo),a
        ld a,(ix+channelCursorMid)
        ld (iy+sequenceLoopCursorMid),a
        jp ReadNextSequenceEvent

SequenceLoopEnd:
; Find last nonzero loop slot by scanning backward, with NO underflow bound. $7F loops forever; other counts decrement. Values>=128 eventually reach$7F and then also loop forever.
        push ix
        pop iy
        ld de,0x19
        add iy,de
        ld de,0xfffd

FindLastSequenceLoopSlot:
        ld a,(iy+sequenceLoopCount)
        or a
        jr nz,AdvanceSequenceLoopCount
        add iy,de
        jr FindLastSequenceLoopSlot

AdvanceSequenceLoopCount:
        cp 0x7f
        jr z,RewindSequenceLoop
        dec a
        ld (iy+sequenceLoopCount),a
        jp z,ReadNextSequenceEvent

RewindSequenceLoop:
; Restore saved low16 cursor. Decrement high byte when saved low16>=current low16; assumes backward distance1..65536. No saved high byte or general long-loop support.
        ld l,(iy+sequenceLoopCursorLo)
        ld e,(ix+channelCursorLo)
        ld (ix+channelCursorLo),l
        ld h,(iy+sequenceLoopCursorMid)
        ld d,(ix+channelCursorMid)
        ld (ix+channelCursorMid),h
        scf
        ccf
        sbc hl,de
        jr c,ContinueAfterSequenceLoop
        dec (ix+channelCursorHi)

ContinueAfterSequenceLoop:
        jp ReadNextSequenceEvent

SequenceSetTempo:
; Tempo argument+40 wraps as an8-bit byte BEFORE SetTempoIncrement. Stored increment=floor(argumentWrapped*436/256); accumulator is not reset.
        call ReadSequenceByte
        add a,0x28
        call SetTempoIncrement
        jp ApplySequenceDelay

SequenceMuteTrack:
; First active channel matching this sequence and argument low4 track index. Argument bit4 means UNMUTE; clear means mute future note events. No immediate hardware key-off. Search includes reserved channels.
        call ReadSequenceByte
        ld h,a
        ld l,0x10
        ld iy,zRamLogicalChannels
        ld de,0x20

FindSequenceMuteTarget:
        bit 0,(iy+channelFlags)
        jr z,NextSequenceMuteTarget
        ld a,(iy+channelSequence)
        cp (ix+channelSequence)
        jr nz,NextSequenceMuteTarget
        ld a,h
        and 15
        cp (iy+channelTrack)
        jr z,ApplySequenceMuteMask

NextSequenceMuteTarget:
        dec l
        jp z,ApplySequenceDelay
        add iy,de
        jr FindSequenceMuteTarget

ApplySequenceMuteMask:
        bit 4,h
        jr nz,UnmuteSequenceTarget
        set 1,(iy+channelFlags)
        jp ApplySequenceDelay

UnmuteSequenceTarget:
        res 1,(iy+channelFlags)
        jp ApplySequenceDelay

SequenceSetPriority:
        call ReadSequenceByte
        ld (ix+channelPriority),a
        jp ApplySequenceDelay

SequenceStartAnother:
; Start another sequence immediately. Current IX/BC are saved; free channels get allocated without stopping an existing instance. Newly allocated higher-numbered lanes can run later in this same scheduler pass.
        call ReadSequenceByte
        push ix
        push bc
        call StartSequence
        pop bc
        pop ix
        jp ApplySequenceDelay

SequenceSetPitch:
; B=logical channel. Read base pitch LE16 into split low/high arrays, set per-channel dirty and global pending. Unit is 1/256 of a semitone.
        ld iy,zRamBasePitchLo
        ld e,b
        ld d,0
        add iy,de
        call ReadSequenceByte
        ld (iy),a
        call ReadSequenceByte
        ld (iy+pitchBaseHi),a
        set 0,(iy+pitchDirty)
        ld a,1
        ld (zRamPitchUpdatePending),a
        jp ApplySequenceDelay

SequenceUseSfxTiming:
; Set owner SFX-clock flag for FUTURE scheduler passes. Does not change the hardware flags already copied into existing notes.
        set 3,(ix+channelFlags)
        jp ApplySequenceDelay

SequenceSetDacRate:
; Read rate argument for every patch type; only type1 DAC changes patch buffer byte+1. This modifies the channel copy, not ROM.
        call ReadSequenceByte
        ld d,a
        ld hl,(zRamCurrentPatchBuffer)
        ld a,(hl)
        cp 1
        jp nz,ApplySequenceDelay
        inc hl
        ld (hl),d
        jp ApplySequenceDelay

SequenceRelativeJump:
; SignedLE16 displacement relative to cursor AFTER both operands; sign-extend and add modulo24 bits. Continue immediately without applying delay.
        call ReadSequenceByte
        ld l,a
        call ReadSequenceByte
        ld h,a
        rla
        ld a,0
        sbc a,0
        ld d,a

AddSequenceCursorOffset:
        ld a,(ix+channelCursorLo)
        add a,l
        ld (ix+channelCursorLo),a
        ld a,(ix+channelCursorMid)
        adc a,h
        ld (ix+channelCursorMid),a
        ld a,(ix+channelCursorHi)
        adc a,d
        ld (ix+channelCursorHi),a
        jp ReadNextSequenceEvent

SequenceWriteMailbox:
        call ReadSequenceMailboxOperands
        ld (hl),a
        jp ApplySequenceDelay

SequenceConditionalSkip:
; Read mailbox index, condition, constant, unsigned8 skip. Conditions compare CONSTANT to MAILBOX:1 ==,2 >=,3 >,4 <=,5 <,otherwise !=. Both outcomes consume skip; taken target=cursor-after-operands+skip. No delay.
        call ReadSequenceMailboxOperands
        ld d,a
        call ReadSequenceByte
        dec d
        jr nz,SequenceConditionAtLeast
        cp (hl)
        jr nz,IgnoreSequenceConditionalSkip
        jr TakeSequenceConditionalSkip

SequenceConditionAtLeast:
        dec d
        jr nz,SequenceConditionGreater
        cp (hl)
        jr c,IgnoreSequenceConditionalSkip
        jr TakeSequenceConditionalSkip

SequenceConditionGreater:
        dec d
        jr nz,SequenceConditionAtMost
        cp (hl)
        jr c,IgnoreSequenceConditionalSkip
        jr z,IgnoreSequenceConditionalSkip
        jr TakeSequenceConditionalSkip

SequenceConditionAtMost:
        dec d
        jr nz,SequenceConditionLess
        cp (hl)
        jr c,TakeSequenceConditionalSkip
        jr z,TakeSequenceConditionalSkip
        jr IgnoreSequenceConditionalSkip

SequenceConditionLess:
        dec d
        jr nz,SequenceConditionNotEqual
        cp (hl)
        jr nc,IgnoreSequenceConditionalSkip
        jr TakeSequenceConditionalSkip

SequenceConditionNotEqual:
        cp (hl)
        jr z,IgnoreSequenceConditionalSkip

TakeSequenceConditionalSkip:
        call ReadSequenceByte
        ld l,a
        ld h,0
        ld d,0
        jr AddSequenceCursorOffset

IgnoreSequenceConditionalSkip:
        call ReadSequenceByte
        jp ReadNextSequenceEvent

ReadSequenceMailboxOperands:
; Mailbox address=zRamSequenceMailboxes+unsigned byte index. No bounds mask/check; address can overlap other Z80 RAM. Shared operand reader returns HL=address,A=second byte.
        call ReadSequenceByte
        ld e,a
        ld d,0
        ld hl,zRamSequenceMailboxes
        add hl,de
        call ReadSequenceByte
        ret

SequenceExtendedCommand:
; Extended command always consumes subcommand and value.0 stop ID,1 pause ID,2 resume all(value unused),3 pause ID from mailbox0(value unused),4 global attenuation,5 current-channel attenuation. Others ignored; all use ApplySequenceDelay.
        call ReadSequenceByte
        ld d,a
        call ReadSequenceByte
        ld e,a
        ld a,d
        cp 0
        jp z,SequenceStopById
        cp 1
        jp z,SequencePauseById
        cp 2
        jp z,SequenceResumeAll
        cp 3
        jp z,SequencePauseFromMailbox
        cp 4
        jr z,SequenceSetGlobalAttenuation
        cp 5
        jr z,SequenceSetChannelAttenuation
        jp ApplySequenceDelay

SequenceSetGlobalAttenuation:
        ld a,e
        ld (zRamGlobalAttenuation),a
        jp ApplySequenceDelay

SequenceSetChannelAttenuation:
        ld (ix+channelAttenuation),e
        jp ApplySequenceDelay

SequenceStopById:
        push ix
        push bc
        ld a,e
        call StopSequence
        pop bc
        pop ix
        jp ApplySequenceDelay

SequencePauseById:
        ld a,e

PauseSequenceFromTrack:
        push ix
        push bc
        call PauseSequence
        pop bc
        pop ix
        jp ApplySequenceDelay

SequencePauseFromMailbox:
        ld a,(zRamSequenceMailboxes)
        jr PauseSequenceFromTrack

SequenceResumeAll:
        push ix
        push bc
        call ResumeActiveSequences
        pop bc
        pop ix
        jp ApplySequenceDelay

ServiceHardwareVoiceTimers:
; Advance hardware voice timers on the selected scheduler tick (music bit1 or SFX bit0). Release age counts down; negative duration counts up to zero. No relation to channel reservation. See docs/GEMS_VOICES.md.
        ld de,7
        ld a,(zRamSoundTickFlags)
        ld b,a
        ld h,0
        ld ix,zRamFmVoices
        call ServiceVoicePoolTimers
        inc h
        ld ix,zRamPsgToneVoices
        call ServiceVoicePoolTimers
        ld ix,zRamPsgNoiseVoice
        call ServiceVoicePoolTimers
        ret

z80_0826:
        add ix,de

ServiceVoicePoolTimers:
        ld a,(ix)
        cp 0xff
        ret z
        call ServiceDacSample
        bit 3,a
        jr nz,z80_083B
        bit 1,b
        jr z,z80_0826
        jr AdvanceVoiceReleaseOrDuration

z80_083B:
        bit 0,b
        jr z,z80_0826

AdvanceVoiceReleaseOrDuration:
        bit 6,a
        jr z,AdvanceVoiceDuration
        dec (ix+voiceReleaseAge)
        jr nz,z80_0826
        res 6,a
        ld (ix),a
        jr z80_0826

AdvanceVoiceDuration:
        bit 4,a
        jr z,z80_0826
        and 7
        ld c,a
        inc (ix+voiceDurationLo)
        jr nz,z80_0826
        inc (ix+voiceDurationHi)
        jr nz,z80_0826
        res 4,(ix)
        res 3,(ix)
        ld a,(ix)
        and 0x2f
        cp 0x26
        jr z,z80_08A0
        set 6,(ix)
        set 7,(ix)
        bit 0,h
        jr z,z80_088C
        ld e,c
        ld iy,zRamPsgEnvelopes
        add iy,de
        ld e,7
        set 1,(iy)
        jr z80_0826

z80_088C:
        ld iy,0x4000
        ld a,c

z80_0891:
        bit 7,(iy)
        jr nz,z80_0891
        ld (iy),0x28
        ld (iy+1),a
        jr z80_0826

z80_08A0:
        call RequestDacNoteRelease
        jr z80_0826

z80_08A5:
        call ReadGemsCommandRing
        ld d,0
        ld e,a
        sla e
        sla e
        sla e
        sla e
        sla e
        rl d
        ld ix,zRamLogicalChannels
        add ix,de
        ret

; TempoIncrement: Z80 $08BE..$08BF
z80Data_TempoIncrement:
        dw $00CC

; TempoAccumulator: Z80 $08C0..$08C1
z80Data_TempoAccumulator:
        dw $0000

; SoundTickFlags: Z80 $08C2..$08C2
z80Data_SoundTickFlags:
        db $00

InitializeGemsRuntime:
        exx
        ld b,0x15
        ld d,0x1f
        ld hl,0x4000
        exx
        ei
        ld hl,0x7f11
        ld (hl),0x9f
        ld (hl),0xbf
        ld (hl),0xdf
        ld (hl),0xff
        ld hl,zRamChannelPatches
        ld de,0x27
        ld b,0x10

z80_08E0:
        ld (hl),0xff
        add hl,de
        dec b
        jr nz,z80_08E0
        ld hl,(ServiceDacSample)
        ld (zRamSavedDacEntry),hl
        ld hl,(DacFormatGate)
        ld (zRamSavedDacFormat),hl
        ld a,0xc9
        ld (ServiceDacSample),a

GemsMainLoop:
; Outer loop: acknowledge IRQ; DAC/refill/DAC; acknowledge IRQ; at most one pending SFX/PSG step and one music step. Then modulation -> voice timers -> tracks, with IRQ service between. Dirty pitch runs even without ticks; host command parsing is last. See docs/GEMS_SCHEDULER.md.
        call ServicePendingGemsInterrupt
        call ServiceDacSample
        call ServiceDacStream
        call ServiceDacSample
        call ServicePendingGemsInterrupt
        ld b,0
        ld a,(zRamPendingSfxTicks)
        sub 1
        jr c,ConsumePendingMusicTick
        ld (zRamPendingSfxTicks),a
; Consume one pending IRQ tick for PSG envelopes. This precedes music-tempo accumulation tests; PSG envelope timing does not use the musical tick or owner SFX flag.
        call ServicePsgEnvelopes
        call ServicePendingGemsInterrupt
        ld b,1

ConsumePendingMusicTick:
; Consume at most one HIGH-byte unit of tempo accumulator, preserving fractional low byte. Set music bit1 in B. Backlogged ticks require additional outer passes; rate>256 can produce music-only passes.
        call ServiceDacSample
        ld a,(zRamPendingMusicTicks)
        sub 1
        jr c,DispatchGemsTickServices
        ld (zRamPendingMusicTicks),a
        set 1,b

DispatchGemsTickServices:
; B is frozen tick mask for this service group. If zero, keep old zRamSoundTickFlags but skip tick services. IRQ acknowledgements inside/between services add counters for later passes; they do not alter this mask.
        ld a,b
        or a
        jr z,ServicePitchesAndHostCommands
        ld (zRamSoundTickFlags),a
        call ServicePitchModulation
        call ServicePendingGemsInterrupt
        call ServiceHardwareVoiceTimers
        call ServicePendingGemsInterrupt
        call ServiceSequenceTracks
        call ServicePendingGemsInterrupt

ServicePitchesAndHostCommands:
; Apply dirty pitch every pass, then compare producer/consumer. Empty ring returns immediately to scheduler. Nonempty ring consumes one prefix; a byte other than$FF is discarded for this pass.
        call ApplyDirtyChannelPitches
        ld a,(zRamCommandWriteIndex)
        ld b,a
        ld a,(zRamCommandReadIndex)
        cp b
        jp z,GemsMainLoop

ReadGemsCommandPrefix:
        call ReadGemsCommandRing
        cp 0xff
        jp nz,GemsMainLoop

ReadGemsCommandOpcode:
; After prefix$FF, block until opcode byte exists. Dispatch at most one command then return to main loop. Unknown opcode discarded; operands are read as ordinary bytes, including$FF. No length or command timeout.
        call ReadGemsCommandRing
        cp 0
        jp z,CommandNoteOn
        cp 1
        jp z,CommandNoteOff
        cp 2
        jp z,CommandSetPatch
        cp 3
        jp z,z80_09FE
        cp 4
        jp z,CommandSetChannelPitch
        cp 5
        jp z,CommandSetTempo
        cp 6
        jp z,CommandSetModulationEnvelope
        cp 7
        jp z,CommandSetModulationRetrigger
        cp 11
        jp z,CommandSetBankAddresses
        cp 12
        jp z,CommandPauseAll
        cp 13
        jp z,CommandResumeAll
        cp 14
        jp z,z80_0ACF
        cp 0x10
        jp z,CommandStartSequence
        cp 0x12
        jp z,CommandStopSequence
        cp 0x14
        jp z,CommandSetChannelPriority
        cp 0x16
        jp z,CommandStopAll
        cp 0x17
        jp z,z80_0B12
        cp 0x1a
        jp z,CommandSetDacRate
        cp 0x1b
        jp z,CommandWriteMailbox
        cp 0x1c
        jp z,CommandReserveChannel
        cp 0x1d
        jp z,CommandUnreserveChannel
        cp 0x1e
        jp z,CommandSetTrackPitch
        cp 0x1f
        jp z,z80_0BA8
        cp 0x20
        jp z,CommandSetGlobalAttenuation
        jp GemsMainLoop

CommandNoteOn:
        call z80_08A5
        ld b,a
        call GetChannelPatchBuffer
        ld (zRamCurrentPatchBuffer),hl
        call ReadGemsCommandRing
        ld c,a
        call PlayInstrumentNote
        jp GemsMainLoop

CommandNoteOff:
        call ReadGemsCommandRing
        ld b,a
        call ReadGemsCommandRing
        ld c,a
        call ReleaseChannelNote
        jp GemsMainLoop

CommandSetPatch:
        call z80_172A
        jp GemsMainLoop

z80_09FE:
        call ReadGemsCommandRing
        call z80_176A
        jp GemsMainLoop

CommandSetChannelPitch:
; Command $04: read logical channel, then pitch low/high bytes. No channel bounds check.
        call ReadGemsCommandRing
        call ReadChannelPitchCommand
        jp GemsMainLoop

CommandSetTrackPitch:
; Command $1E: sequence, track, pitch low/high. Change first matching active logical channel. If none matches, still consume both pitch bytes.
        call ReadGemsCommandRing
        ld c,a
        call ReadGemsCommandRing
        ld h,a
        ld l,0
        ld ix,zRamLogicalChannels
        ld de,0x20
        ld b,0x10

z80_0A23:
        bit 0,(ix+6)
        jr z,z80_0A3C
        ld a,(ix+14)
        cp c
        jr nz,z80_0A3C
        ld a,(ix+15)
        cp h
        jr nz,z80_0A3C
        ld a,l
        call ReadChannelPitchCommand
        jp GemsMainLoop

z80_0A3C:
        add ix,de
        inc l
        dec b
        jr nz,z80_0A23
        call ReadGemsCommandRing
        call ReadGemsCommandRing
        jp GemsMainLoop

CommandSetTempo:
        call ReadGemsCommandRing
        call SetTempoIncrement
        jp GemsMainLoop

CommandSetModulationEnvelope:
; Command $06: channel and envelope index. Store index, start immediately unless channel retrigger bit6 defers start to note-on.
        call z80_08A5
        ld b,a
        call ReadGemsCommandRing
        ld (ix+0x1d),a
        bit 6,(ix+6)
        jp nz,GemsMainLoop
        ld c,a
        ld e,b
        call StartPitchModulation
        jp GemsMainLoop

CommandSetModulationRetrigger:
; Command $07: channel and boolean retrigger policy; does not start/stop an existing envelope itself.
        call z80_08A5
        call ReadGemsCommandRing
        or a
        jr z,z80_0A7D
        set 6,(ix+6)
        jp GemsMainLoop

z80_0A7D:
        res 6,(ix+6)
        jp GemsMainLoop

CommandStartSequence:
        call ReadGemsCommandRing
        call StartSequence
        jp GemsMainLoop

CommandStopSequence:
        call ReadGemsCommandRing
        call StopSequence
        jp GemsMainLoop

CommandSetBankAddresses:
; Host command$0B consumes12 raw bytes directly into four bank pointers. Partial input leaves a partially updated bank table while waiting. Main scheduler is blocked, but DAC/refill continues; no staging/atomic commit at driver level.
        ld hl,zRamPatchBankLo
        ld b,12

ReadGemsBankAddressByte:
        call ReadGemsCommandRing
        ld (hl),a
        inc hl
        djnz ReadGemsBankAddressByte
        jp GemsMainLoop

; PatchBankPointer: Z80 $0AA5..$0AA7
z80Data_PatchBankPointer:
        db $00,$00,$00

; EnvelopeBankPointer: Z80 $0AA8..$0AAA
z80Data_EnvelopeBankPointer:
        db $00,$00,$00

; SequenceBankPointer: Z80 $0AAB..$0AAD
z80Data_SequenceBankPointer:
        db $00,$00,$00

; SampleBankPointer: Z80 $0AAE..$0AB0
z80Data_SampleBankPointer:
        db $00,$00,$00

CommandPauseAll:
; Pause every logical channel by clearing running bit4; preserve stream cursor/counters. Cleanup silences owned FM/DAC voices and requests PSG envelope shutdown. No saved hardware-note snapshot.
        ld ix,zRamLogicalChannels
        ld b,0x10
        ld de,0x20

z80_0ABA:
        res 4,(ix+channelFlags)
        add ix,de
        dec b
        jr nz,z80_0ABA
        call SilenceInactiveChannelVoices
        jp GemsMainLoop

CommandResumeAll:
        call ResumeActiveSequences
        jp GemsMainLoop

z80_0ACF:
        call z80_08A5
        call ReadGemsCommandRing
        or a
        jr z,z80_0ADF
        set 7,(ix+6)
        jp GemsMainLoop

z80_0ADF:
        res 7,(ix+6)
        jp GemsMainLoop

CommandSetChannelPriority:
        call z80_08A5
        call ReadGemsCommandRing
        ld (ix+0x1c),a
        jp GemsMainLoop

CommandStopAll:
; Clear flags AND duration of all 16 logical channels, including reservations; then silence inactive voices. Different from stopping one sequence.
        ld ix,zRamLogicalChannels
        ld de,0x20
        ld b,0x10

z80_0AFB:
        ld (ix+channelFlags),0
        ld (ix+channelDurationLo),0
        ld (ix+channelDurationHi),0
        add ix,de
        dec b
        jr nz,z80_0AFB
        call SilenceInactiveChannelVoices
        jp GemsMainLoop

z80_0B12:
        call ReadGemsCommandRing
        ld c,a
        call ReadGemsCommandRing
        ld h,a
        call ReadGemsCommandRing
        ld l,a
        ld ix,zRamLogicalChannels
        ld de,0x20
        ld b,0x10

z80_0B27:
        bit 0,(ix+6)
        jr z,z80_0B47
        ld a,(ix+14)
        cp c
        jr nz,z80_0B47
        ld a,(ix+15)
        cp h
        jr nz,z80_0B47
        bit 0,l
        jr nz,z80_0B43
        res 1,(ix+6)
        jr z80_0B47

z80_0B43:
        set 1,(ix+6)

z80_0B47:
        dec b
        jp z,GemsMainLoop
        add ix,de
        jr z80_0B27

CommandSetDacRate:
        call ReadGemsCommandRing
        call GetChannelPatchBuffer
        call ReadGemsCommandRing
        ld b,a
        ld a,(hl)
        cp 1
        jp nz,GemsMainLoop
        inc hl
        ld (hl),b
        jp GemsMainLoop

CommandWriteMailbox:
; Host command$1B writes mailbox[index] from two ring bytes. Same unbounded address calculation as sequence$70; no acknowledgement protocol in these data mailboxes.
        call ReadGemsCommandRing
        ld d,0
        ld e,a
        ld hl,zRamSequenceMailboxes
        add hl,de
        call ReadGemsCommandRing
        ld (hl),a
        jp GemsMainLoop

CommandReserveChannel:
        call z80_08A5
        set 5,(ix+6)
        jp GemsMainLoop

CommandUnreserveChannel:
        call z80_08A5
        res 5,(ix+6)
        jp GemsMainLoop

ResumeActiveSequences:
; Set running bit4 only for active bit0 / unreserved bit5-clear channels. Does not restore stolen/silenced notes or replay a sample; resumes future sequence processing.
        ld ix,zRamLogicalChannels
        ld b,0x10
        ld de,0x20

z80_0B92:
        bit 5,(ix+channelFlags)
        jr nz,z80_0BA2
        bit 0,(ix+channelFlags)
        jr z,z80_0BA2
        set 4,(ix+channelFlags)

z80_0BA2:
        dec b
        ret z
        add ix,de
        jr z80_0B92

z80_0BA8:
        call z80_08A5
        call ReadGemsCommandRing
        ld (ix+0x1e),a
        jp GemsMainLoop

CommandSetGlobalAttenuation:
        call ReadGemsCommandRing
        ld (zRamGlobalAttenuation),a
        jp GemsMainLoop

; SequenceHeaderBuffer: Z80 $0BBD..$0BDD
z80Data_SequenceHeaderBuffer:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        db $00

; StartingSequenceId: Z80 $0BDE..$0BDE
z80Data_StartingSequenceId:
        db $00

StartSequence:
; A=sequence ID. ReadLE16 bank offset then33-byte header (count+16 offsets). Allocate first free/unreserved channels, flags&$21==0; partial allocation is retained if space runs out. Repeated start can create another instance. No upper count/index validation.
        ld d,0
        ld (zRamStartingSequenceId),a
        ld e,a
        sla e
        rl d
        ld hl,(zRamSequenceBankLo)
        ld a,(zRamSequenceBankHi)
        add hl,de
        adc a,0
        ld c,2
        ld de,zRamSequenceHeader
        call CopyRomBytes
        ld de,(zRamSequenceHeader)
        ld hl,(zRamSequenceBankLo)
        ld a,(zRamSequenceBankHi)
        add hl,de
        adc a,0
        ld c,0x21
        ld de,zRamSequenceHeader
        call CopyRomBytes
        ld a,(zRamSequenceHeader)
        or a
        ret z
        ld ix,zRamLogicalChannels
        ld iy,zRamBasePitchLo
        ld de,0x20
        ld c,0
        ld hl,zRamSequenceTrackOffsets
        ld b,0x10

FindChannelForSequenceTrack:
; Initialize flags=$11,cursor/cache,delay counter=$FFFF,sequence/track,loop counts,priority/modulation/attenuation and base/modulated pitch. Keep old delay VALUE, duration, patch ID/buffer, loop cursor bytes, dirty pitch and byte31. No rollback or automatic note-off.
        ld a,(ix+channelFlags)
        and 0x21
        jr nz,NextChannelForSequenceStart
        ld (ix+channelFlags),0x11
        ld a,(zRamSequenceBankLo)
        add a,(hl)
        inc hl
        ld (ix+channelCursorLo),a
        ld a,(zRamSequenceBankMid)
        adc a,(hl)
        inc hl
        ld (ix+channelCursorMid),a
        ld a,(zRamSequenceBankHi)
        adc a,0
        ld (ix+channelCursorHi),a
        ld (ix+channelCacheBaseLo),0xff
        ld (ix+channelCacheBaseMid),0xff
        ld (ix+channelCacheBaseHi),0xff
        ld (ix+channelDelayCounterLo),0xff
        ld (ix+channelDelayCounterHi),0xff
        ld a,(zRamStartingSequenceId)
        ld (ix+channelSequence),a
        ld (ix+channelTrack),c
        ld (ix+channelLoop0Count),0
        ld (ix+channelLoop1Count),0
        ld (ix+channelLoop2Count),0
        ld (ix+channelLoop3Count),0
        ld (ix+channelModulation),0
        ld (ix+channelPriority),0
        ld (ix+channelAttenuation),0
        ld (iy+pitchModulationLo),0
        ld (iy+pitchModulationHi),0
        ld (iy),0
        ld (iy+pitchBaseHi),0
        inc c
        ld a,(zRamSequenceHeader)
        cp c
        ret z

NextChannelForSequenceStart:
        dec b
        ret z
        add ix,de
        inc iy
        jr FindChannelForSequenceTrack

StopSequence:
; Stop active, unreserved tracks matching A (A=$FF means all eligible sequences), then cleanup ALL voices whose owner is not running. Reserved SFX owners normally have running=0 and are also silenced by cleanup.
        ld ix,zRamLogicalChannels
        ld de,0x20
        ld b,0x10

z80_0CA9:
        bit 0,(ix+channelFlags)
        jr z,z80_0CCA
        bit 5,(ix+channelFlags)
        jr nz,z80_0CCA
        cp 0xff
        jr z,z80_0CBE
        cp (ix+channelSequence)
        jr nz,z80_0CCA

z80_0CBE:
        ld (ix+channelFlags),0
        ld (ix+channelDurationLo),0
        ld (ix+channelDurationHi),0

z80_0CCA:
        add ix,de
        dec b
        jr nz,z80_0CA9
        call SilenceInactiveChannelVoices
        ret

PauseSequence:
; Pause active, unreserved tracks whose sequence ID equals A. Then perform the same global inactive-owner cleanup; reservation does not protect an existing SFX hardware voice.
        ld ix,zRamLogicalChannels
        ld de,0x20
        ld b,0x10

z80_0CDC:
        bit 0,(ix+channelFlags)
        jr z,z80_0CF1
        bit 5,(ix+channelFlags)
        jr nz,z80_0CF1
        cp (ix+channelSequence)
        jr nz,z80_0CF1
        res 4,(ix+channelFlags)

z80_0CF1:
        add ix,de
        dec b
        jr nz,z80_0CDC
        call SilenceInactiveChannelVoices
        ret

; DriverState0CFA: Z80 $0CFA..$0CFA
z80Data_DriverState0CFA:
        db $00

SilenceInactiveChannelVoices:
; Global cleanup examines owner channel bit4, not the requested sequence ID. FM TLs ->127 then key-off; DAC streaming patched to RET and DAC disabled; PSG envelope flags <-4. Clear voice duration/age. Disable inactive modulation slots.
        ld ix,zRamFmVoices
        ld e,0
        call SilenceInactiveVoicePool
        ld ix,zRamPsgToneVoices
        ld e,1
        call SilenceInactiveVoicePool
        ld ix,zRamPsgNoiseVoice
        ld e,1
        call SilenceInactiveVoicePool
        ld iy,0xeac

z80_0D1A:
        inc iy
        ld a,(iy)
        bit 7,a
        ret nz
        bit 6,a
        jr nz,z80_0D1A
        ld b,0
        sla a
        sla a
        sla a
        sla a
        sla a
        ld c,a
        rl b
        ld hl,0x1b86
        add hl,bc
        bit 4,(hl)
        jp nz,z80_0D1A
        set 6,(iy)
        jr z80_0D1A

SilenceInactiveVoicePool:
        ld a,(ix)
        cp 0xff
        ret z
        ld d,a
        ld b,0
        ld c,(ix+voiceOwner)
        sla c
        sla c
        sla c
        sla c
        sla c
        rl b
        ld hl,0x1b86
        add hl,bc
        bit 4,(hl)
        jp nz,z80_0E06
        ld a,d
        and 7
        or 0x80
        ld (ix),a
        ld (ix+voiceDurationLo),0
        ld (ix+voiceDurationHi),0
        ld (ix+voiceReleaseAge),0
        and 7
        ld (0x0cfa),a
        bit 0,e
        jp nz,z80_0E0E
        bit 5,d
        jr z,z80_0D9A
        ld a,0xc9
        ld (ServiceDacSample),a
        ld (ServiceDacStream),a
        ld hl,0x4000
        ld (hl),0x2b
        inc hl
        ld (hl),0
        jp z80_0E06

z80_0D9A:
        ld d,0
        cp 3
        jr c,z80_0DA4
        sub 4
        ld d,2

z80_0DA4:
        push de
        ld e,a
        ld h,0x40
        ld l,0
        ld a,0x40
        add a,e
        ld b,a
        ld c,0x7f
        ld a,0x80

z80_0DB2:
        and (hl)
        jp m,z80_0DB2
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        ld l,0
        ld a,0x44
        add a,e
        ld b,a
        ld c,0x7f
        ld a,0x80

z80_0DC4:
        and (hl)
        jp m,z80_0DC4
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        ld l,0
        ld a,0x48
        add a,e
        ld b,a
        ld c,0x7f
        ld a,0x80

z80_0DD6:
        and (hl)
        jp m,z80_0DD6
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        ld l,0
        ld a,0x4c
        add a,e
        ld b,a
        ld c,0x7f
        ld a,0x80

z80_0DE8:
        and (hl)
        jp m,z80_0DE8
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        pop de
        ld a,(0x0cfa)
        ld iy,0x4000
        ld a,a

z80_0DF9:
        bit 7,(iy)
        jr nz,z80_0DF9
        ld (iy),0x28
        ld (iy+1),a

z80_0E06:
        ld bc,7
        add ix,bc
        jp SilenceInactiveVoicePool

z80_0E0E:
        ld iy,zRamPsgEnvelopes
        ld c,a
        ld b,0
        add iy,bc
        ld (iy),4
        jr z80_0E06

SetTempoIncrement:
; A=tempo byte. Store floor(A*436/256) as LE16 increment; preserve existing accumulator. Sequence$68 adds40 first with byte wrap; command$05 supplies its own input.
        ld de,0xda
        call MultiplyByteByWord
        xor a
        sla l
        rl h
        rla
        ld l,h
        ld h,a
        ld (zRamTempoIncrement),hl
        ret

StartPitchModulation:
; IX=logical channel, E=owner 0..15, C=envelope ID. Reuse exact owner byte, else first bit6-free slot; no slot stealing. Load LE16 table offset then fixed 32 bytes; initialize modulation accumulator/cursor but do NOT mark pitch dirty. Clobbers AF/BC/DE/HL/IX/IY.
        ld b,(ix+6)
        ld d,0
        ld iy,zRamBasePitchLo
        add iy,de
        ld ix,zRamModulationSlots

FindMatchingModulationSlot:
; Compare full owner byte to E. SFX-clock slots contain owner|$20, so they do not match plain owner 0..15: repeated SFX starts can allocate duplicate slots. Preserved original behavior.
        ld a,(ix)
        bit 7,a
        jr nz,z80_0E4C
        cp e
        jr z,LoadModulationSlot
        inc ix
        jr FindMatchingModulationSlot

z80_0E4C:
        ld ix,zRamModulationSlots

FindFreeModulationSlot:
        ld a,(ix)
        bit 7,a
        ret nz
        bit 6,a
        jr nz,LoadModulationSlot
        inc ix
        jr FindFreeModulationSlot

LoadModulationSlot:
; Set owner plus SFX-clock bit5 and remaining=0. SLA C is not followed by RL B: envelope IDs128..255 alias IDs0..127. Four buffers at $1E80/$1EA0/$1EC0/$1EE0; no stream refill or length validation.
        bit 3,b
        jr z,z80_0E64
        set 5,e

z80_0E64:
        ld (ix),e
        ld (ix+modTicksRemaining),0
        ld b,0
        sla c
        ld hl,(zRamEnvelopeBankLo)
        ld a,(zRamEnvelopeBankHi)
        add hl,bc
        adc a,0
        ld c,2
        ld de,zRamResourceOffsetScratch
        call CopyRomBytes
        ld de,(zRamResourceOffsetScratch)
        ld hl,(zRamEnvelopeBankLo)
        ld a,(zRamEnvelopeBankHi)
        add hl,de
        adc a,0
        ld c,0x20
        ld d,0x1e
        ld e,(ix+modBufferOffset)
        call CopyRomBytes
        ld d,0x1e
        ld e,(ix+modBufferOffset)
        ld a,(de)
        ld (iy+pitchModulationLo),a
        inc de
        ld a,(de)
        ld (iy+pitchModulationHi),a
        inc de
        ld (ix+modCursorLo),e
        ld (ix+modCursorHi),d
        ret

; ModulationOwnersAndSentinel: Z80 $0EAD..$0EB1
z80Data_ModulationOwnersAndSentinel:
        db $40,$40,$40,$40,$FF

; ModulationCursorLow: Z80 $0EB2..$0EB5
z80Data_ModulationCursorLow:
        db $00,$00,$00,$00

; ModulationCursorHigh: Z80 $0EB6..$0EB9
z80Data_ModulationCursorHigh:
        db $00,$00,$00,$00

; ModulationTickCounters: Z80 $0EBA..$0EBD
z80Data_ModulationTickCounters:
        db $00,$00,$00,$00

; ModulationDeltaLow: Z80 $0EBE..$0EC1
z80Data_ModulationDeltaLow:
        db $00,$00,$00,$00

; ModulationDeltaHigh: Z80 $0EC2..$0EC5
z80Data_ModulationDeltaHigh:
        db $00,$00,$00,$00

; ModulationBufferOffsets: Z80 $0EC6..$0EC9
z80Data_ModulationBufferOffsets:
        db $80,$A0,$C0,$E0

ServicePitchModulation:
; Four-slot pitch modulation, not PSG volume envelopes. Ignore free bit6 slots; choose music tick bit1 or SFX tick bit0 via owner bit5. Terminator bit7 ends scan.
        ld ix,zRamModulationSlots

z80_0ECE:
        call ServiceDacSample
        ld c,(ix)
        bit 7,c
        ret nz
        bit 6,c
        jr z,SelectModulationClock

z80_0EDB:
        inc ix
        jr z80_0ECE

SelectModulationClock:
        ld a,(zRamSoundTickFlags)
        bit 5,c
        jr nz,z80_0EEC
        bit 1,a
        jr nz,AdvanceModulationSegment
        jr z80_0EDB

z80_0EEC:
        bit 0,a
        jr z,z80_0EDB

AdvanceModulationSegment:
; Counter0 loads duration/delta from cursor. Duration0 terminates and clears accumulated modulation; durationN applies its signed LE16 delta N times, first step immediately. Cursor advances3 only on a new nonzero segment.
        ld a,(ix+modTicksRemaining)
        sub 1
        jr nc,ApplyModulationDelta
        ld l,(ix+modCursorLo)
        ld h,(ix+modCursorHi)
        ld a,(hl)
        sub 1
        jr c,FinishPitchModulation
        inc hl
        ld b,(hl)
        ld (ix+modDeltaLo),b
        inc hl
        ld b,(hl)
        ld (ix+modDeltaHi),b
        inc hl
        call ServiceDacSample
        ld (ix+modCursorLo),l
        ld (ix+modCursorHi),h

ApplyModulationDelta:
; Add signed delta to owner modulation pitch modulo65536. Multiple slots with the same owner accumulate in scan order. Store remaining N-1 and mark pitch dirty.
        ld iy,zRamBasePitchLo
        ld b,0
        res 5,c
        add iy,bc
        ld (ix+modTicksRemaining),a
        ld a,(iy+pitchModulationLo)
        add a,(ix+modDeltaLo)
        ld (iy+pitchModulationLo),a
        ld a,(iy+pitchModulationHi)
        adc a,(ix+modDeltaHi)
        ld (iy+pitchModulationHi),a

MarkModulatedPitchDirty:
        set 0,(iy+pitchDirty)
        ld a,1
        ld (zRamPitchUpdatePending),a
        jr z80_0EDB

FinishPitchModulation:
; Clear owner modulation pitch, mark slot free ($40), then mark pitch dirty. Termination snaps to base pitch; it does not hold the last envelope value.
        ld iy,zRamBasePitchLo
        ld b,0
        res 5,c
        add iy,bc
        ld (iy+pitchModulationLo),0
        ld (iy+pitchModulationHi),0
        ld (ix),0x40
        jr MarkModulatedPitchDirty

ReadChannelPitchCommand:
; A=logical channel. Consume pitch low/high bytes, write split base-pitch arrays, mark dirty. Does not clear existing modulation. Preserves only what caller explicitly saved.
        ld c,a
        ld b,0
        ld ix,zRamBasePitchLo
        add ix,bc
        call ReadGemsCommandRing
        ld (ix),a
        call ReadGemsCommandRing
        ld (ix+pitchBaseHi),a
        set 0,(ix+pitchDirty)
        ld a,1
        ld (zRamPitchUpdatePending),a
        ret

; PitchUpdatePending: Z80 $0F77..$0F77
z80Data_PitchUpdatePending:
        db $00

; ChannelBasePitchLow: Z80 $0F78..$0F87
z80Data_ChannelBasePitchLow:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; ChannelBasePitchHigh: Z80 $0F88..$0F97
z80Data_ChannelBasePitchHigh:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; ChannelModulationPitchLow: Z80 $0F98..$0FA7
z80Data_ChannelModulationPitchLow:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; ChannelModulationPitchHigh: Z80 $0FA8..$0FB7
z80Data_ChannelModulationPitchHigh:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; ChannelPitchDirtyFlags: Z80 $0FB8..$0FC7
z80Data_ChannelPitchDirtyFlags:
        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

ApplyDirtyChannelPitches:
; If global pending: update all six FM and three PSG-tone records whose OWNER is dirty, then clear all16 dirty bytes. No available/reserved/DAC flag filter and no PSG-noise-record loop. IRQ hook precedes scan.
        ld a,(zRamPitchUpdatePending)
        or a
        ret z
        xor a
        ld (zRamPitchUpdatePending),a
        call ServicePendingGemsInterrupt
        ld iy,zRamFmVoices

UpdateFmVoicePitch:
; Use voice note/owner even for released or reserved entries. Write high frequency register $A4 before low $A0 on the proper YM port.
        call ServiceDacSample
        ld a,(iy)
        cp 0xff
        jr z,z80_1045
        and 7
        ld b,a
        ld c,(iy+2)
        ld e,(iy+3)
        ld a,0
        ld ix,zRamBasePitchLo
        ld d,0
        add ix,de
        bit 0,(ix+pitchDirty)
        jr z,z80_103E
        call NoteToChipFrequency
        ld (zRamFmFrequencyScratch),de
        ld d,0
        ld a,b
        cp 3
        jr c,z80_100D
        sub 4
        ld d,2

z80_100D:
        ld e,a
        ld h,0x40
        push iy
        ld iy,zRamFmFrequencyScratch
        ld l,0
        ld a,0xa4
        add a,e
        ld b,a
        ld c,(iy+1)
        ld a,0x80

z80_1021:
        and (hl)
        jp m,z80_1021
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        ld l,0
        ld a,0xa0
        add a,e
        ld b,a
        ld c,(iy)
        ld a,0x80

z80_1034:
        and (hl)
        jp m,z80_1034
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        pop iy

z80_103E:
        ld de,7
        add iy,de
        jr UpdateFmVoicePitch

z80_1045:
        ld iy,zRamPsgToneVoices

UpdatePsgTonePitch:
; Update three PSG tone dividers; noise clock may share tone3. Write latch/low nibble followed by divider high bits.
        call ServiceDacSample
        ld a,(iy)
        cp 0xff
        jr z,ClearChannelPitchDirtyFlags
        and 7
        ld b,a
        ld c,(iy+2)
        ld e,(iy+3)
        ld a,1
        ld ix,zRamBasePitchLo
        ld d,0
        add ix,de
        bit 0,(ix+pitchDirty)
        jr z,z80_1095
        call NoteToChipFrequency
        call ServiceDacSample
        rrc b
        rrc b
        rrc b
        ld a,e
        and 15
        or 0x80
        or b
        ld (0x7f11),a
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        ld a,e
        ld (0x7f11),a

z80_1095:
        ld de,7
        add iy,de
        jr UpdatePsgTonePitch

ClearChannelPitchDirtyFlags:
        ld hl,zRamChannelPitchDirty
        ld a,0x10

z80_10A1:
        ld (hl),0
        inc hl
        dec a
        jr nz,z80_10A1
        ret

; ResolvedPitchScratch: Z80 $10A8..$10A9
z80Data_ResolvedPitchScratch:
        dw $0000 ; low=resolved fraction; high=raw summed offset high byte

NoteToChipFrequency:
; A bit0: 0=FM,1=PSG; C=note0..95; IX=owner base-pitch low byte. Sum base+modulation modulo16 bits (signed8.8 semitones), saturate note to0..95+255/256; PSG additionally clamps below33. Return DE=YM block/F-number or PSG divider. Preserve BC/HL; clobber AF/DE/IX and resolved-pitch scratch.
        push bc
        push hl
        call ServiceDacSample
        ld b,a
        ld a,(ix)
        add a,(ix+pitchModulationLo)
        ld e,a
        ld a,(ix+pitchBaseHi)
        adc a,(ix+pitchModulationHi)
        ld d,a
        ld (zRamResolvedPitchScratch),de
        call ServiceDacSample
        ld a,c
        add a,d
        cp 0x60
        jr c,SelectChipFrequencyTable
        bit 7,d
        jr z,ClampPitchUpper
        ld a,0
        ld (zRamResolvedPitchScratch),a
        jr SelectChipFrequencyTable

ClampPitchUpper:
; Upper clamp uses note95 and fraction255. Lower clamp uses note0/fraction0; raw signed offset high byte remains in scratch.
        ld a,0xff
        ld (zRamResolvedPitchScratch),a
        ld a,0x5f

SelectChipFrequencyTable:
        call ServiceDacSample
        bit 0,b
        jr nz,ClampPsgLowNote
        ld c,0
        cp 0x30
        jr c,z80_10EE
        sub 0x30
        set 2,c

z80_10EE:
        cp 0x18
        jr c,z80_10F6
        sub 0x18
        set 1,c

z80_10F6:
        cp 12
        jr c,z80_10FE
        sub 12
        set 0,c

z80_10FE:
        ld ix,FmSemitoneFNumbers
        jr InterpolateChipFrequency

ClampPsgLowNote:
; PSG table starts at note33. Lower effective notes use entry0/fraction0 (divider1017); do not read before the table.
        sub 0x21
        jr nc,z80_110D
        ld a,0
        ld (zRamResolvedPitchScratch),a

z80_110D:
        ld ix,PsgTonePeriods

InterpolateChipFrequency:
; Linear interpolation: table[n] + floor((table[n+1]-table[n])*fraction/256). Negative PSG deltas round downward. FM then ORs block<<11. Tables include an endpoint for the final interval.
        rlca
        ld e,a
        ld d,0
        add ix,de
        call ServiceDacSample
        ld a,(ix+2)
        sub (ix)
        ld e,a
        ld a,(ix+3)
        sbc a,(ix+1)
        ld d,a
        ld a,(zRamResolvedPitchScratch)
        call MultiplyByteByWord
        call ServiceDacSample
        ld l,0
        bit 7,h
        jr z,z80_1139
        ld l,0xff

z80_1139:
        ld a,(ix)
        add a,h
        ld e,a
        ld a,(ix+1)
        adc a,l
        ld d,a
        bit 0,b
        jr nz,z80_114D
        ld a,c
        rlca
        rlca
        rlca
        or d
        ld d,a

z80_114D:
        pop hl
        pop bc
        call ServiceDacSample
        ret

GetChannelPatchBuffer:
        ld hl,zRamChannelPatches
        ld de,0x27
        jr AccumulateByteWordProduct

MultiplyByteByWord:
; A unsigned8, DE 16-bit multiplicand; return HL=(A*DE) mod65536. Signed deltas rely on two-complement wrap. Shared with tempo, attenuation and channel-offset calculations.
        ld hl,0

AccumulateByteWordProduct:
; Shared multiply entry with caller-provided initial HL: GetChannelPatchBuffer supplies the patch-array base and DE=39.
        srl a
        jr nc,z80_1163
        add hl,de

z80_1163:
        ret z
        sla e
        rl d
        jr AccumulateByteWordProduct

; FmSemitoneFNumbers: Z80 $116A..$1183
z80Data_FmSemitoneFNumbers:
; FM: 12 semitones plus next-octave endpoint; block added at runtime
        dw $0284,$02AA,$02D3,$02FE,$032B,$035B,$038E,$03C5
        dw $03FE,$043B,$047B,$04BF,$0508

; PsgTonePeriods: Z80 $1184..$1203
z80Data_PsgTonePeriods:
; PSG: notes33..95 plus interpolation endpoint (last divider duplicated)
        dw $03F9,$03C0,$038A,$0357,$0327,$02FA,$02CF,$02A7
        dw $0281,$025D,$023B,$021B,$01FC,$01E0,$01C5,$01AC
        dw $0194,$017D,$0168,$0153,$0140,$012E,$011D,$010D
        dw $00FE,$00F0,$00E2,$00D6,$00CA,$00BE,$00B4,$00AA
        dw $00A0,$0097,$008F,$0087,$007F,$0078,$0071,$006B
        dw $0065,$005F,$005A,$0055,$0050,$004C,$0047,$0043
        dw $0040,$003C,$0039,$0035,$0032,$002F,$002D,$002A
        dw $0028,$0026,$0023,$0021,$0020,$001E,$001C,$001C

; PendingNoteAndChannel: Z80 $1204..$1205
z80Data_PendingNoteAndChannel:
        db $00,$00

; HardwareVoiceId: Z80 $1206..$1206
z80Data_HardwareVoiceId:
        db $00

; NoteAttenuation: Z80 $1207..$1207
z80Data_NoteAttenuation:
        db $00

PlayInstrumentNote:
; Compute note attenuation from global + channel byte; if wrapped result bit7 set use127. Inputs0..127 give saturation at127. Save pending note/owner, then dispatch patch type. FM attenuation is applied only to carriers. See docs/GEMS_FM.md.
        call ServiceDacSample
        ld a,(zRamGlobalAttenuation)
        add a,(ix+0x1e)
        jp p,z80_1216
        ld a,0x7f

z80_1216:
        ld (zRamNoteAttenuation),a
        ld (zRamPendingNoteAndChannel),bc
        call ServiceDacStream
        call ServicePendingGemsInterrupt
        ld hl,(zRamCurrentPatchBuffer)
        ld a,(hl)
        cp 0
        jp z,PlayFmNote
        cp 1
        jp z,PlayDacNote
        cp 2
        jp z,SelectPsgToneVoice
        cp 3
        jp z,SelectPsgNoiseVoice
        ret

SelectPsgNoiseVoice:
        ld iy,zRamPsgNoiseVoice
        call SelectDedicatedVoice
        jr CommitPsgNoteAndPitch

SelectPsgToneVoice:
        ld iy,zRamPsgToneVoices
        call SelectVoiceFromPool

CommitPsgNoteAndPitch:
; Reject A=$FF without hardware writes. Commit voice, compute PSG divider, then post envelope start. Ordinary tones do not write frequency/volume until envelope service; noise also programs/reserves tone3 immediately.
        cp 0xff
        ret z
        call CommitHardwareVoice
        ld a,1
        ld e,b
        ld ix,zRamBasePitchLo
        ld d,0
        add ix,de
        call NoteToChipFrequency

PreparePsgEnvelopeNote:
; Current patch pointer -> IX=patch+1, hardware ID -> envelope lane0..3. Store divider latch/high bytes. The global/channel attenuation computed at$1208 is NOT read by this PSG path.
        ld ix,(zRamCurrentPatchBuffer)
        inc ix
        ld a,(zRamHardwareVoiceId)
        ld c,a
        ld b,0
        ld iy,zRamPsgEnvelopes
        add iy,bc
        ld a,e
        and 15
        ld (iy+psgEnvelopeLatchValue),a
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        srl d
        rr e
        ld (iy+psgEnvelopePeriodHigh),e
        ld a,(zRamHardwareVoiceId)
        cp 3
        jr nz,LoadPsgEnvelopePatch
; Noise voice reserves PSG tone3 at $17CE. Test reads PATCH TYPE (IX-1), not noise-mode byte (IX): both original type3 patches take this branch even with fixed noise clock modes 5/6. Clear reservation on PSG noise release completion/kill ($0094/$0158).
        ld hl,zRamPsgNoiseClockVoice
        res 5,(hl)
        ld a,(ix-1)
        and 3
        cp 3
        jr nz,StorePsgNoiseControl
        ld hl,0x7f11
        ld a,(iy+psgEnvelopeLatchValue)
        or 0xc0
        ld (hl),a
        ld a,(iy+psgEnvelopePeriodHigh)
        ld (hl),a
        ld hl,zRamPsgNoiseClockVoice
        ld (hl),0xa2
        inc hl
        inc hl
        ld bc,(zRamPendingNoteAndChannel)
        ld (hl),c
        inc hl
        ld (hl),b
        ld hl,zRamPsgEnvelopes+2
        ld (hl),4

StorePsgNoiseControl:
        ld a,(ix+psgPatchNoiseControl)
        ld (iy+psgEnvelopeLatchValue),a

LoadPsgEnvelopePatch:
; IX=patch+1, IY=envelope lane. attack=patch+2; sustain=(patch+3 low nibble)<<4; attack target=(patch+4 low nibble)<<4; decay step=patch+5; release step=patch+6. OR start into pending command; no immediate level/phase reset.
        ld a,(ix+psgPatchAttackStep)
        ld (iy+psgEnvelopeAttackStep),a
        ld a,(ix+psgPatchSustainLevel)
        sla a
        sla a
        sla a
        sla a
        ld (iy+psgEnvelopeSustainLevel),a
        ld a,(ix+psgPatchAttackTarget)
        sla a
        sla a
        sla a
        sla a
        ld (iy+psgEnvelopeAttackTarget),a
        ld a,(ix+psgPatchDecayStep)
        ld (iy+psgEnvelopeDecayStep),a
        ld a,(ix+psgPatchReleaseStep)
        ld (iy+psgEnvelopeReleaseStep),a
        set 0,(iy+psgEnvelopeCommand)
        ret

PlayDacNote:
        ld iy,zRamDacVoice
        call SelectDedicatedVoice
        cp 0xff
        ret z
        bit 7,a
        jr nz,z80_1326
        ld a,0xc9
        ld (ServiceDacSample),a
        ld a,(hl)
        bit 5,a
        jr nz,z80_1326
        and 7
        ld iy,0x4000
        ld a,a

z80_1318:
        bit 7,(iy)
        jr nz,z80_1318
        ld (iy),0x28
        ld (iy+1),a
        ld a,(hl)

z80_1326:
        call CommitHardwareVoice
        ld hl,zRamDacVoice
        set 5,(hl)

TranslateDacNote:
        ld a,c
        sub 0x30
        jr nc,z80_1335
        add a,0x60

z80_1335:
        ld c,a
        ld b,0
        ld hl,(zRamSampleBankLo)
        ld a,(zRamSampleBankHi)
        sla c
        rl b
        sla c
        rl b
        add hl,bc
        adc a,0
        sla c
        rl b
        add hl,bc
        adc a,0
        ld c,12
        ld de,zRamDacDescriptorFlags
        call CopyRomBytes
        ld bc,(zRamDacDescriptorLength)
        ld a,b
        or c
        jr nz,ApplyDacRateOverride
        ld hl,zRamDacVoice
        ld (hl),0xc6
        ret

ApplyDacRateOverride:
; Patch byte1=4 preserves descriptor flags/rate; otherwise OR patch byte into flags&$F0. Original game overrides are valid rates; arbitrary high bits are not masked here.
        ld hl,(zRamCurrentPatchBuffer)
        inc hl
        ld a,(hl)
        cp 4
        jr z,StartDacDescriptor
        ld b,a
        ld a,(zRamDacDescriptorFlags)
        and 0xf0
        or b
        ld (zRamDacDescriptorFlags),a

StartDacDescriptor:
; Use 12-byte descriptor at $1423. Timer-A period from low nibble; YM DAC enabled before prime. Source=sampleBank+offset24+skip16; remaining=length (skip is NOT subtracted). No short/loop-length validation.
        exx
        ld e,0
        ld (hl),0x24
        inc hl
        ld a,(zRamDacDescriptorFlags)
        and 15
        neg
        sra a
        sra a
        ld (hl),a
        dec hl
        ld (hl),0x25
        inc hl
        ld a,(zRamDacDescriptorFlags)
        and 15
        neg
        and 3
        ld (hl),a
        dec hl
        ld (hl),0x2b
        inc hl
        ld (hl),0x80
        dec hl
        ld (hl),0x27
        inc hl
        ld (hl),b
        dec hl
        exx
        ld iy,0x4002
        ld a,0xc0

z80_13AC:
        bit 7,(iy)
        jr nz,z80_13AC
        ld (iy),0xb6
        ld (iy+1),a
        ld bc,(zRamSampleBankLo)
        ld a,(zRamSampleBankHi)
        ld d,a
        ld hl,(zRamDacDescriptorOffsetLo)
        ld a,(zRamDacDescriptorOffsetHi)
        add hl,bc
        adc a,d
        ld bc,(zRamDacDescriptorSkip)
        add hl,bc
        adc a,0
        ld (zRamDacSourceLo),hl
        ld (zRamDacSourceHi),a
        ld hl,(zRamDacDescriptorLength)
        ld (zRamDacRemaining),hl
        ld a,0
        ld (ServiceDacStream),a
        ld (zRamDacWriteHalf),a
        ld a,(zRamDacDescriptorFlags)
        bit 4,a
        ld a,4
        jr z,PrimeAndEnableDac
        inc a

PrimeAndEnableDac:
; Mode4 one-shot or5 loop. Prime before enabling sample service and selecting rate/format overlays. For synthetic length<=128, prime can stop DAC, yet this path re-enables the sample hook afterward; original nonempty lengths are all >128.
        ld (zRamDacStreamMode),a
        call PrimeDacBuffer
        ld a,0xd9
        ld (ServiceDacSample),a
        ld a,8
        ld (0x02b8),a
        ld a,(zRamDacDescriptorFlags)
        and 15
        cp 10
        ld a,0
        jr nc,PatchDacRateGate
        ld a,0xc9

PatchDacRateGate:
; Divisor>=10 writes NOP to $02CF; smaller divisor writes RET. Slow path inserts a re-arm-only service call between output calls; not a fixed promise of half sample rate.
        ld (DacRateGate),a
        ld a,(zRamDacDescriptorFlags)
        bit 7,a
        ld hl,0
        jr z,PatchDacFormat
        ld hl,(zRamSavedDacFormat)
        exx
        ld c,0xaa
        exx

PatchDacFormat:
; Write two NOPs for unsigned8 PCM, or saved JR for packed4 PCM (C'=$AA). Original ZT descriptors never set packed bit7.
        ld (DacFormatGate),hl
        ret

; DacSampleDescriptor: Z80 $1423..$142E
z80Data_DacSampleDescriptor:
        db $00 ; flags: rate low4, loop bit4, stop-on-note-off bit5, packed bit7
        dw $0000 ; ROM offset low16
        db $00 ; ROM offset high8
        dw $0000 ; skip
        dw $0000 ; length
        dw $0000 ; loop length
        dw $0000 ; descriptor final field, not consumed by this stream routine

; FmFrequencyScratch: Z80 $142F..$1430
z80Data_FmFrequencyScratch:
        dw $0000 ; FM frequency scratch, not part of the DAC descriptor

PlayFmNote:
; HL=type0 patch start, IX=logical channel, B=owner, C=note. Patch timer-mode bit6 selects dedicated FM3; otherwise generic FM pool. Reject without hardware writes. A busy accepted voice receives key-off before commit/program/key-on.
        inc hl
        inc hl
        ld d,(hl)
        bit 6,d
        jr z,SelectOrdinaryFmVoice
        ld iy,zRamSpecialFmVoice
        call SelectDedicatedVoice
        jr AcceptOrRejectFmVoice

SelectOrdinaryFmVoice:
        ld iy,zRamFmVoices
        call SelectVoiceFromPool

AcceptOrRejectFmVoice:
        call ServiceDacSample
        cp 0xff
        ret z
        bit 7,a
        jr nz,CommitFmNoteAndPitch
        and 7
        ld iy,0x4000
        ld a,a

KeyOffReplacedFmVoice:
        bit 7,(iy)
        jr nz,KeyOffReplacedFmVoice
        ld (iy),0x28
        ld (iy+1),a
        ld a,(hl)

CommitFmNoteAndPitch:
        push de
        call CommitHardwareVoice
        pop de
        bit 6,d
        jr nz,ProgramFmPatch
        ld a,0
        ld e,b
        ld ix,zRamBasePitchLo
        ld d,0
        add ix,de
        call NoteToChipFrequency
        ld (zRamFmFrequencyScratch),de
        call ServiceDacSample

ProgramFmPatch:
; Program current FM patch after voice commit. IX becomes patch+1 (fields in gems_fm.inc are relative to this parameter base). Uses zRamHardwareVoiceId, zRamNoteAttenuation and precomputed frequency. Clobbers AF/BC/DE/HL/IX/IY; FM3 also changes alternate B used by DAC.
        ld ix,(zRamCurrentPatchBuffer)
        inc ix
        ld a,(zRamHardwareVoiceId)
        ld c,a
        ld iy,0x4000
        cp 2
        jr nz,SelectFmRegisterPort

SetFm3TimerMode:
; Only hardware key2 (FM3): alternate B=timerMode|$15 for later DAC timer acknowledgements; YM $27=timerMode|$05. Ordinary FM3 patch clears previous special mode when its mode bit6 is0.
        ld a,(ix+fmTimerMode)
        or 0x15
        exx
        ld b,a
        exx
        ld a,(ix+fmTimerMode)
        or 5
        ld h,a
        ld l,0x27

z80_14A7:
        bit 7,(iy)
        jr nz,z80_14A7
        ld a,l
        ld (0x4000),a
        ld a,h
        ld (0x4001),a

SelectFmRegisterPort:
        ld d,0
        ld a,c
        cp 3
        jr c,MaybeEnableFmLfo
        sub 4
        ld d,2

MaybeEnableFmLfo:
; D=port0/2, E=channel0..2. Write shared YM $22 only if patch LFO bit3 is SET; disabled flag skips the write and leaves previous global LFO state. None of the54 shipped FM patches sets this bit.
        ld e,a
        ld h,(ix+fmLfoControl)
        bit 3,h
        jr z,ProgramFmOperators
        ld l,0x22

z80_14CA:
        bit 7,(iy)
        jr nz,z80_14CA
        ld a,l
        ld (0x4000),a
        ld a,h
        ld (0x4001),a

ProgramFmOperators:
; Algorithm low3 selects carrier mask. Register writer visits patch slots0,2,1,3. Masks are relative to that traversal order, not adjacent patch-block order.
        push bc
        ld hl,FmAlgorithmCarrierMasks
        ld b,0
        ld a,(ix+fmFeedbackAlgorithm)
        and 7
        ld c,a
        add hl,bc
        ld a,(hl)
        ld (zRamFmCarrierMask),a
        ld h,0x40
        ld bc,FmRegisterMap
        call WriteFmRegisterMap
        bit 6,(ix+fmTimerMode)
        jr nz,WriteFm3OperatorFrequencies

WriteFmNoteFrequency:
; Ordinary note writes high frequency $A4+channel then low $A0+channel on selected port. No separate key-on until all patch/frequency writes finish.
        ld iy,zRamFmFrequencyScratch
        ld l,0
        ld a,0xa4
        add a,e
        ld b,a
        ld c,(iy+1)
        ld a,0x80

z80_1506:
        and (hl)
        jp m,z80_1506
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        ld l,0
        ld a,0xa0
        add a,e
        ld b,a
        ld c,(iy)
        ld a,0x80

z80_1519:
        and (hl)
        jp m,z80_1519
        ld l,d
        ld (hl),b
        inc l
        ld (hl),c
        jp KeyOnFmPatchOperators

WriteFm3OperatorFrequencies:
; Timer-mode bit6: use eight raw patch bytes for $A6,$A2,$AC,$A8,$AD,$A9,$AE,$AA on port0. Note-derived pitch calculation was skipped. No shipped FM patch uses this mode.
        ld iy,0x4000
        ld a,(ix+fmSpecialFrequencyA6)

z80_152B:
        bit 7,(iy)
        jr nz,z80_152B
        ld (iy),0xa6
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyA2)

z80_153B:
        bit 7,(iy)
        jr nz,z80_153B
        ld (iy),0xa2
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyAC)

z80_154B:
        bit 7,(iy)
        jr nz,z80_154B
        ld (iy),0xac
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyA8)

z80_155B:
        bit 7,(iy)
        jr nz,z80_155B
        ld (iy),0xa8
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyAD)

z80_156B:
        bit 7,(iy)
        jr nz,z80_156B
        ld (iy),0xad
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyA9)

z80_157B:
        bit 7,(iy)
        jr nz,z80_157B
        ld (iy),0xa9
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyAE)

z80_158B:
        bit 7,(iy)
        jr nz,z80_158B
        ld (iy),0xae
        ld (iy+1),a
        ld a,(ix+fmSpecialFrequencyAA)

z80_159B:
        bit 7,(iy)
        jr nz,z80_159B
        ld (iy),0xaa
        ld (iy+1),a

KeyOnFmPatchOperators:
; Shift low four patch key bits to YM $28 bits4..7, OR hardware key0/1/2/4/5/6. Key mask can omit operators; trailing patch byte is not consumed here.
        ld a,(ix+fmOperatorKeyMask)
        sla a
        sla a
        sla a
        sla a
        pop bc
        or c
        ld iy,0x4000
        ld a,a

z80_15BA:
        bit 7,(iy)
        jr nz,z80_15BA
        ld (iy),0x28
        ld (iy+1),a
        ret

; FmAlgorithmCarrierMasks: Z80 $15C8..$15CF
z80Data_FmAlgorithmCarrierMasks:
; Carrier bits in register traversal order: patch slots0,2,1,3
        db $08,$08,$08,$08,$0A,$0E,$0E,$0F ; algorithms0..7

; FmCarrierMaskScratch: Z80 $15D0..$15D0
z80Data_FmCarrierMaskScratch:
        db $00 ; mutable carrier bits consumed by RR

; GlobalAttenuation: Z80 $15D1..$15D1
z80Data_GlobalAttenuation:
        db $00 ; global attenuation, added to channel attenuation at note start

WriteFmRegisterMap:
; BC=register/parameter-index stream terminated by register0; IX=patch+1; H=$40,D=port,E=channel. Parameter0 writes literal0 (SSG-EG reset), NOT a skip. Positive index copies parameter; negative/high-bit index tests next carrier bit and optionally scales TL.
        ld a,(bc)
        or a
        ret z
        inc bc
        ld l,0

z80_15D8:
        bit 7,(hl)
        jr nz,z80_15D8
        ld l,d
        add a,e
        ld (hl),a
        inc l
        ld a,(bc)
        or a
        jp z,WriteFmParameterValue
        jp p,ReadFmPatchParameter

SelectFmCarrierLevel:
; Strip index marker, RR mutable mask and test shifted-out bit. AND cleared carry before RR. Carrier masks correspond to traversal slots0,2,1,3.
        and 0x7f
        push hl
        ld hl,zRamFmCarrierMask
        rr (hl)
        jp nc,z80_1612
        push de
        ld (zRamFmCarrierReadOperand),a

ScaleFmCarrierLevel:
; For TL t and attenuation a in0..127: t + floor((127-t)*a/128). Only carriers use this; modulators retain raw TL. At a=127 and t<127 the result is126, not127. Silence/stop is separate.
        ld a,0x7f
; Self-modified displacement zRamFmCarrierReadOperand: +5,+11,+17,+23 relative to patch+1. Original encoded displacement0 is replaced before SUB executes.
        sub (ix)
        push af
        sla a
        ld e,a
        ld d,0
        ld a,(zRamNoteAttenuation)
        call MultiplyByteByWord
        pop af
        sub h
        ld h,a
        ld a,0x7f
        sub h
        pop de
        pop hl
        jr WriteFmParameterValue

z80_1612:
        pop hl

ReadFmPatchParameter:
; Patch the displacement of the following LD to the selected field. Parameter indexes2..27; original zero operand is only a mutable placeholder.
        ld (zRamFmParameterReadOperand),a
; Self-modified displacement zRamFmParameterReadOperand; read raw parameter for ordinary fields or a modulator TL.
        ld a,(ix)

WriteFmParameterValue:
        ld (hl),a
        inc bc
        jp WriteFmRegisterMap

; FmRegisterMap: Z80 $161E..$165A
z80Data_FmRegisterMap:
        db $B0,fmFeedbackAlgorithm
        db $B4,fmPanAmsFms
        db $30,fmSlot0DetuneMultiple
        db $40,fmSlot0TotalLevel+$80
        db $50,fmSlot0RateScaleAttack
        db $60,fmSlot0AmDecay
        db $70,fmSlot0SustainRate
        db $80,fmSlot0SustainRelease
        db $90,0 ; literal zero: disable SSG-EG
        db $38,fmSlot2DetuneMultiple
        db $48,fmSlot2TotalLevel+$80
        db $58,fmSlot2RateScaleAttack
        db $68,fmSlot2AmDecay
        db $78,fmSlot2SustainRate
        db $88,fmSlot2SustainRelease
        db $98,0 ; literal zero: disable SSG-EG
        db $34,fmSlot1DetuneMultiple
        db $44,fmSlot1TotalLevel+$80
        db $54,fmSlot1RateScaleAttack
        db $64,fmSlot1AmDecay
        db $74,fmSlot1SustainRate
        db $84,fmSlot1SustainRelease
        db $94,0 ; literal zero: disable SSG-EG
        db $3C,fmSlot3DetuneMultiple
        db $4C,fmSlot3TotalLevel+$80
        db $5C,fmSlot3RateScaleAttack
        db $6C,fmSlot3AmDecay
        db $7C,fmSlot3SustainRate
        db $8C,fmSlot3SustainRelease
        db $9C,0 ; literal zero: disable SSG-EG
        db $00 ; register-map terminator

CommitHardwareVoice:
; HL=selected 7-byte voice; IX=logical channel; A=old hardware flags. Replace owner/note/priority/duration, set release age=$FE and optional duration/SFX-clock bits. Retrigger bit6 may start modulation via $0E2F.
        and 7
        ld (zRamHardwareVoiceId),a
        ld (hl),a
        ld e,(ix+channelDurationLo)
        ld d,(ix+channelDurationHi)
        ld a,d
        or e
        jr z,z80_166D
        set 4,(hl)

z80_166D:
        bit 3,(ix+channelFlags)
        jr z,z80_1675
        set 3,(hl)

z80_1675:
        inc hl
        ld a,(ix+channelPriority)
        ld (hl),a
        ld bc,(zRamPendingNoteAndChannel)
        inc hl
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld (hl),e
        inc hl
        ld (hl),d
        inc hl
        ld (hl),0xfe
        call ServiceDacSample
        bit 6,(ix+channelFlags)
        ret z
        push bc
        ld c,(ix+channelModulation)
        ld e,b
        call StartPitchModulation
        call ServiceDacSample
        pop bc
        ret

; DriverState169E: Z80 $169E..$169F
z80Data_DriverState169E:
        db $00,$00

ReleaseChannelNote:
        ld (0x169e),bc
        ld ix,zRamFmVoices
        call ServiceDacSample
        call MarkMatchingVoiceReleased
        cp 0xff
        jr z,z80_16D1
        and 0x27
        cp 0x26
        jr z,z80_16CD
        and 7
        ld iy,0x4000
        ld a,a

z80_16BF:
        bit 7,(iy)
        jr nz,z80_16BF
        ld (iy),0x28
        ld (iy+1),a
        ret

z80_16CD:
        call RequestDacNoteRelease
        ret

z80_16D1:
        ld bc,(0x169e)
        ld ix,zRamPsgToneVoices
        call ServiceDacSample
        call MarkMatchingVoiceReleased
        cp 0xff
        jr z,z80_16F3
        and 3
        ld ix,zRamPsgEnvelopes
        ld c,a
        ld b,0
        add ix,bc
        set 1,(ix)
        ret

z80_16F3:
        ld bc,(0x169e)
        ld ix,zRamPsgNoiseVoice
        call ServiceDacSample
        call MarkMatchingVoiceReleased
        cp 0xff
        ret z
        and 3
        ld ix,zRamPsgEnvelopes
        ld c,a
        ld b,0
        add ix,bc
        set 1,(ix)
        ret

RequestDacNoteRelease:
; DAC note-off: descriptor bit5 -> stream state7 (stop at next stream service); else bit4 ->state6 (leave loop); neither -> no state change. Plain one-shot samples need not stop on note-off.
        ld a,(zRamDacDescriptorFlags)
        bit 5,a
        jr nz,z80_1722
        bit 4,a
        ret z
        ld a,6
        jr z80_1724

z80_1722:
        ld a,7

z80_1724:
        ld (zRamDacStreamMode),a
        ret

; DriverState1728: Z80 $1728..$1729
z80Data_DriverState1728:
        db $00,$00

z80_172A:
        call z80_08A5
        call GetChannelPatchBuffer
        ld (zRamCurrentPatchBuffer),hl
        call ReadGemsCommandRing
        ld (ix+13),a

LoadChannelPatch:
; Read current channel patch ID; ROM table usesLE16 offsets. Always copy39 bytes, including bytes following a short DAC/PSG patch. Readers consume only fields of selected type; no bank bounds check.
        ld d,0
        ld e,(ix+13)
        sla e
        rl d
        ld hl,(zRamPatchBankLo)
        ld a,(zRamPatchBankHi)
        add hl,de
        adc a,0
        ld c,2
        ld de,zRamResourceOffsetScratch
        call CopyRomBytes
        ld de,(zRamResourceOffsetScratch)
        ld hl,(zRamPatchBankLo)
        ld a,(zRamPatchBankHi)
        add hl,de
        adc a,0
        ld c,0x27
        ld de,(zRamCurrentPatchBuffer)
        call CopyRomBytes
        ret

z80_176A:
        ld b,a
        ld c,0x10
        ld ix,zRamLogicalChannels
        ld hl,zRamChannelPatches
        ld (zRamCurrentPatchBuffer),hl

z80_1777:
        ld a,b
        cp (ix+13)
        jr nz,z80_1782
        push bc
        call LoadChannelPatch
        pop bc

z80_1782:
        ld de,0x20
        add ix,de
        ld de,0x27
        ld hl,(zRamCurrentPatchBuffer)
        add hl,de
        ld (zRamCurrentPatchBuffer),hl
        dec c
        jr nz,z80_1777
        ret
; Mutable hardware voice records, not instrument patches. Each: flags, priority, note, logical owner, duration LE16, release age. Order of FM records affects equal-priority stealing.

; HardwareVoiceInitialState: Z80 $1795..$17E1
z80Data_HardwareVoiceInitialState:
; FM (hardware key codes 0,1,4,5,6,2): flags, priority, note, owner, duration low/high, release age
        db $80,$00,$50,$00,$00,$00,$00
        db $81,$00,$50,$00,$00,$00,$00
        db $84,$00,$50,$00,$00,$00,$00
        db $85,$00,$50,$00,$00,$00,$00
        db $86,$00,$50,$00,$00,$00,$00
        db $82,$00,$50,$00,$00,$00,$00
        db $FF ; pool terminator
; PSG tone: flags, priority, note, owner, duration low/high, release age
        db $80,$00,$50,$00,$00,$00,$00
        db $81,$00,$50,$00,$00,$00,$00
        db $82,$00,$50,$00,$00,$00,$00
        db $FF ; pool terminator
; PSG noise: flags, priority, note, owner, duration low/high, release age
        db $83,$00,$50,$00,$00,$00,$00
        db $FF ; pool terminator
        dw $0000,$0000 ; victim / available scratch pointers (little endian)

SelectVoiceFromPool:
; IY=terminated voice pool, IX=request channel, B=owner. Skip reserved bit5 (FM6/DAC or PSG tone3/noise clock). Prefer available same-owner voice unless sustain; else smallest release age; else lowest active priority, accepting ties. A=$FF rejects, otherwise HL=voice. Not FIFO among active equal priorities.
        ld c,0xff
        ld l,0xff
        ld de,7
        ld h,(ix+channelFlags)
        jr SelectVoice_Scan

z80_17EE:
        add iy,de

SelectVoice_Scan:
        call ServiceDacSample
        ld a,(iy)
        cp 0xff
        jr z,SelectVoice_ChooseAvailable
        bit 5,a
        jr nz,z80_17EE
        bit 7,a
        jr nz,SelectVoice_Available
        ld a,(iy+voicePriority)
        cp c
        jr nc,z80_17EE
        ld c,a
        ld (zRamVoiceVictim),iy
        jr z80_17EE

SelectVoice_Available:
        ld a,(iy+voiceOwner)
        cp b
        jr nz,z80_181E
        bit 7,h
        jr nz,z80_181E
        push iy
        pop hl
        ld a,(hl)
        ret

z80_181E:
        ld a,(iy+voiceReleaseAge)
        cp l
        jr nc,z80_17EE
        ld l,a
        ld (zRamAvailableVoice),iy
        jr z80_17EE

SelectVoice_ChooseAvailable:
        ld a,l
        cp 0xff
        jr z,SelectVoice_ChooseVictim
        ld hl,(zRamAvailableVoice)
        ld a,(hl)
        ret

SelectVoice_ChooseVictim:
        ld a,c

SelectVoice_CheckPriority:
; Unsigned victim priority A <= request channelPriority accepts, including equality. Generic pool sentinel $FF can fall through to stale zRamVoiceVictim if no candidate was recorded and request priority=$FF; original behavior retained.
        cp (ix+channelPriority)
        jr z,SelectVoice_ReturnVictim
        jr c,SelectVoice_ReturnVictim
        ld a,0xff
        ret

SelectVoice_ReturnVictim:
        ld hl,(zRamVoiceVictim)
        ld a,(hl)
        ret

SelectDedicatedVoice:
; Dedicated FM3/DAC/PSG-noise voice: any available bit7 wins; occupied voice needs old priority <= new. Does not search other hardware slots.
        call ServiceDacSample
        ld a,(iy)
        bit 7,a
        jr z,z80_1853
        push iy
        pop hl
        ret

z80_1853:
        ld a,(iy+voicePriority)
        ld (zRamVoiceVictim),iy
        jr SelectVoice_CheckPriority

MarkMatchingVoiceReleased:
; IX=terminated pool, B=owner, C=note. Find first occupied matching pair. Non-DAC state becomes (state & $27)|$C0; DAC key6/bit5 is left for descriptor-dependent release. A returns ORIGINAL state, or $FF if absent.
        ld de,7
        jr z80_1863

z80_1861:
        add ix,de

z80_1863:
        ld a,(ix)
        ld h,a
        cp 0xff
        ret z
        bit 7,a
        jr nz,z80_1861
        ld a,(ix+voiceNote)
        cp c
        jr nz,z80_1861
        ld a,(ix+voiceOwner)
        cp b
        jr nz,z80_1861
        ld a,h
        and 0x27
        cp 0x26
        jr z,z80_1888
        and 0x27
        or 0xc0
        ld (ix),a

z80_1888:
        ld a,h
        ret

; DriverState188A: Z80 $188A..$188B
z80Data_DriverState188A:
        db $00,$00
