; $015624..$015961 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Definition 01 / sprite bank 01. State CD assigns a movement role; 0 moves, 1 attacks, 2 recoils, 5/6 are weapon-specific death sequences. Name supplied by user; official/custom provenance unspecified. See docs/ENEMY01.md.
        ifne *-$15624
        fail "ROM start moved"
        endif

UpdateBloodBody:
; Definition 01 / sprite bank 01. State CD assigns a movement role; 0 moves, 1 attacks, 2 recoils, 5/6 are weapon-specific death sequences. Name supplied by user; official/custom provenance unspecified. See docs/ENEMY01.md.
        clr.b        ActorUpdateDelay(a0)                          ; $015624
        cmpi.b       #$cd, ActorState(a0)                          ; $015628
        beq.w        BloodBodyAssignMovementRole                   ; $01562E
        cmpi.b       #$5, ActorState(a0)                           ; $015632
        beq.w        BloodBodyTickWeapon0DDeath                    ; $015638
        cmpi.b       #$6, ActorState(a0)                           ; $01563C
        beq.w        BloodBodyTickWeapon0BDeath                    ; $015642
        cmpi.b       #$2, ActorState(a0)                           ; $015646
        bne.w        BloodBodyMoveTowardGoal                       ; $01564C
        move.w       ActorMotionX(a0), d0                          ; $015650
        move.w       ActorMotionY(a0), d1                          ; $015654
        jsr          OctagonalDistance(pc)                         ; $015658
        cmpi.w       #$5a, d0                                      ; $01565C
        bcs.w        BloodBodyChooseNextGoalOrDie                  ; $015660
        move.w       ActorMotionX(a0), d0                          ; $015664
        move.w       ActorMotionY(a0), d1                          ; $015668
        bsr.w        MoveActorWithWallMargin32                     ; $01566C
        asr.w        ActorMotionX(a0)                              ; $015670
        asr.w        ActorMotionY(a0)                              ; $015674
        rts                                                        ; $015678

BloodBodyAssignMovementRole:
; Counts roles of other actors with this exact update callback. No floor/visibility filter. Chooses 1 if count2>=count1, else 2 if count3>=count2, else 3; not a global least-populated-role search.
        move.b       #$0, ActorState(a0)                           ; $01567A
        clr.b        ActorBehaviorByte50(a0)                       ; $015680
        movem.l      d0-d7/a0-a6, -(a7)                            ; $015684
        clr.w        d0                                            ; $015688
        clr.w        d1                                            ; $01568A
        clr.w        d2                                            ; $01568C
        move.w       rActiveActorCount(a6), d7                     ; $01568E
        bne.b        loc_015696                                    ; $015692
; Original malformed-state path: count=0 returns without restoring the 60-byte MOVEM frame. Valid initialization includes the current actor in the active list.
        rts                                                        ; $015694

loc_015696:
        subq.w       #$1, d7                                       ; $015696
        movea.l      rActiveActorHead(a6), a1                      ; $015698

loc_01569C:
        move.l       (a1), -(a7)                                   ; $01569C
        cmpa.l       a0, a1                                        ; $01569E
        beq.b        loc_0156CA                                    ; $0156A0
        cmpi.l       #UpdateBloodBody, ActorUpdateCallback(a1)    ; $0156A2
        bne.b        loc_0156CA                                    ; $0156AA
        cmpi.b       #$1, ActorBehaviorByte50(a1)                  ; $0156AC
        bne.b        loc_0156B6                                    ; $0156B2
        addq.w       #$1, d0                                       ; $0156B4

loc_0156B6:
        cmpi.b       #$2, ActorBehaviorByte50(a1)                  ; $0156B6
        bne.b        loc_0156C0                                    ; $0156BC
        addq.w       #$1, d1                                       ; $0156BE

loc_0156C0:
        cmpi.b       #$3, ActorBehaviorByte50(a1)                  ; $0156C0
        bne.b        loc_0156CA                                    ; $0156C6
        addq.w       #$1, d2                                       ; $0156C8

