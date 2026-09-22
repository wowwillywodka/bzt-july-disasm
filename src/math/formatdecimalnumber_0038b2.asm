; $0038B2..$003923 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; FUN_000038b2: конвертер целого D0→ASCII-десятичная строка в буфер (-0x6fdc,A6); сохр. регистры, A0=таблица цифр, andi #0x1fff, разложение на тысячи/сотни/десятки/единицы повторным вычитанием (#0x3e8/#0x64/#0xa), запись цифр в (A1)+, нуль-терминатор, восстановление регистров, rts
        ifne *-$38B2
        fail "ROM start moved"
        endif

FormatDecimalNumber:
        movem.l      d0-d1/a2-a3, -(a7)                            ; $0038B2
        lea.l        PercentDisplayText(pc), a0                    ; $0038B6
        lea.l        -$6fdc(a6), a1                                ; $0038BA
        andi.w       #$1fff, d0                                    ; $0038BE
        cmpi.w       #$a, d0                                       ; $0038C2
        bcs.b        loc_003916                                    ; $0038C6
        cmpi.w       #$64, d0                                      ; $0038C8
        bcs.b        loc_0038FE                                    ; $0038CC
        cmpi.w       #$3e8, d0                                     ; $0038CE
        bcs.b        loc_0038E6                                    ; $0038D2
        clr.w        d1                                            ; $0038D4

loc_0038D6:
        subi.w       #$3e8, d0                                     ; $0038D6
        addq.w       #$1, d1                                       ; $0038DA
        cmpi.w       #$3e8, d0                                     ; $0038DC
        bcc.b        loc_0038D6                                    ; $0038E0
        move.b       (a0, d1.w), (a1)+                             ; $0038E2

loc_0038E6:
        clr.w        d1                                            ; $0038E6
        cmpi.w       #$64, d0                                      ; $0038E8
        bcs.b        loc_0038FA                                    ; $0038EC

loc_0038EE:
        subi.w       #$64, d0                                      ; $0038EE
        addq.w       #$1, d1                                       ; $0038F2
        cmpi.w       #$64, d0                                      ; $0038F4
        bcc.b        loc_0038EE                                    ; $0038F8

loc_0038FA:
        move.b       (a0, d1.w), (a1)+                             ; $0038FA

loc_0038FE:
        clr.w        d1                                            ; $0038FE
        cmpi.w       #$a, d0                                       ; $003900
        bcs.b        loc_003912                                    ; $003904

loc_003906:
        subi.w       #$a, d0                                       ; $003906
        addq.w       #$1, d1                                       ; $00390A
        cmpi.w       #$a, d0                                       ; $00390C
        bcc.b        loc_003906                                    ; $003910

loc_003912:
        move.b       (a0, d1.w), (a1)+                             ; $003912

loc_003916:
        move.b       (a0, d0.w), (a1)+                             ; $003916
        move.b       #$0, (a1)                                     ; $00391A
        movem.l      (a7)+, d0-d1/a2-a3                            ; $00391E
        rts                                                        ; $003922
        ifne *-$3924
        fail "ROM end moved"
        endif
