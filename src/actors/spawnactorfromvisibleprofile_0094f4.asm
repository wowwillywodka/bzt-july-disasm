; $0094F4..$009625 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$94F4
        fail "ROM start moved"
        endif

SpawnActorFromVisibleProfile:
; Visible-profile path; octagonal distance must be < $800 to instantiate the actor.
        movem.w      d0-d2, -(a7)                                  ; $0094F4
        add.w        rPlayerCellX(a6), d0                          ; $0094F8
        lsl.w        #$8, d0                                       ; $0094FC
        addi.w       #$80, d0                                      ; $0094FE
        sub.w        rPlayerX(a6), d0                              ; $009502
        add.w        rPlayerCellY(a6), d1                          ; $009506
        lsl.w        #$8, d1                                       ; $00950A
        addi.w       #$80, d1                                      ; $00950C
        sub.w        rPlayerY(a6), d1                              ; $009510
        bsr.w        OctagonalDistance                             ; $009514
        cmpi.w       #$800, d0                                     ; $009518
        bcs.b        loc_00952C                                    ; $00951C
        movem.w      (a7)+, d0-d2                                  ; $00951E
        jsr          QueueProjectedWorldObject.l                   ; $009522
        clr.w        d3                                            ; $009528
        rts                                                        ; $00952A

loc_00952C:
        movem.w      (a7)+, d0-d2                                  ; $00952C
        movem.l      d0/a0-a1, -(a7)                               ; $009530
        cmpa.l       #$ffa5fa, a0                                  ; $009534
        bcs.b        loc_009544                                    ; $00953A
        cmpa.l       #$ffe5fa, a0                                  ; $00953C
        bcs.b        loc_00954A                                    ; $009542

loc_009544:
        movea.l      #$ffa9fa, a0                                  ; $009544

loc_00954A:
; Clear and commit the spawn cell BEFORE allocation. A full actor pool does not restore this marker.
        clr.b        (a0)                                          ; $00954A
        jsr          CommitMapCellAndSendLink.l                    ; $00954C
        move.w       d0, d3                                        ; $009552
        jsr          AllocateActor.l                               ; $009554
        beq.w        loc_00961E                                    ; $00955A
        movea.l      rPendingActorDefinition(a6), a1               ; $00955E
        clr.b        ActorUpdateDelay(a0)                          ; $009562
        move.l       (a1), ActorUpdateCallback(a0)                 ; $009566
        move.l       ActorDefDraw(a1), ActorDrawCallback(a0)       ; $00956A
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $009570
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $009576
        move.l       ActorDefExit(a1), ActorExitCallback(a0)       ; $00957C
        move.w       ActorDefFlags(a1), d0                         ; $009582
        or.w         d0, ActorFlags(a0)                            ; $009586
        move.w       ActorDefHealth(a1), ActorHealth(a0)           ; $00958A
        add.w        rPlayerCellX(a6), d3                          ; $009590
        lsl.w        #$8, d3                                       ; $009594
        addi.w       #$80, d3                                      ; $009596
        move.w       d3, ActorX(a0)                                ; $00959A
        move.w       d1, d3                                        ; $00959E
        add.w        rPlayerCellY(a6), d3                          ; $0095A0
        lsl.w        #$8, d3                                       ; $0095A4
        addi.w       #$80, d3                                      ; $0095A6
        move.w       d3, ActorY(a0)                                ; $0095AA
        move.w       ActorDefZ(a1), ActorZ(a0)                     ; $0095AE
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $0095B4
        clr.b        ActorState(a0)                                ; $0095BA
        move.b       #$cd, ActorState(a0)                          ; $0095BE
        move.b       #$14, ActorStateCounter(a0)                   ; $0095C4
        clr.b        ActorUnknown45(a0)                            ; $0095CA
        move.w       rPlayerX(a6), ActorGoalX(a0)                  ; $0095CE
        move.w       rPlayerY(a6), ActorGoalY(a0)                  ; $0095D4
        move.l       ActorDefSpriteBank(a1), ActorSpriteBank(a0)   ; $0095DA
        move.b       ActorDefExitCellProfile(a1), ActorExitCellProfile(a0) ; $0095E0
        move.b       ActorDefCorpseCellProfile(a1), ActorCorpseCellProfile(a0) ; $0095E6
        move.l       #ramPlayerActorProxy, ActorTarget(a0)         ; $0095EC
        move.w       ActorDefSpawnSound(a1), d0                    ; $0095F4
        bsr.b        RendererRoutine_009626                        ; $0095F8
; Clear tracking flag, set only if ROM marker matcher succeeds. All four original July episode marker counts are0; ordinary spawn does not enable the problematic tracked-move tail.
        clr.b        ActorMarkerTracked(a0)                        ; $0095FA
        jsr          CheckEnemyKeyPosition.l                       ; $0095FE
        tst.w        d0                                            ; $009604
        bne.b        loc_00960C                                    ; $009606
        st.b         ActorMarkerTracked(a0)                        ; $009608

loc_00960C:
        tst.w        rLinkRole(a6)                                 ; $00960C
        beq.b        loc_00961E                                    ; $009610
        move.l       ActorDefLink(a1), ActorLinkCallback(a0)       ; $009612
        movea.l      ActorDefSendSpawn(a1), a1                     ; $009618
; Definition +$20: sends initial actor state through link command $04; not sprite data.
        jsr          (a1)                                          ; $00961C

loc_00961E:
        movem.l      (a7)+, d0/a0-a1                               ; $00961E
        clr.w        d3                                            ; $009622
        rts                                                        ; $009624
        ifne *-$9626
        fail "ROM end moved"
        endif
