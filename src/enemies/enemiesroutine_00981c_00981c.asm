; $00981C..$00985F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 95C2] суб-сканы проксимити-спавнера 954E по КРАЯМ окна (камера -0x720C/-0x720A, границы карты 0x300/0x1D00) → спавн у кромки видимости
        ifne *-$981C
        fail "ROM start moved"
        endif

EnemiesRoutine_00981C:
        bsr.w        EnemiesRoutine_00989E                         ; $00981C
        bra.w        loc_0098DC                                    ; $009820

loc_009824:
        cmpi.w       #$300, rPlayerY(a6)                           ; $009824
        bcs.b        loc_00985E                                    ; $00982A
        move.w       rPlayerX(a6), d0                              ; $00982C
        asr.w        #$8, d0                                       ; $009830
        subq.w       #$4, d0                                       ; $009832
        lea.l        -$63(a0), a1                                  ; $009834
        move.w       #$6, d7                                       ; $009838

loc_00983C:
        addq.w       #$1, d0                                       ; $00983C
        bmi.b        loc_009858                                    ; $00983E
        cmpi.w       #$20, d0                                      ; $009840
        bcc.b        loc_00985E                                    ; $009844
        clr.w        d3                                            ; $009846
        move.b       (a1), d3                                      ; $009848
        move.b       (a5, d3.w), d3                                ; $00984A
        move.b       (a4, d3.w), d3                                ; $00984E
        beq.b        loc_009858                                    ; $009852
        bsr.w        SelectActorDefinitionFromCell                 ; $009854

loc_009858:
        addq.w       #$1, a1                                       ; $009858
        dbra         d7, loc_00983C                                ; $00985A

loc_00985E:
        rts                                                        ; $00985E
        ifne *-$9860
        fail "ROM end moved"
        endif