loc_0156CA:
        movea.l      (a7)+, a1                                     ; $0156CA
        dbra         d7, loc_01569C                                ; $0156CC
        cmp.w        d0, d1                                        ; $0156D0
        blt.b        loc_0156DC                                    ; $0156D2
        move.b       #$1, ActorBehaviorByte50(a0)                  ; $0156D4
        bra.b        loc_0156EE                                    ; $0156DA

loc_0156DC:
        cmp.w        d1, d2                                        ; $0156DC
        blt.b        loc_0156E8                                    ; $0156DE
        move.b       #$2, ActorBehaviorByte50(a0)                  ; $0156E0
        bra.b        loc_0156EE                                    ; $0156E6

loc_0156E8:
        move.b       #$3, ActorBehaviorByte50(a0)                  ; $0156E8

loc_0156EE:
        movem.l      (a7)+, d0-d7/a0-a6                            ; $0156EE
        rts                                                        ; $0156F2

BloodBodyChooseNextGoalOrDie:
        tst.w        ActorHealth(a0)                               ; $0156F4
        bmi.w        BloodBodyEnterDeath                           ; $0156F8
        movea.l      ActorTarget(a0), a3                           ; $0156FC
        jsr          NextRandom.l                                  ; $015700
        swap         d2                                            ; $015706
        andi.w       #$1f, d2                                      ; $015708
        move.w       d2, -(a7)                                     ; $01570C
        move.w       ActorX(a0), d0                                ; $01570E
        sub.w        ActorX(a3), d0                                ; $015712
        move.w       ActorY(a0), d1                                ; $015716
        sub.w        ActorY(a3), d1                                ; $01571A
        jsr          OctagonalDistance(pc)                         ; $01571E
        asr.w        #$6, d0                                       ; $015722
        add.w        (a7)+, d0                                     ; $015724
; Overwrites the just-computed random/distance delay: actual next-move counter is always 15.
        moveq        #$f, d0                                       ; $015726
        move.b       d0, ActorStateCounter(a0)                     ; $015728
        cmpi.b       #$1, ActorBehaviorByte50(a0)                  ; $01572C
        bne.b        loc_015738                                    ; $015732
        bra.w        ChoosePredictedTargetGoal                     ; $015734

loc_015738:
        cmpi.b       #$2, ActorBehaviorByte50(a0)                  ; $015738
        bne.w        ChooseTargetGoalAtPlayerAnglePlus158          ; $01573E
        bra.w        ChooseTargetGoalAtPlayerAnglePlusA8           ; $015742

BloodBodyMoveTowardGoal:
; Each component = clamp(arithmetic_shift((goal-position),3), -18, +18). Collision handling is shared. Movement runs during the attack state too.
        move.w       ActorGoalX(a0), d0                            ; $015746
        sub.w        ActorX(a0), d0                                ; $01574A
        asr.w        #$3, d0                                       ; $01574E
        beq.b        loc_01576A                                    ; $015750
        bpl.b        loc_015760                                    ; $015752
        cmpi.w       #$ffee, d0                                    ; $015754
        bge.b        loc_01576A                                    ; $015758
        move.w       #$ffee, d0                                    ; $01575A
        bra.b        loc_01576A                                    ; $01575E

loc_015760:
        cmpi.w       #$12, d0                                      ; $015760
        ble.b        loc_01576A                                    ; $015764
        move.w       #$12, d0                                      ; $015766

loc_01576A:
        move.w       ActorGoalY(a0), d1                            ; $01576A
        sub.w        ActorY(a0), d1                                ; $01576E
        asr.w        #$3, d1                                       ; $015772
        beq.b        loc_01578E                                    ; $015774
        bpl.b        loc_015784                                    ; $015776
        cmpi.w       #$ffee, d1                                    ; $015778
        bge.b        loc_01578E                                    ; $01577C
        move.w       #$ffee, d1                                    ; $01577E
        bra.b        loc_01578E                                    ; $015782

loc_015784:
        cmpi.w       #$12, d1                                      ; $015784
        ble.b        loc_01578E                                    ; $015788
        move.w       #$12, d1                                      ; $01578A

