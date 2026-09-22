; $029C02..$029C0D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шифратор байта пароля: eor.b D3 (ключ-LFSR), ror.l #7 + swap прокрутка ключа $56CA2D69, пишет (A2)+ — XOR-обфускация буфера кода игрока
        ifne *-$29C02
        fail "ROM start moved"
        endif

EncodePasswordXorByte:
        move.b       (a2), d0                                      ; $029C02
        eor.b        d3, d0                                        ; $029C04
        ror.l        #$7, d3                                       ; $029C06
        swap         d3                                            ; $029C08
        move.b       d0, (a2)+                                     ; $029C0A
        rts                                                        ; $029C0C
        ifne *-$29C0E
        fail "ROM end moved"
        endif
