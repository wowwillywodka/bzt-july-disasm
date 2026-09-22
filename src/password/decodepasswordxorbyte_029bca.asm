; $029BCA..$029BD5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Шаг XOR-шифра: байт (A1) ^= D3, прокрутка ключа D3 (ror.l #7 + swap), запись обратно в (A1)+ — поточное шифрование/дешифрование с роллинг-ключом
        ifne *-$29BCA
        fail "ROM start moved"
        endif

DecodePasswordXorByte:
        move.b       (a1), d0                                      ; $029BCA
        eor.b        d3, d0                                        ; $029BCC
        ror.l        #$7, d3                                       ; $029BCE
        swap         d3                                            ; $029BD0
        move.b       d0, (a1)+                                     ; $029BD2
        rts                                                        ; $029BD4
        ifne *-$29BD6
        fail "ROM end moved"
        endif