loc_01578E:
        move.w       d0, ActorMotionX(a0)                          ; $01578E
        move.w       d1, ActorMotionY(a0)                          ; $015792
        bsr.w        MoveActorWithWallMargin32                     ; $015796
        cmpi.b       #$1, ActorState(a0)                           ; $01579A
        beq.b        BloodBodyTickAttack                           ; $0157A0
        subq.b       #$1, ActorStateCounter(a0)                    ; $0157A2
        beq.b        BloodBodyBeginAttack                          ; $0157A6
        jmp          RefreshEnemyTargetOrExit.l                    ; $0157A8

BloodBodyBeginAttack:
        move.b       #$1, ActorState(a0)                           ; $0157AE
        move.b       #$a, ActorStateCounter(a0)                    ; $0157B4

BloodBodyTickAttack:
; Counter decrements before testing. Entry from move state sets 10 then immediately makes it 9; hit attempt at 5, extra sound calls at 4 and 3.
        subq.b       #$1, ActorStateCounter(a0)                    ; $0157BA
        beq.w        BloodBodyChooseNextGoalOrDie                  ; $0157BE
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $0157C2
        beq.b        BloodBodyTryHitTarget                         ; $0157C8
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $0157CA
        beq.b        loc_0157DC                                    ; $0157D0
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $0157D2
        beq.b        loc_0157DC                                    ; $0157D8
        rts                                                        ; $0157DA

loc_0157DC:
        move.w       #$5f, d0                                      ; $0157DC
        jsr          RouteSoundEventByActorFloor(pc)                       ; $0157E0
        move.w       #$83, d0                                      ; $0157E4
        jmp          RouteSoundEventByActorFloor.l                         ; $0157E8

BloodBodyTryHitTarget:
        movea.l      ActorTarget(a0), a3                           ; $0157EE
        move.w       ActorX(a3), d0                                ; $0157F2
        move.w       ActorY(a3), d1                                ; $0157F6
        move.w       ActorX(a0), d3                                ; $0157FA
        move.w       ActorY(a0), d4                                ; $0157FE
; Five-probe obstruction test: nonzero selects a new movement goal and aborts this attack.
        jsr          TraceFiveRayObstructionInActiveWindow.l       ; $015802
        bne.w        BloodBodyChooseNextGoalOrDie                  ; $015808
        move.w       #$400, d3                                     ; $01580C
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $015810
        bpl.b        loc_015826                                    ; $015814
        move.w       #$200, d3                                     ; $015816
        tst.w        rSceneColorMode(a6)                           ; $01581A
        beq.b        loc_015830                                    ; $01581E
        move.w       #$17b, d3                                     ; $015820
        bra.b        loc_015830                                    ; $015824

loc_015826:
        tst.w        rSceneColorMode(a6)                           ; $015826
        beq.b        loc_015840                                    ; $01582A
        move.w       #$300, d3                                     ; $01582C

loc_015830:
        jsr          NextRandom.l                                  ; $015830
        asr.l        #$8, d2                                       ; $015836
        andi.w       #$3ff, d2                                     ; $015838
        cmp.w        d3, d2                                        ; $01583C
        bcc.b        BloodBodyPlayAttackSounds                     ; $01583E

loc_015840:
        move.w       ActorX(a0), d0                                ; $015840
        move.w       ActorY(a0), d1                                ; $015844
        sub.w        ActorX(a3), d0                                ; $015848
        sub.w        ActorY(a3), d1                                ; $01584C
        move.w       d0, d3                                        ; $015850
        move.w       d1, d4                                        ; $015852
        jsr          OctagonalDistance(pc)                         ; $015854
; Strict octagonal distance < $400 (four map cells), not a melee-only contact test.
        cmpi.w       #$400, d0                                     ; $015858
        bcc.b        loc_01588A                                    ; $01585C
; Real NextRandom clobbers D0 and clears its low word. Hit callback at $015874 therefore receives D0.w=0, not the checked distance.
        jsr          NextRandom.w                                  ; $01585E
        asr.w        #$8, d2                                       ; $015862
        andi.w       #$3, d2                                       ; $015864
        beq.w        loc_01588A                                    ; $015868
        move.l       a0, -(a7)                                     ; $01586C
        movea.l      a3, a0                                        ; $01586E
        movea.l      ActorHitCallback(a0), a1                      ; $015870
