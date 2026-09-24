; $01B504..$01B5AF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Return state0B before contact hit. State numbers belong to the current callback family: Denpyder state7 is dormant, not the Larva/Blue weapon05 death. See docs/ENEMY_REACHABILITY.md.
        ifne *-$1B504
        fail "ROM start moved"
        endif

FinishDenpyderChargeAndTryHit:
; Return state0B before contact hit. State numbers belong to the current callback family: Denpyder state7 is dormant, not the Larva/Blue weapon05 death. See docs/ENEMY_REACHABILITY.md.
        move.b       #$b, ActorState(a0)                           ; $01B504
        move.w       ActorSavedX(a0), ActorGoalX(a0)               ; $01B50A
        move.w       ActorSavedY(a0), ActorGoalY(a0)               ; $01B510
        movea.l      ActorTarget(a0), a3                           ; $01B516
        move.w       ActorX(a0), d0                                ; $01B51A
        move.w       ActorY(a0), d1                                ; $01B51E
        sub.w        ActorX(a3), d0                                ; $01B522
        sub.w        ActorY(a3), d1                                ; $01B526
        jsr          OctagonalDistance.l                           ; $01B52A
        move.l       a0, -(a7)                                     ; $01B530
        movea.l      a3, a0                                        ; $01B532
        bsr.w        GetVisibleMapBase                             ; $01B534
        move.w       ActorX(a0), d1                                ; $01B538
        asr.w        #$8, d1                                       ; $01B53C
        adda.w       d1, a1                                        ; $01B53E
        move.w       ActorY(a0), d1                                ; $01B540
        clr.b        d1                                            ; $01B544
        asr.w        #$3, d1                                       ; $01B546
        adda.w       d1, a1                                        ; $01B548
        movea.l      (a7)+, a0                                     ; $01B54A
        clr.w        d1                                            ; $01B54C
        move.b       (a1), d1                                      ; $01B54E
        lea.l        rCellTypeByIndex(a6), a1                      ; $01B550
        move.b       (a1, d1.w), d1                                ; $01B554
        cmpi.b       #$2, d1                                       ; $01B558
        bcs.b        loc_01B566                                    ; $01B55C
        cmpi.b       #$5, d1                                       ; $01B55E
        bhi.b        loc_01B566                                    ; $01B562
        asr.w        #$1, d0                                       ; $01B564

loc_01B566:
        cmpi.w       #$80, d0                                      ; $01B566
        bcc.b        loc_01B5AE                                    ; $01B56A
        move.w       ActorSavedX(a0), d3                           ; $01B56C
        move.w       ActorSavedY(a0), d4                           ; $01B570
        sub.w        ActorX(a3), d3                                ; $01B574
        sub.w        ActorY(a3), d4                                ; $01B578
        asr.w        #$1, d3                                       ; $01B57C
        asr.w        #$1, d4                                       ; $01B57E
        move.w       #$28a, d0                                     ; $01B580
        move.l       a0, -(a7)                                     ; $01B584
        movea.l      a3, a0                                        ; $01B586
        movea.l      ActorHitCallback(a0), a1                      ; $01B588
        move.l       a3, -(a7)                                     ; $01B58C
        jsr          (a1)                                          ; $01B58E
        movea.l      (a7)+, a3                                     ; $01B590
        movea.l      (a7)+, a0                                     ; $01B592
        cmpa.l       #ramPlayerActorProxy, a3                                  ; $01B594
        bne.b        loc_01B5A4                                    ; $01B59A
        asl.w        rPlayerHitImpulseX(a6)                                    ; $01B59C
        asl.w        rPlayerHitImpulseY(a6)                                    ; $01B5A0

loc_01B5A4:
        move.w       #$2a, d0                                      ; $01B5A4
        jmp          RouteSoundEventByActorFloor.l                         ; $01B5A8

loc_01B5AE:
        rts                                                        ; $01B5AE
        ifne *-$1B5B0
        fail "ROM end moved"
        endif
