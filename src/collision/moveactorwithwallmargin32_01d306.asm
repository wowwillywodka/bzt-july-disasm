; $01D306..$01D467 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=actor,D0/D1=requested XY delta. Point-cell test, Y-before-X fallback, neighbor wall margin32, then push from GLOBAL local player. Writes XY, NOT MotionXY. Returns actual delta ONLY when ActorMarkerTracked=0; helper $97920 otherwise overwrites D0/D1. See docs/ENEMY_MOVEMENT.md.
        ifne *-$1D306
        fail "ROM start moved"
        endif

MoveActorWithWallMargin32:
; A0=actor,D0/D1=requested XY delta. Point-cell test, Y-before-X fallback, neighbor wall margin32, then push from GLOBAL local player. Writes XY, NOT MotionXY. Returns actual delta ONLY when ActorMarkerTracked=0; helper $97920 otherwise overwrites D0/D1. See docs/ENEMY_MOVEMENT.md.
        move.w       ActorY(a0), -(a7)                             ; $01D306
        move.w       ActorX(a0), -(a7)                             ; $01D30A
        lea.l        rCellTypeByIndex(a6), a5                      ; $01D30E
        bsr.w        GetVisibleMapBase                             ; $01D312
        clr.w        d3                                            ; $01D316
; Test raw NEXT cell -> current type LUT -> binary EnemyWalkabilityClasses. No diagonal half-cell geometry, path sweep, other-actor list, floor or Z check.
        move.w       ActorX(a0), d2                                ; $01D318
        add.w        d0, d2                                        ; $01D31C
        asr.w        #$8, d2                                       ; $01D31E
        move.w       ActorY(a0), d4                                ; $01D320
        add.w        d1, d4                                        ; $01D324
        clr.b        d4                                            ; $01D326
        asr.w        #$3, d4                                       ; $01D328
        add.w        d4, d2                                        ; $01D32A
        move.b       (a1, d2.w), d3                                ; $01D32C
        move.b       (a5, d3.w), d3                                ; $01D330
        bsr.w        GetEnemyWalkability                           ; $01D334
        beq.b        loc_01D380                                    ; $01D338

Margin32TryYOnly:
; Blocked diagonal: try oldX/newY FIRST. If clear commit Y only and skip X test; otherwise try newX/oldY. Both blocked ->no requested movement.
        move.w       ActorX(a0), d2                                ; $01D33A
        asr.w        #$8, d2                                       ; $01D33E
        move.w       ActorY(a0), d4                                ; $01D340
        add.w        d1, d4                                        ; $01D344
        clr.b        d4                                            ; $01D346
        asr.w        #$3, d4                                       ; $01D348
        add.w        d4, d2                                        ; $01D34A
        move.b       (a1, d2.w), d3                                ; $01D34C
        move.b       (a5, d3.w), d3                                ; $01D350
        bsr.w        GetEnemyWalkability                           ; $01D354
        beq.b        loc_01D384                                    ; $01D358

Margin32TryXOnly:
        move.w       ActorX(a0), d2                                ; $01D35A
        add.w        d0, d2                                        ; $01D35E
        asr.w        #$8, d2                                       ; $01D360
        move.w       ActorY(a0), d4                                ; $01D362
        clr.b        d4                                            ; $01D366
        asr.w        #$3, d4                                       ; $01D368
        add.w        d4, d2                                        ; $01D36A
        move.b       (a1, d2.w), d3                                ; $01D36C
        move.b       (a5, d3.w), d3                                ; $01D370
        bsr.w        GetEnemyWalkability                           ; $01D374
        bne.b        Margin32ClampNearWalls                        ; $01D378
        add.w        d0, ActorX(a0)                                ; $01D37A
        bra.b        Margin32ClampNearWalls                        ; $01D37E

loc_01D380:
        add.w        d0, ActorX(a0)                                ; $01D380

loc_01D384:
        add.w        d1, ActorY(a0)                                ; $01D384

Margin32ClampNearWalls:
; Neighbor margin in final cell: fraction<$20 with blocked left/up ->$20; fraction>$DF with blocked right/down ->$DF. Can move an actor even for input delta0. No map-row bounds check.
        move.w       ActorX(a0), d2                                ; $01D388
        asr.w        #$8, d2                                       ; $01D38C
        move.w       ActorY(a0), d4                                ; $01D38E
        clr.b        d4                                            ; $01D392
        asr.w        #$3, d4                                       ; $01D394
        add.w        d4, d2                                        ; $01D396
        adda.w       d2, a1                                        ; $01D398
        move.b       ActorFractionX(a0), d2                        ; $01D39A
        cmpi.b       #$20, d2                                      ; $01D39E
        bcc.b        loc_01D3BA                                    ; $01D3A2
        move.b       -$1(a1), d3                                   ; $01D3A4
        move.b       (a5, d3.w), d3                                ; $01D3A8
        bsr.w        GetEnemyWalkability                           ; $01D3AC
        beq.b        loc_01D3D4                                    ; $01D3B0
        move.b       #$20, ActorFractionX(a0)                      ; $01D3B2
        bra.b        loc_01D3D4                                    ; $01D3B8

