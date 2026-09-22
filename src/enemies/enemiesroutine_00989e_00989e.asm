; $00989E..$009917 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; краевые спавн-сканы July (границы 0x300, поза -0x7206/-0x7204 — RAM-сдвиг July; =June 95C2/9606/9644)
        ifne *-$989E
        fail "ROM start moved"
        endif

EnemiesRoutine_00989E:
        cmpi.w       #$300, rPlayerX(a6)                           ; $00989E
        bcs.b        loc_0098DA                                    ; $0098A4
        move.w       rPlayerY(a6), d0                              ; $0098A6
        asr.w        #$8, d0                                       ; $0098AA
        subq.w       #$4, d0                                       ; $0098AC
        lea.l        -$63(a0), a1                                  ; $0098AE
        move.w       #$6, d7                                       ; $0098B2

loc_0098B6:
        addq.w       #$1, d0                                       ; $0098B6
        bmi.b        loc_0098D2                                    ; $0098B8
        cmpi.w       #$20, d0                                      ; $0098BA
        bcc.b        loc_0098DA                                    ; $0098BE
        clr.w        d3                                            ; $0098C0
        move.b       (a1), d3                                      ; $0098C2
        move.b       (a5, d3.w), d3                                ; $0098C4
        move.b       (a4, d3.w), d3                                ; $0098C8
        beq.b        loc_0098D2                                    ; $0098CC
        bsr.w        SelectActorDefinitionFromCell                 ; $0098CE

loc_0098D2:
        adda.w       #$20, a1                                      ; $0098D2
        dbra         d7, loc_0098B6                                ; $0098D6

loc_0098DA:
        rts                                                        ; $0098DA

loc_0098DC:
        cmpi.w       #$1d00, rPlayerY(a6)                          ; $0098DC
        bcc.b        loc_009916                                    ; $0098E2
        move.w       rPlayerX(a6), d0                              ; $0098E4
        asr.w        #$8, d0                                       ; $0098E8
        subq.w       #$4, d0                                       ; $0098EA
        lea.l        $5d(a0), a1                                   ; $0098EC
        move.w       #$6, d7                                       ; $0098F0

loc_0098F4:
        addq.w       #$1, d0                                       ; $0098F4
        bmi.b        loc_009910                                    ; $0098F6
        cmpi.w       #$20, d0                                      ; $0098F8
        bcc.b        loc_009916                                    ; $0098FC
        clr.w        d3                                            ; $0098FE
        move.b       (a1), d3                                      ; $009900
        move.b       (a5, d3.w), d3                                ; $009902
        move.b       (a4, d3.w), d3                                ; $009906
        beq.b        loc_009910                                    ; $00990A
        bsr.w        SelectActorDefinitionFromCell                 ; $00990C

loc_009910:
        addq.w       #$1, a1                                       ; $009910
        dbra         d7, loc_0098F4                                ; $009912

loc_009916:
        rts                                                        ; $009916
        ifne *-$9918
        fail "ROM end moved"
        endif
