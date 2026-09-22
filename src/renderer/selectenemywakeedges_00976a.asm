; $00976A..$0097A7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 9510] выбор варианта спавн-скана по клетке игрока: полный 7×7 (954E) / краевые (95AA-95C2)
        ifne *-$976A
        fail "ROM start moved"
        endif

SelectEnemyWakeEdges:
        cmp.l        a0, d0                                        ; $00976A
        beq.w        loc_009824                                    ; $00976C
        addq.l       #$1, d0                                       ; $009770
        cmp.l        a0, d0                                        ; $009772
        beq.w        loc_009804                                    ; $009774
        addi.l       #$1e, d0                                      ; $009778
        cmp.l        a0, d0                                        ; $00977E
        beq.w        EnemiesRoutine_00989E                         ; $009780
        addq.l       #$2, d0                                       ; $009784
        cmp.l        a0, d0                                        ; $009786
        beq.w        EnemiesRoutine_009860                         ; $009788
        addi.l       #$1e, d0                                      ; $00978C
        cmp.l        a0, d0                                        ; $009792
        beq.w        EnemiesRoutine_00981C                         ; $009794
        addq.l       #$1, d0                                       ; $009798
        cmp.l        a0, d0                                        ; $00979A
        beq.w        loc_0098DC                                    ; $00979C
        addq.l       #$1, d0                                       ; $0097A0
        cmp.l        a0, d0                                        ; $0097A2
        beq.w        loc_009804                                    ; $0097A4
        ifne *-$97A8
        fail "ROM end moved"
        endif