; Direct target hit callback, A0=target; no projectile actor is allocated here. RNG bits select 0=no hit, 1..3=hit.
        jsr          (a1)                                          ; $015874
        movea.l      (a7)+, a0                                     ; $015876

BloodBodyPlayAttackSounds:
        move.w       #$5f, d0                                      ; $015878
        jsr          RouteSoundEventByActorFloor(pc)                       ; $01587C
        move.w       #$83, d0                                      ; $015880
        jsr          RouteSoundEventByActorFloor.l                         ; $015884

loc_01588A:
        rts                                                        ; $01588A

BloodBodyEnterDeath:
; Normal death installs corpse callbacks and state=3. Health death is checked with BMI (<0), not <=0; special states 5/6 reach this path regardless of remaining health.
        move.l       a0, -(a7)                                     ; $01588C
        move.w       #$1, d0                                       ; $01588E
        jsr          RouteSoundEventByActorFloor(pc)                       ; $015892
        movea.l      (a7)+, a0                                     ; $015896
        tst.b        ActorAlternateDeathSignal(a0)                 ; $015898
        bne.w        EnterLegacyEnemyDeathEffect                   ; $01589C
        andi.w       #$ff2f, ActorFlags(a0)                        ; $0158A0
        move.l       #UpdateBloodBodyCorpse, ActorUpdateCallback(a0) ; $0158A6
        addq.w       #$1, rEnemyDeathsRecorded(a6)                               ; $0158AE
        clr.b        ActorUpdateDelay(a0)                          ; $0158B2
        move.l       #HitBloodBodyCorpse, ActorHitCallback(a0)     ; $0158B6
        move.l       #PlaceCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $0158BE
        tst.b        ActorMarkerTracked(a0)                        ; $0158C6
        beq.b        loc_0158D4                                    ; $0158CA
        move.l       #WriteTrackedCorpseCellAndRemoveActor, ActorExitCallback(a0) ; $0158CC

loc_0158D4:
        move.l       #DrawBloodBodyCorpse, ActorDrawCallback(a0)   ; $0158D4
        clr.w        ActorMotionX(a0)                              ; $0158DC
        clr.w        ActorMotionY(a0)                              ; $0158E0
        move.b       #$3, ActorState(a0)                           ; $0158E4
; Death mode overlays the HIGH byte of ActorGoalY; the old low byte is not cleared.
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $0158EA
        beq.w        loc_015904                                    ; $0158F0
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $0158F4
        beq.w        loc_015904                                    ; $0158FA
        move.b       #$cb, ActorDeathMode(a0)                      ; $0158FE

loc_015904:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $015904
        tst.w        rLinkRole(a6)                                 ; $01590A
        bne.b        loc_015912                                    ; $01590E
        rts                                                        ; $015910

loc_015912:
        move.l       #$1ef6c, ActorLinkCallback(a0)                ; $015912
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01591A
        move.b       #$12, (a1)+                                   ; $01591E
        move.b       ActorLinkId(a0), (a1)+                        ; $015922
        move.w       ActorFlags(a0), d0                            ; $015926
        ori.w        #$20, d0                                      ; $01592A
        move.b       d0, (a1)+                                     ; $01592E
        move.b       ActorFloor(a0), (a1)+                         ; $015930
        lea.l        rSharedScratchBuffer(a6), a0                                ; $015934
        jmp          QueueLinkCommand.l                            ; $015938

BloodBodyTickWeapon0DDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01593E
        bne.w        loc_015950                                    ; $015942
        move.b       #$c8, ActorDeathMode(a0)                      ; $015946
        bra.w        BloodBodyEnterDeath                           ; $01594C

loc_015950:
        rts                                                        ; $015950

BloodBodyTickWeapon0BDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $015952
        bne.b        loc_015950                                    ; $015956
        move.b       #$c9, ActorDeathMode(a0)                      ; $015958
        bra.w        BloodBodyEnterDeath                           ; $01595E
        ifne *-$15962
        fail "ROM end moved"
        endif
