; $015480..$015623 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Spawn up to two ordinary actors from PendingActorDefinition at D0/D1 and D3/D4, state $CD. These are not debris sprites. Distance >=$800 uses a raw local-marker write with original fixed-point inputs; no commit. See limitations in WALL_CHANGES.md.
        ifne *-$15480
        fail "ROM start moved"
        endif

SpawnWallReleasedActorPair:
; Spawn up to two ordinary actors from PendingActorDefinition at D0/D1 and D3/D4, state $CD. These are not debris sprites. Distance >=$800 uses a raw local-marker write with original fixed-point inputs; no commit. See limitations in WALL_CHANGES.md.
        movem.w      d0-d2, -(a7)                                  ; $015480
        movem.w      d0-d4, -(a7)                                  ; $015484
        sub.w        rPlayerX(a6), d0                              ; $015488
        sub.w        rPlayerY(a6), d1                              ; $01548C
        bsr.w        OctagonalDistance                             ; $015490
        cmpi.w       #$800, d0                                     ; $015494
        bcs.b        loc_0154B0                                    ; $015498
        movem.w      (a7)+, d0-d4                                  ; $01549A
        movem.w      (a7)+, d0-d2                                  ; $01549E
        lsl.w        #$5, d1                                       ; $0154A2
        add.w        d0, d1                                        ; $0154A4
        lea.l        rVisibleMapWindow(a6), a0                     ; $0154A6
        move.b       d2, (a0, d1.w)                                ; $0154AA
        rts                                                        ; $0154AE

loc_0154B0:
        jsr          AllocateActor.l                               ; $0154B0
; Allocation-failure branch reaches $015618 without popping the saved D0-D4 words. Preserve original stack behavior; pair creation is not guaranteed.
        beq.w        loc_015618                                    ; $0154B6
        movem.w      (a7)+, d0-d4                                  ; $0154BA
        movea.l      rPendingActorDefinition(a6), a1               ; $0154BE
        clr.b        ActorUpdateDelay(a0)                          ; $0154C2
        move.l       (a1), ActorUpdateCallback(a0)                 ; $0154C6
        move.l       ActorDefDraw(a1), ActorDrawCallback(a0)       ; $0154CA
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $0154D0
        move.l       ActorDefExit(a1), ActorExitCallback(a0)       ; $0154D6
        move.w       ActorDefFlags(a1), d2                         ; $0154DC
        or.w         d2, ActorFlags(a0)                            ; $0154E0
        move.w       ActorDefHealth(a1), ActorHealth(a0)           ; $0154E4
        move.w       d0, ActorX(a0)                                ; $0154EA
        move.w       d1, ActorY(a0)                                ; $0154EE
        move.w       ActorDefZ(a1), ActorZ(a0)                     ; $0154F2
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $0154F8
        move.b       #$cd, ActorState(a0)                          ; $0154FE
        move.b       #$14, ActorStateCounter(a0)                   ; $015504
        clr.b        ActorUnknown45(a0)                            ; $01550A
        move.w       rPlayerX(a6), ActorGoalX(a0)                  ; $01550E
        move.w       rPlayerY(a6), ActorGoalY(a0)                  ; $015514
        addi.w       #$80, ActorGoalX(a0)                          ; $01551A
        subi.w       #$80, ActorGoalY(a0)                          ; $015520
        move.l       ActorDefSpriteBank(a1), ActorSpriteBank(a0)   ; $015526
        move.b       ActorDefExitCellProfile(a1), ActorExitCellProfile(a0) ; $01552C
        move.b       ActorDefCorpseCellProfile(a1), ActorCorpseCellProfile(a0) ; $015532
        move.l       #ramPlayerActorProxy, ActorTarget(a0)         ; $015538
        move.w       d0, -(a7)                                     ; $015540
        move.w       ActorDefSpawnSound(a1), d0                    ; $015542
        jsr          PlayActorSpawnSound.l                      ; $015546
        move.w       (a7)+, d0                                     ; $01554C
        tst.w        rLinkRole(a6)                                 ; $01554E
        beq.b        loc_015560                                    ; $015552
        move.l       ActorDefLink(a1), ActorLinkCallback(a0)       ; $015554
        movea.l      ActorDefSendSpawn(a1), a1                     ; $01555A
; Definition +$20: initial link packet; distinct from recurring +$1C -> actor +$1E callback.
        jsr          (a1)                                          ; $01555E

loc_015560:
        movem.w      d0-d4, -(a7)                                  ; $015560
        jsr          AllocateActor.l                               ; $015564
        beq.w        loc_015618                                    ; $01556A
        movem.w      (a7)+, d0-d4                                  ; $01556E
        movea.l      rPendingActorDefinition(a6), a1               ; $015572
        clr.b        ActorUpdateDelay(a0)                          ; $015576
        move.l       (a1), ActorUpdateCallback(a0)                 ; $01557A
        move.l       ActorDefDraw(a1), ActorDrawCallback(a0)       ; $01557E
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $015584
        move.l       ActorDefExit(a1), ActorExitCallback(a0)       ; $01558A
        move.w       ActorDefFlags(a1), d2                         ; $015590
        or.w         d2, ActorFlags(a0)                            ; $015594
        move.w       ActorDefHealth(a1), ActorHealth(a0)           ; $015598
        addi.w       #$a, d0                                       ; $01559E
        addi.w       #$a, d1                                       ; $0155A2
        move.w       d3, ActorX(a0)                                ; $0155A6
        move.w       d4, ActorY(a0)                                ; $0155AA
        move.w       ActorDefZ(a1), ActorZ(a0)                     ; $0155AE
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $0155B4
        move.b       #$cd, ActorState(a0)                          ; $0155BA
        move.b       #$14, ActorStateCounter(a0)                   ; $0155C0
        clr.b        ActorUnknown45(a0)                            ; $0155C6
        move.w       rPlayerX(a6), ActorGoalX(a0)                  ; $0155CA
        move.w       rPlayerY(a6), ActorGoalY(a0)                  ; $0155D0
        subi.w       #$80, ActorGoalX(a0)                          ; $0155D6
        addi.w       #$80, ActorGoalY(a0)                          ; $0155DC
        move.l       ActorDefSpriteBank(a1), ActorSpriteBank(a0)   ; $0155E2
        move.b       ActorDefExitCellProfile(a1), ActorExitCellProfile(a0) ; $0155E8
        move.b       ActorDefCorpseCellProfile(a1), ActorCorpseCellProfile(a0) ; $0155EE
        move.l       #ramPlayerActorProxy, ActorTarget(a0)         ; $0155F4
        move.w       ActorDefSpawnSound(a1), d0                    ; $0155FC
        jsr          PlayActorSpawnSound.l                      ; $015600
        tst.w        rLinkRole(a6)                                 ; $015606
        beq.b        loc_015618                                    ; $01560A
        move.l       ActorDefLink(a1), ActorLinkCallback(a0)       ; $01560C
        movea.l      ActorDefSendSpawn(a1), a1                     ; $015612
; Definition +$20: initial link packet, same dispatch domain as $00961C.
        jsr          (a1)                                          ; $015616

loc_015618:
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $015618
        movem.w      (a7)+, d0-d2                                  ; $01561E
        rts                                                        ; $015622
        ifne *-$15624
        fail "ROM end moved"
        endif
