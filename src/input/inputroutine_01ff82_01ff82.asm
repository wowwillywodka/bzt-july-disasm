; $01FF82..$01FFCB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация слейва/реконнект линк-кабеля: обнуление указателей колец RX/TX (-0x5398..-0x5392,A6), флаг $8000, режим $2500, VDP $8B00, DDR порта3 ($A1000B=$20) и DATA3 ($A10005 bset5)
        ifne *-$1FF82
        fail "ROM start moved"
        endif

InputRoutine_01FF82:
        jsr          AcquireZ80Bus.l                               ; $01FF82
        clr.w        -$5398(a6)                                    ; $01FF88
        clr.w        -$5396(a6)                                    ; $01FF8C
        clr.w        -$5394(a6)                                    ; $01FF90
        clr.w        -$5392(a6)                                    ; $01FF94
        move.w       #$8000, -$539e(a6)                            ; $01FF98
        clr.w        -$539c(a6)                                    ; $01FF9E
        move.w       #$2500, -$539a(a6)                            ; $01FFA2
        move.w       #$2500, sr                                    ; $01FFA8
        move.w       #$8b00, VDP_CONTROL.l                         ; $01FFAC
        move.b       #$20, PAD2_CONTROL.l                          ; $01FFB4
        bset.b       #$5, PAD2_DATA.l                              ; $01FFBC
        jsr          ReleaseZ80Bus.l                               ; $01FFC4
        rts                                                        ; $01FFCA
        ifne *-$1FFCC
        fail "ROM end moved"
        endif
