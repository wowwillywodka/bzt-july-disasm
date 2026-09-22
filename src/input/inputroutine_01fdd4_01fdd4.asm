; $01FDD4..$01FDF5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Серийный линк (порт 3 контроллера A3=$A10005): сбрасывает строб-бит 5, ждёт ответ (бит 6) с таймаутом по $ff2c64; по таймауту шлёт код $2f в A2, иначе инкремент счётчика квитанций $ff2c5e
        ifne *-$1FDD4
        fail "ROM start moved"
        endif

InputRoutine_01FDD4:
        bclr.b       #$5, (a3)                                     ; $01FDD4
        move.w       $ff2c64.l, d5                                 ; $01FDD8

loc_01FDDE:
        subq.w       #$1, d5                                       ; $01FDDE
        beq.b        loc_01FDEE                                    ; $01FDE0
        btst.b       #$6, (a3)                                     ; $01FDE2
        bne.b        loc_01FDDE                                    ; $01FDE6
        move.b       #$2f, (a2)                                    ; $01FDE8
        rts                                                        ; $01FDEC

loc_01FDEE:
        addq.w       #$1, $ff2c5e.l                                ; $01FDEE
        rts                                                        ; $01FDF4
        ifne *-$1FDF6
        fail "ROM end moved"
        endif
