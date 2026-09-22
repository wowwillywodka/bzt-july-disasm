; $0097A8..$00980B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; 7x7 scan around A0-3rows-3cols, but bounds and spawn coordinate counters come from GLOBAL player XY. A4 selector table, A5 type LUT. Explosion passes actor-cell pointer and temporarily changes CurrentFloor.
        ifne *-$97A8
        fail "ROM start moved"
        endif

SpawnActorsInSevenBySevenWindow:
; 7x7 scan around A0-3rows-3cols, but bounds and spawn coordinate counters come from GLOBAL player XY. A4 selector table, A5 type LUT. Explosion passes actor-cell pointer and temporarily changes CurrentFloor.
        move.w       rPlayerY(a6), d0                              ; $0097A8
        asr.w        #$8, d0                                       ; $0097AC
        subq.w       #$4, d0                                       ; $0097AE
        lea.l        -$63(a0), a1                                  ; $0097B0
        move.w       #$6, d6                                       ; $0097B4

loc_0097B8:
        addq.w       #$1, d0                                       ; $0097B8
        bmi.b        loc_0097FA                                    ; $0097BA
        cmpi.w       #$20, d0                                      ; $0097BC
        bcc.b        loc_009802                                    ; $0097C0
        move.w       rPlayerX(a6), d1                              ; $0097C2
        asr.w        #$8, d1                                       ; $0097C6
        subq.w       #$4, d1                                       ; $0097C8
        move.w       #$6, d7                                       ; $0097CA

loc_0097CE:
        addq.w       #$1, d1                                       ; $0097CE
        bmi.b        loc_0097F2                                    ; $0097D0
        cmpi.w       #$20, d1                                      ; $0097D2
        bcc.b        loc_0097F2                                    ; $0097D6
        clr.w        d3                                            ; $0097D8
        move.b       (a1), d3                                      ; $0097DA
        move.b       (a5, d3.w), d3                                ; $0097DC
        move.b       (a4, d3.w), d3                                ; $0097E0
        beq.b        loc_0097F2                                    ; $0097E4
        movem.w      d1/d6, -(a7)                                  ; $0097E6
        bsr.w        SelectActorDefinitionFromCell                 ; $0097EA
        movem.w      (a7)+, d1/d6                                  ; $0097EE

loc_0097F2:
        addq.w       #$1, a1                                       ; $0097F2
        dbra         d7, loc_0097CE                                ; $0097F4
        subq.w       #$7, a1                                       ; $0097F8

loc_0097FA:
        adda.w       #$20, a1                                      ; $0097FA
        dbra         d6, loc_0097B8                                ; $0097FE

loc_009802:
        rts                                                        ; $009802

loc_009804:
        bsr.w        EnemiesRoutine_009860                         ; $009804
        bra.w        loc_009824                                    ; $009808
        ifne *-$980C
        fail "ROM end moved"
        endif
