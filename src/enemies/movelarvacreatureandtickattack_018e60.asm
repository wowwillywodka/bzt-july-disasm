; $018E60..$018F0F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; ASR3 clamp25; state1 skips collision without clearing old motion. All goal-arrival outcomes refresh, not reselect. Attack counter advances independently.
        ifne *-$18E60
        fail "ROM start moved"
        endif

MoveLarvaCreatureAndTickAttack:
; ASR3 clamp25; state1 skips collision without clearing old motion. All goal-arrival outcomes refresh, not reselect. Attack counter advances independently.
        clr.w        d2                                            ; $018E60
        move.w       ActorGoalX(a0), d0                            ; $018E62
        sub.w        ActorX(a0), d0                                ; $018E66
        asr.w        #$3, d0                                       ; $018E6A
        tst.w        d0                                            ; $018E6C
        beq.b        loc_018E88                                    ; $018E6E
        bpl.b        loc_018E7E                                    ; $018E70
        cmpi.w       #$ffe7, d0                                    ; $018E72
        bge.b        loc_018E88                                    ; $018E76
        move.w       #$ffe7, d0                                    ; $018E78
        bra.b        loc_018E88                                    ; $018E7C

loc_018E7E:
        cmpi.w       #$19, d0                                      ; $018E7E
        ble.b        loc_018E88                                    ; $018E82
        move.w       #$19, d0                                      ; $018E84

loc_018E88:
        move.w       ActorGoalY(a0), d1                            ; $018E88
        sub.w        ActorY(a0), d1                                ; $018E8C
        asr.w        #$3, d1                                       ; $018E90
        tst.w        d1                                            ; $018E92
        beq.b        loc_018EAE                                    ; $018E94
        bpl.b        loc_018EA4                                    ; $018E96
        cmpi.w       #$ffe7, d1                                    ; $018E98
        bge.b        loc_018EAE                                    ; $018E9C
        move.w       #$ffe7, d1                                    ; $018E9E
        bra.b        loc_018EAE                                    ; $018EA2

loc_018EA4:
        cmpi.w       #$19, d1                                      ; $018EA4
        ble.b        loc_018EAE                                    ; $018EA8
        move.w       #$19, d1                                      ; $018EAA

loc_018EAE:
        cmpi.b       #$1, ActorState(a0)                           ; $018EAE
        beq.w        TickLarvaCreatureAttack                       ; $018EB4
        move.w       d0, ActorMotionX(a0)                          ; $018EB8
        move.w       d1, ActorMotionY(a0)                          ; $018EBC
        bsr.w        TickLarvaCreatureAttack                       ; $018EC0
        cmpi.b       #$1, ActorState(a0)                           ; $018EC4
        beq.w        LarvaCreatureAttackCountdown                  ; $018ECA
        move.w       ActorMotionX(a0), d0                          ; $018ECE
        move.w       ActorMotionY(a0), d1                          ; $018ED2
        bsr.w        MoveActorWithWallMargin32                     ; $018ED6
        move.w       ActorGoalX(a0), d0                            ; $018EDA
        sub.w        ActorX(a0), d0                                ; $018EDE
        asr.w        #$3, d0                                       ; $018EE2
        move.w       ActorGoalY(a0), d1                            ; $018EE4
        sub.w        ActorY(a0), d1                                ; $018EE8
        asr.w        #$3, d1                                       ; $018EEC
        tst.w        d0                                            ; $018EEE
        bpl.b        loc_018EF4                                    ; $018EF0
        neg.w        d0                                            ; $018EF2

loc_018EF4:
        cmpi.w       #$19, d0                                      ; $018EF4
        bgt.w        RefreshEnemyTargetOrExit                      ; $018EF8
        tst.w        d1                                            ; $018EFC
        bpl.b        loc_018F02                                    ; $018EFE
        neg.w        d1                                            ; $018F00

loc_018F02:
        cmpi.w       #$19, d1                                      ; $018F02
        bgt.w        RefreshEnemyTargetOrExit                      ; $018F06
        jmp          RefreshEnemyTargetOrExit.l                    ; $018F0A
        ifne *-$18F10
        fail "ROM end moved"
        endif
