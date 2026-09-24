; $01737E..$01747D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed code: $1737E..$1747D is a retained Green Dummy ranged attack with no known external direct control edge; $1747E..$17555 is active death handling. See docs/GREY_GREEN_DUMMY.md.
; JULY LOCAL REVIEW:
; Retained Green ranged attack: state1 writer exists here, but no direct path from live callbacks enters this body. State1 during corpse countdown does not activate live attack callbacks. See docs/ENEMY_REACHABILITY.md.
        ifne *-$1737E
        fail "ROM start moved"
        endif

RetainedGreenDummyRangedAttack:
; Retained Green ranged attack: state1 writer exists here, but no direct path from live callbacks enters this body. State1 during corpse countdown does not activate live attack callbacks. See docs/ENEMY_REACHABILITY.md.
        cmpi.b       #$1, ActorState(a0)                           ; $01737E
        beq.b        loc_01739C                                    ; $017384
        subq.b       #$1, ActorStateCounter(a0)                    ; $017386
        beq.b        loc_01738E                                    ; $01738A
        rts                                                        ; $01738C

loc_01738E:
        move.b       #$1, ActorState(a0)                           ; $01738E
        move.b       #$a, ActorStateCounter(a0)                    ; $017394
        rts                                                        ; $01739A

loc_01739C:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01739C
        bne.b        loc_0173B2                                    ; $0173A0
        move.b       #$5, ActorStateCounter(a0)                    ; $0173A2

loc_0173A8:
        move.b       #$0, ActorState(a0)                           ; $0173A8
        bra.w        RefreshEnemyTargetOrExit                      ; $0173AE

loc_0173B2:
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $0173B2
        beq.b        loc_0173E0                                    ; $0173B8
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $0173BA
        beq.b        loc_0173CC                                    ; $0173C0
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $0173C2
        beq.b        loc_0173CC                                    ; $0173C8
        rts                                                        ; $0173CA

loc_0173CC:
        move.w       #$5f, d0                                      ; $0173CC
        jsr          RouteSoundEventByActorFloor.l                         ; $0173D0
        move.w       #$83, d0                                      ; $0173D6
        jmp          RouteSoundEventByActorFloor.l                         ; $0173DA

loc_0173E0:
        movea.l      ActorTarget(a0), a3                           ; $0173E0
        move.w       ActorX(a3), d0                                ; $0173E4
        move.w       ActorY(a3), d1                                ; $0173E8
        move.w       ActorX(a0), d3                                ; $0173EC
        move.w       ActorY(a0), d4                                ; $0173F0
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $0173F4
        bne.b        loc_0173A8                                    ; $0173F8
        move.w       #$400, d3                                     ; $0173FA
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $0173FE
        bpl.b        loc_017414                                    ; $017402
        move.w       #$200, d3                                     ; $017404
        tst.w        rSceneColorMode(a6)                           ; $017408
        beq.b        loc_01741E                                    ; $01740C
        move.w       #$17b, d3                                     ; $01740E
        bra.b        loc_01741E                                    ; $017412

loc_017414:
        tst.w        rSceneColorMode(a6)                           ; $017414
        beq.b        loc_01742E                                    ; $017418
        move.w       #$300, d3                                     ; $01741A

loc_01741E:
        jsr          NextRandom.l                                  ; $01741E
        asr.l        #$8, d2                                       ; $017424
        andi.w       #$3ff, d2                                     ; $017426
        cmp.w        d3, d2                                        ; $01742A
        bcc.b        loc_017468                                    ; $01742C

loc_01742E:
        move.w       ActorX(a0), d0                                ; $01742E
        move.w       ActorY(a0), d1                                ; $017432
        sub.w        ActorX(a3), d0                                ; $017436
        sub.w        ActorY(a3), d1                                ; $01743A
        move.w       d0, d3                                        ; $01743E
        move.w       d1, d4                                        ; $017440
        jsr          OctagonalDistance.l                           ; $017442
        cmpi.w       #$400, d0                                     ; $017448
        bcc.b        loc_01747C                                    ; $01744C
        jsr          NextRandom.w                                  ; $01744E
        asr.w        #$8, d2                                       ; $017452
        andi.w       #$3, d2                                       ; $017454
        beq.w        loc_01747C                                    ; $017458
        move.l       a0, -(a7)                                     ; $01745C
        movea.l      a3, a0                                        ; $01745E
        movea.l      ActorHitCallback(a0), a1                      ; $017460
        jsr          (a1)                                          ; $017464
        movea.l      (a7)+, a0                                     ; $017466

loc_017468:
        move.w       #$5f, d0                                      ; $017468
        jsr          RouteSoundEventByActorFloor.l                         ; $01746C
        move.w       #$83, d0                                      ; $017472
        jsr          RouteSoundEventByActorFloor.l                         ; $017476

loc_01747C:
        rts                                                        ; $01747C
        ifne *-$1747E
        fail "ROM end moved"
        endif
