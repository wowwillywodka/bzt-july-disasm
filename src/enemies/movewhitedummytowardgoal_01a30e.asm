; $01A30E..$01A3BD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Clamp each component to +/-50 after ASR3. Attack skips Motion stores and collision. Arrival ASR4 checks both axes but EVERY outcome goes to RefreshEnemyTargetOrExit; no goal reselection here.
        ifne *-$1A30E
        fail "ROM start moved"
        endif

MoveWhiteDummyTowardGoal:
; Clamp each component to +/-50 after ASR3. Attack skips Motion stores and collision. Arrival ASR4 checks both axes but EVERY outcome goes to RefreshEnemyTargetOrExit; no goal reselection here.
        clr.w        d2                                            ; $01A30E
        move.w       ActorGoalX(a0), d0                            ; $01A310
        sub.w        ActorX(a0), d0                                ; $01A314
        asr.w        #$3, d0                                       ; $01A318
        tst.w        d0                                            ; $01A31A
        beq.b        loc_01A336                                    ; $01A31C
        bpl.b        loc_01A32C                                    ; $01A31E
        cmpi.w       #$ffce, d0                                    ; $01A320
        bge.b        loc_01A336                                    ; $01A324
        move.w       #$ffce, d0                                    ; $01A326
        bra.b        loc_01A336                                    ; $01A32A

loc_01A32C:
        cmpi.w       #$32, d0                                      ; $01A32C
        ble.b        loc_01A336                                    ; $01A330
        move.w       #$32, d0                                      ; $01A332

loc_01A336:
        move.w       ActorGoalY(a0), d1                            ; $01A336
        sub.w        ActorY(a0), d1                                ; $01A33A
        asr.w        #$3, d1                                       ; $01A33E
        tst.w        d1                                            ; $01A340
        beq.b        loc_01A35C                                    ; $01A342
        bpl.b        loc_01A352                                    ; $01A344
        cmpi.w       #$ffce, d1                                    ; $01A346
        bge.b        loc_01A35C                                    ; $01A34A
        move.w       #$ffce, d1                                    ; $01A34C
        bra.b        loc_01A35C                                    ; $01A350

loc_01A352:
        cmpi.w       #$32, d1                                      ; $01A352
        ble.b        loc_01A35C                                    ; $01A356
        move.w       #$32, d1                                      ; $01A358

loc_01A35C:
        cmpi.b       #$1, ActorState(a0)                           ; $01A35C
        beq.w        TickWhiteDummyAttack                          ; $01A362
        move.w       d0, ActorMotionX(a0)                          ; $01A366
        move.w       d1, ActorMotionY(a0)                          ; $01A36A
        bsr.w        TickWhiteDummyAttack                          ; $01A36E
        cmpi.b       #$1, ActorState(a0)                           ; $01A372
        beq.w        loc_01A3DC                                    ; $01A378
        move.w       ActorMotionX(a0), d0                          ; $01A37C
        move.w       ActorMotionY(a0), d1                          ; $01A380
        bsr.w        MoveActorWithWallMargin32                     ; $01A384
        move.w       ActorGoalX(a0), d0                            ; $01A388
        sub.w        ActorX(a0), d0                                ; $01A38C
        asr.w        #$4, d0                                       ; $01A390
        move.w       ActorGoalY(a0), d1                            ; $01A392
        sub.w        ActorY(a0), d1                                ; $01A396
        asr.w        #$4, d1                                       ; $01A39A
        tst.w        d0                                            ; $01A39C
        bpl.b        loc_01A3A2                                    ; $01A39E
        neg.w        d0                                            ; $01A3A0

loc_01A3A2:
        cmpi.w       #$32, d0                                      ; $01A3A2
        bgt.w        RefreshEnemyTargetOrExit                      ; $01A3A6
        tst.w        d1                                            ; $01A3AA
        bpl.b        loc_01A3B0                                    ; $01A3AC
        neg.w        d1                                            ; $01A3AE

loc_01A3B0:
        cmpi.w       #$32, d1                                      ; $01A3B0
        bgt.w        RefreshEnemyTargetOrExit                      ; $01A3B4
        jmp          RefreshEnemyTargetOrExit.l                    ; $01A3B8
        ifne *-$1A3BE
        fail "ROM end moved"
        endif