loc_01D3BA:
        cmpi.b       #$df, d2                                      ; $01D3BA
        bls.b        loc_01D3D4                                    ; $01D3BE
        move.b       $1(a1), d3                                    ; $01D3C0
        move.b       (a5, d3.w), d3                                ; $01D3C4
        bsr.w        GetEnemyWalkability                           ; $01D3C8
        beq.b        loc_01D3D4                                    ; $01D3CC
        move.b       #$df, ActorFractionX(a0)                      ; $01D3CE

loc_01D3D4:
        move.b       ActorFractionY(a0), d2                        ; $01D3D4
        cmpi.b       #$20, d2                                      ; $01D3D8
        bcc.b        loc_01D3F4                                    ; $01D3DC
        move.b       -$20(a1), d3                                  ; $01D3DE
        move.b       (a5, d3.w), d3                                ; $01D3E2
        bsr.w        GetEnemyWalkability                           ; $01D3E6
        beq.b        Margin32PushFromLocalPlayer                   ; $01D3EA
        move.b       #$20, ActorFractionY(a0)                      ; $01D3EC
        bra.b        Margin32PushFromLocalPlayer                   ; $01D3F2

loc_01D3F4:
        cmpi.b       #$df, d2                                      ; $01D3F4
        bls.b        Margin32PushFromLocalPlayer                   ; $01D3F8
        move.b       $20(a1), d3                                   ; $01D3FA
        move.b       (a5, d3.w), d3                                ; $01D3FE
        bsr.w        GetEnemyWalkability                           ; $01D402
        beq.b        Margin32PushFromLocalPlayer                   ; $01D406
        move.b       #$df, ActorFractionY(a0)                      ; $01D408

Margin32PushFromLocalPlayer:
; Player separation uses GLOBAL player XY, not ActorTarget; no floor/Z filter. If distance+1 unsigned <$20 and nonzero: newXY=playerXY+trunc(delta*32/(distance+1)). Exact overlap stays overlap. No wall recheck afterward.
        move.w       ActorX(a0), d0                                ; $01D40E
        sub.w        rPlayerX(a6), d0                              ; $01D412
        move.w       ActorY(a0), d1                                ; $01D416
        sub.w        rPlayerY(a6), d1                              ; $01D41A
        move.w       d0, d3                                        ; $01D41E
        move.w       d1, d4                                        ; $01D420
        jsr          OctagonalDistance.l                           ; $01D422
        addq.w       #$1, d0                                       ; $01D428
        beq.b        Margin32ReturnDisplacement                    ; $01D42A
        cmpi.w       #$20, d0                                      ; $01D42C
        bcc.b        Margin32ReturnDisplacement                    ; $01D430
        ext.l        d3                                            ; $01D432
        ext.l        d4                                            ; $01D434
        lsl.l        #$5, d3                                       ; $01D436
        lsl.l        #$5, d4                                       ; $01D438
        divs.w       d0, d3                                        ; $01D43A
        divs.w       d0, d4                                        ; $01D43C
        add.w        rPlayerX(a6), d3                              ; $01D43E
        add.w        rPlayerY(a6), d4                              ; $01D442
        move.w       d3, ActorX(a0)                                ; $01D446
        move.w       d4, ActorY(a0)                                ; $01D44A

Margin32ReturnDisplacement:
; Compute finalXY-entryXY in D0/D1. MotionXY unchanged, including after sliding/clamping/push.
        move.w       ActorX(a0), d0                                ; $01D44E
        sub.w        (a7)+, d0                                     ; $01D452
        move.w       ActorY(a0), d1                                ; $01D454
        sub.w        (a7)+, d1                                     ; $01D458
        tst.b        ActorMarkerTracked(a0)                        ; $01D45A
        beq.b        loc_01D466                                    ; $01D45E
; Tracked-marker exception: helper overwrites D0/D1 with estimated OLD cell coordinates and clobbers A1/D7. They no longer report actual movement.
        jsr          UpdateTrackedActorMarkerAfterMove.l           ; $01D460

loc_01D466:
        rts                                                        ; $01D466
        ifne *-$1D468
        fail "ROM end moved"
        endif
