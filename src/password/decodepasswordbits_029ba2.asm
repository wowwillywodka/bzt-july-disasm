; $029BA2..$029BC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Чтение 56-битного (0x38) упакованного поля из PC-таблицы через бит-распак/упак (0x29b78/0x29b4e), затем 7× XOR-расшифровка (0x29bca) с ключом 0x56ca2d69 — декод кода ID-карты/пароля
        ifne *-$29BA2
        fail "ROM start moved"
        endif

DecodePasswordBits:
        lea.l        PasswordBitPermutation(pc), a3                ; $029BA2
        clr.w        d2                                            ; $029BA6

loc_029BA8:
        bsr.b        ReadPasswordBit                               ; $029BA8
        move.b       (a3)+, d1                                     ; $029BAA
        bsr.b        WritePasswordBit                              ; $029BAC
        cmpi.w       #$38, d2                                      ; $029BAE
        bne.b        loc_029BA8                                    ; $029BB2
        move.l       #$56ca2d69, d3                                ; $029BB4
        bsr.b        DecodePasswordXorByte                         ; $029BBA
        bsr.b        DecodePasswordXorByte                         ; $029BBC
        bsr.b        DecodePasswordXorByte                         ; $029BBE
        bsr.b        DecodePasswordXorByte                         ; $029BC0
        bsr.b        DecodePasswordXorByte                         ; $029BC2
        bsr.b        DecodePasswordXorByte                         ; $029BC4
        bsr.b        DecodePasswordXorByte                         ; $029BC6
        rts                                                        ; $029BC8
        ifne *-$29BCA
        fail "ROM end moved"
        endif
