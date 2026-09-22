; $01FE8A..$01FEB5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Линк-кабель: запись байта 0x20 в DDR порта3 ($A1000B) + bset бита5 (TR-строб) в DATA3 ($A10005), busy-wait по биту6 (TH) с таймаутом $FF2C64; при истечении инкремент счётчика ошибок $FF2C5E
        ifne *-$1FE8A
        fail "ROM start moved"
        endif

InputRoutine_01FE8A:
        move.b       #$20, (a2)                                    ; $01FE8A
        bset.b       #$5, (a3)                                     ; $01FE8E
        move.w       $ff2c64.l, d5                                 ; $01FE92

loc_01FE98:
        subq.w       #$1, d5                                       ; $01FE98
        beq.b        loc_01FEA4                                    ; $01FE9A
        btst.b       #$6, (a3)                                     ; $01FE9C
        beq.b        loc_01FE98                                    ; $01FEA0
        rts                                                        ; $01FEA2

loc_01FEA4:
        addq.w       #$1, $ff2c5e.l                                ; $01FEA4
        rts                                                        ; $01FEAA

loc_01FEAC:
        bclr.b       #$5, PAD2_DATA.l                              ; $01FEAC
        rts                                                        ; $01FEB4
        ifne *-$1FEB6
        fail "ROM end moved"
        endif
