; $01FDF6..$01FE89 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Передача байта по линк-кабелю (порт 3 A3=$A10005): четыре полунибловых такта rol.l #4 с маской D2/D3, поочерёдно взводя/сбрасывая строб-бит 5 и ожидая квитанцию (бит 6) с таймаутом $ff2c64, ошибка→$ff2c5e
        ifne *-$1FDF6
        fail "ROM start moved"
        endif

InputRoutine_01FDF6:
        swap         d7                                            ; $01FDF6
        rol.l        #$4, d7                                       ; $01FDF8
        and.b        d2, d7                                        ; $01FDFA
        move.b       (a3), d6                                      ; $01FDFC
        and.b        d3, d6                                        ; $01FDFE
        or.b         d7, d6                                        ; $01FE00
        move.b       d6, (a3)                                      ; $01FE02
        bset.b       #$5, (a3)                                     ; $01FE04
        move.w       $ff2c64.l, d5                                 ; $01FE08

loc_01FE0E:
        subq.w       #$1, d5                                       ; $01FE0E
        beq.w        loc_01FE82                                    ; $01FE10
        btst.b       #$6, (a3)                                     ; $01FE14
        beq.b        loc_01FE0E                                    ; $01FE18
        rol.l        #$4, d7                                       ; $01FE1A
        and.b        d2, d7                                        ; $01FE1C
        move.b       (a3), d6                                      ; $01FE1E
        and.b        d3, d6                                        ; $01FE20
        or.b         d7, d6                                        ; $01FE22
        move.b       d6, (a3)                                      ; $01FE24
        bclr.b       #$5, (a3)                                     ; $01FE26
        move.w       $ff2c64.l, d5                                 ; $01FE2A

loc_01FE30:
        subq.w       #$1, d5                                       ; $01FE30
        beq.w        loc_01FE82                                    ; $01FE32
        btst.b       #$6, (a3)                                     ; $01FE36
        bne.b        loc_01FE30                                    ; $01FE3A
        rol.l        #$4, d7                                       ; $01FE3C
        and.b        d2, d7                                        ; $01FE3E
        move.b       (a3), d6                                      ; $01FE40
        and.b        d3, d6                                        ; $01FE42
        or.b         d7, d6                                        ; $01FE44
        move.b       d6, (a3)                                      ; $01FE46
        bset.b       #$5, (a3)                                     ; $01FE48
        move.w       $ff2c64.l, d5                                 ; $01FE4C

loc_01FE52:
        subq.w       #$1, d5                                       ; $01FE52
        beq.w        loc_01FE82                                    ; $01FE54
        btst.b       #$6, (a3)                                     ; $01FE58
        beq.b        loc_01FE52                                    ; $01FE5C
        rol.l        #$4, d7                                       ; $01FE5E
        and.b        d2, d7                                        ; $01FE60
        move.b       (a3), d6                                      ; $01FE62
        and.b        d3, d6                                        ; $01FE64
        or.b         d7, d6                                        ; $01FE66
        move.b       d6, (a3)                                      ; $01FE68
        bclr.b       #$5, (a3)                                     ; $01FE6A
        move.w       $ff2c64.l, d5                                 ; $01FE6E

loc_01FE74:
        subq.w       #$1, d5                                       ; $01FE74
        beq.w        loc_01FE82                                    ; $01FE76
        btst.b       #$6, (a3)                                     ; $01FE7A
        bne.b        loc_01FE74                                    ; $01FE7E
        rts                                                        ; $01FE80

loc_01FE82:
        addq.w       #$1, $ff2c5e.l                                ; $01FE82
        rts                                                        ; $01FE88
        ifne *-$1FE8A
        fail "ROM end moved"
        endif
