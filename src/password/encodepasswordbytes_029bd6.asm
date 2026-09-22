; $029BD6..$029C01 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обратное кодирование 56-битного поля: 7× XOR-шифр (0x29c02) буфера (A2) ключом 0x56ca2d69, затем бит-упаковка 56 бит обратно в PC-таблицу — энкод кода ID-карты/пароля
        ifne *-$29BD6
        fail "ROM start moved"
        endif

EncodePasswordBytes:
        move.l       #$56ca2d69, d3                                ; $029BD6
        bsr.b        EncodePasswordXorByte                         ; $029BDC
        bsr.b        EncodePasswordXorByte                         ; $029BDE
        bsr.b        EncodePasswordXorByte                         ; $029BE0
        bsr.b        EncodePasswordXorByte                         ; $029BE2
        bsr.b        EncodePasswordXorByte                         ; $029BE4
        bsr.b        EncodePasswordXorByte                         ; $029BE6
        bsr.b        EncodePasswordXorByte                         ; $029BE8
        subq.w       #$7, a2                                       ; $029BEA
        lea.l        PasswordBitPermutation(pc), a3                ; $029BEC
        clr.w        d1                                            ; $029BF0

loc_029BF2:
        move.b       (a3)+, d2                                     ; $029BF2
        bsr.b        ReadPasswordBit                               ; $029BF4
        bsr.w        WritePasswordBit                              ; $029BF6
        cmpi.w       #$38, d1                                      ; $029BFA
        bne.b        loc_029BF2                                    ; $029BFE
        rts                                                        ; $029C00
        ifne *-$29C02
        fail "ROM end moved"
        endif
