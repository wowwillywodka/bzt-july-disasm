; $01FF82..$01FFCB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; Инициализация слейва/реконнект линк-кабеля: обнуление указателей колец RX/TX (-0x5398..-0x5392,A6), флаг $8000, режим $2500, VDP $8B00, DDR порта3 ($A1000B=$20) и DATA3 ($A10005 bset5)
        ifne *-$1FF82
        fail "ROM start moved"
        endif

ResetLinkReceiverPortAndQueues:
        jsr          AcquireZ80Bus.l                               ; $01FF82
        clr.w        rLinkReceiveReadOffset(a6)                                    ; $01FF88
        clr.w        rLinkReceiveWriteOffset(a6)                                    ; $01FF8C
        clr.w        rLinkTransmitReadOffset(a6)                                    ; $01FF90
        clr.w        rLinkTransmitWriteOffset(a6)                                    ; $01FF94
        move.w       #$8000, rLinkRetryDelay(a6)                            ; $01FF98
        clr.w        rLinkTransferModeShadow(a6)                                    ; $01FF9E
        move.w       #$2500, rLinkPortStatusShadow(a6)                            ; $01FFA2
        move.w       #$2500, sr                                    ; $01FFA8
        move.w       #$8b00, VDP_CONTROL.l                         ; $01FFAC
        move.b       #$20, PAD2_CONTROL.l                          ; $01FFB4
        bset.b       #$5, PAD2_DATA.l                              ; $01FFBC
        jsr          ReleaseZ80Bus.l                               ; $01FFC4
        rts                                                        ; $01FFCA
        ifne *-$1FFCC
        fail "ROM end moved"
        endif
