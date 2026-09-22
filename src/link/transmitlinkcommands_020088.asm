; $020088..$0201E5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Полный кадр синхронизации линк-кабеля: SR=$2700, A2=$A1000B/A3=$A10005, обмен длиной и блоком слов TX-буфера (-0x4B90,A6) через 0x1FDD4/0x1FDF6/0x1FE8A/0x1FEB6, контроль чексуммы D1==D7, на ошибку калибровка тайм-задержки (-0x53A0,A6)
        ifne *-$20088
        fail "ROM start moved"
        endif

TransmitLinkCommands:
        move.w       sr, -(a7)                                     ; $020088
        move.w       #$2700, sr                                    ; $02008A
        movea.l      #PAD2_CONTROL, a2                             ; $02008E
        movea.l      #PAD2_DATA, a3                                ; $020094
        moveq        #$f, d2                                       ; $02009A
        move.w       #$f0, d3                                      ; $02009C
        clr.w        -$53a2(a6)                                    ; $0200A0
        bsr.w        InputRoutine_01FDD4                           ; $0200A4
        tst.w        -$53a2(a6)                                    ; $0200A8
        bne.w        loc_0201AA                                    ; $0200AC
        move.w       -$5392(a6), d0                                ; $0200B0
        sub.w        -$5394(a6), d0                                ; $0200B4
        bpl.b        loc_0200BE                                    ; $0200B8
        addi.w       #$800, d0                                     ; $0200BA

loc_0200BE:
        asr.w        #$1, d0                                       ; $0200BE
        move.w       d0, d7                                        ; $0200C0
        bsr.w        InputRoutine_01FDF6                           ; $0200C2
        tst.w        -$53a2(a6)                                    ; $0200C6
        bne.w        loc_0201AA                                    ; $0200CA
        clr.w        d1                                            ; $0200CE
        move.w       -$5394(a6), d4                                ; $0200D0
        subq.w       #$1, d0                                       ; $0200D4
        bmi.b        loc_0200F8                                    ; $0200D6
        lea.l        -$4b90(a6), a0                                ; $0200D8

loc_0200DC:
        move.w       (a0, d4.w), d7                                ; $0200DC
        addq.w       #$2, d4                                       ; $0200E0
        andi.w       #$7ff, d4                                     ; $0200E2
        add.w        d7, d1                                        ; $0200E6
        bsr.w        InputRoutine_01FDF6                           ; $0200E8
        tst.w        -$53a2(a6)                                    ; $0200EC
        bne.w        loc_0201AA                                    ; $0200F0
        dbra         d0, loc_0200DC                                ; $0200F4

loc_0200F8:
        move.w       d1, d7                                        ; $0200F8
        bsr.w        InputRoutine_01FDF6                           ; $0200FA
        tst.w        -$53a2(a6)                                    ; $0200FE
        bne.w        loc_0201AA                                    ; $020102
        bsr.w        InputRoutine_01FE8A                           ; $020106
        tst.w        -$53a2(a6)                                    ; $02010A
        bne.w        loc_0201AA                                    ; $02010E
        bsr.w        loc_01FEAC                                    ; $020112
        tst.w        -$53a2(a6)                                    ; $020116
        bne.w        loc_0201AA                                    ; $02011A
        bsr.w        InputRoutine_01FEB6                           ; $02011E
        tst.w        -$53a2(a6)                                    ; $020122
        bne.w        loc_0201AA                                    ; $020126
        cmp.w        d7, d1                                        ; $02012A
        bne.b        loc_020134                                    ; $02012C
        move.w       -$5392(a6), -$5394(a6)                        ; $02012E

loc_020134:
        clr.w        d1                                            ; $020134
        bsr.w        InputRoutine_01FEB6                           ; $020136
        tst.w        -$53a2(a6)                                    ; $02013A
        bne.w        loc_0201AA                                    ; $02013E
        move.w       d7, d0                                        ; $020142
        move.w       -$5396(a6), d4                                ; $020144
        subq.w       #$1, d0                                       ; $020148
        bmi.b        loc_02016C                                    ; $02014A
        lea.l        -$5390(a6), a0                                ; $02014C

loc_020150:
        bsr.w        InputRoutine_01FEB6                           ; $020150
        tst.w        -$53a2(a6)                                    ; $020154
        bne.w        loc_0201AA                                    ; $020158
        add.w        d7, d1                                        ; $02015C
        move.w       d7, (a0, d4.w)                                ; $02015E
        addq.w       #$2, d4                                       ; $020162
        andi.w       #$7ff, d4                                     ; $020164
        dbra         d0, loc_020150                                ; $020168

loc_02016C:
        bsr.w        InputRoutine_01FEB6                           ; $02016C
        tst.w        -$53a2(a6)                                    ; $020170
        bne.w        loc_0201AA                                    ; $020174
        cmp.w        d7, d1                                        ; $020178
        bne.b        loc_020180                                    ; $02017A
        move.w       d4, -$5396(a6)                                ; $02017C

loc_020180:
        bsr.w        InputRoutine_01FF30                           ; $020180
        tst.w        -$53a2(a6)                                    ; $020184
        bne.w        loc_0201AA                                    ; $020188
        bsr.w        InputRoutine_01FDD4                           ; $02018C
        tst.w        -$53a2(a6)                                    ; $020190
        bne.w        loc_0201AA                                    ; $020194
        move.w       d1, d7                                        ; $020198
        bsr.w        InputRoutine_01FDF6                           ; $02019A
        tst.w        -$53a2(a6)                                    ; $02019E
        bne.w        loc_0201AA                                    ; $0201A2
        bsr.w        InputRoutine_01FE8A                           ; $0201A6

loc_0201AA:
        move.b       #$20, (a2)                                    ; $0201AA
        bset.b       #$5, (a3)                                     ; $0201AE
        tst.w        -$53a2(a6)                                    ; $0201B2
        beq.b        loc_0201DE                                    ; $0201B6
        move.w       -$539e(a6), d7                                ; $0201B8
        beq.b        loc_0201E2                                    ; $0201BC

loc_0201BE:
        nop                                                        ; $0201BE
        nop                                                        ; $0201C0
        nop                                                        ; $0201C2
        nop                                                        ; $0201C4
        nop                                                        ; $0201C6
        nop                                                        ; $0201C8
        nop                                                        ; $0201CA
        nop                                                        ; $0201CC
        nop                                                        ; $0201CE
        nop                                                        ; $0201D0
        dbra         d7, loc_0201BE                                ; $0201D2
        addi.w       #$1e, -$53a0(a6)                              ; $0201D6
        bra.b        loc_0201E2                                    ; $0201DC

loc_0201DE:
        clr.w        -$53a0(a6)                                    ; $0201DE

loc_0201E2:
        move.w       (a7)+, sr                                     ; $0201E2
        rts                                                        ; $0201E4
        ifne *-$201E6
        fail "ROM end moved"
        endif
