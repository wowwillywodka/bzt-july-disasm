; $098B98..$098C31 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A3=byte-pair source, D0=tile index (VRAM byte address = index*32). Direct CPU writes, not DMA. Partial output long is not flushed at end.
        ifne *-$98B98
        fail "ROM start moved"
        endif

DecompressBytePairToVramLong:
; A3=byte-pair source, D0=tile index (VRAM byte address = index*32). Direct CPU writes, not DMA. Partial output long is not flushed at end.
        movem.l      d0-d6/a0-a4, -(a7)                            ; $098B98
        move.w       #$8f02, VDP_CONTROL.l                         ; $098B9C
        asl.l        #$7, d0                                       ; $098BA4
        lsr.w        #$2, d0                                       ; $098BA6
        ori.w        #$4000, d0                                    ; $098BA8
        swap         d0                                            ; $098BAC
        move.l       d0, VDP_CONTROL.l                             ; $098BAE
; D3=1 is the shift/carry sentinel for four output bytes. It is NOT reset at dictionary-block boundaries.
        moveq        #$1, d3                                       ; $098BB4

loc_098BB6:
        moveq        #$0, d0                                       ; $098BB6
        moveq        #$0, d1                                       ; $098BB8
        moveq        #$0, d2                                       ; $098BBA
        move.b       (a3)+, d0                                     ; $098BBC
        cmpi.b       #$ff, d0                                      ; $098BBE
        beq.w        loc_098C2C                                    ; $098BC2
        subq.w       #$1, d0                                       ; $098BC6
        move.b       d0, d1                                        ; $098BC8
        lea.l        rBytePairFlags(a6), a0                        ; $098BCA
        lea.l        rBytePairLeft(a6), a1                         ; $098BCE
        lea.l        rBytePairRight(a6), a2                        ; $098BD2
; 257 flag bytes cleared, including the first byte of BytePairLeft. Dictionary triples follow this initialization.
        move.w       #$100, d0                                     ; $098BD6

loc_098BDA:
        move.b       #$0, (a0, d2.w)                               ; $098BDA
        addq.w       #$1, d2                                       ; $098BE0
        dbra         d0, loc_098BDA                                ; $098BE2
        moveq        #$0, d0                                       ; $098BE6

loc_098BE8:
        move.b       (a3)+, d0                                     ; $098BE8
        move.b       #$1, (a0, d0.w)                               ; $098BEA
        move.b       (a3)+, (a1, d0.w)                             ; $098BF0
        move.b       (a3)+, (a2, d0.w)                             ; $098BF4
        dbra         d1, loc_098BE8                                ; $098BF8
        move.l       a3, d0                                        ; $098BFC
        btst.l       #$0, d0                                       ; $098BFE
        beq.w        loc_098C08                                    ; $098C02
        addq.w       #$1, d0                                       ; $098C06

loc_098C08:
        movea.l      d0, a3                                        ; $098C08
        move.w       (a3)+, d2                                     ; $098C0A
        subq.w       #$1, d2                                       ; $098C0C
        clr.l        d0                                            ; $098C0E

loc_098C10:
        move.b       (a3)+, d0                                     ; $098C10
        jsr          ExpandBytePairToVramLong.l                    ; $098C12
        dbra         d2, loc_098C10                                ; $098C18
        move.l       a3, d1                                        ; $098C1C
        btst.l       #$0, d1                                       ; $098C1E
        beq.w        loc_098C28                                    ; $098C22
        addq.w       #$1, d1                                       ; $098C26

loc_098C28:
        movea.l      d1, a3                                        ; $098C28
        bra.b        loc_098BB6                                    ; $098C2A

loc_098C2C:
        movem.l      (a7)+, d0-d6/a0-a4                            ; $098C2C
        rts                                                        ; $098C30
        ifne *-$98C32
        fail "ROM end moved"
        endif
