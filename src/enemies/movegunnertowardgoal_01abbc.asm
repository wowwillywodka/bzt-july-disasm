; $01ABBC..$01AC69 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Clamp +/-40 after ASR3. Attack skips movement. Both-axis arrival checks after collision all lead to RefreshEnemyTargetOrExit, so goal changes on attack completion/blocked LOS/recoil, not arrival.
        ifne *-$1ABBC
        fail "ROM start moved"
        endif

MoveGunnerTowardGoal:
; Clamp +/-40 after ASR3. Attack skips movement. Both-axis arrival checks after collision all lead to RefreshEnemyTargetOrExit, so goal changes on attack completion/blocked LOS/recoil, not arrival.
        clr.w        d2                                            ; $01ABBC
        move.w       ActorGoalX(a0), d0                            ; $01ABBE
        sub.w        ActorX(a0), d0                                ; $01ABC2
        asr.w        #$3, d0                                       ; $01ABC6
        tst.w        d0                                            ; $01ABC8
        beq.b        loc_01ABE4                                    ; $01ABCA
        bpl.b        loc_01ABDA                                    ; $01ABCC
        cmpi.w       #$ffd8, d0                                    ; $01ABCE
        bge.b        loc_01ABE4                                    ; $01ABD2
        move.w       #$ffd8, d0                                    ; $01ABD4
        bra.b        loc_01ABE4                                    ; $01ABD8

loc_01ABDA:
        cmpi.w       #$28, d0                                      ; $01ABDA
        ble.b        loc_01ABE4                                    ; $01ABDE
        move.w       #$28, d0                                      ; $01ABE0

loc_01ABE4:
        move.w       ActorGoalY(a0), d1                            ; $01ABE4
        sub.w        ActorY(a0), d1                                ; $01ABE8
        asr.w        #$3, d1                                       ; $01ABEC
        tst.w        d1                                            ; $01ABEE
        beq.b        loc_01AC0A                                    ; $01ABF0
        bpl.b        loc_01AC00                                    ; $01ABF2
        cmpi.w       #$ffd8, d1                                    ; $01ABF4
        bge.b        loc_01AC0A                                    ; $01ABF8
        move.w       #$ffd8, d1                                    ; $01ABFA
        bra.b        loc_01AC0A                                    ; $01ABFE

loc_01AC00:
        cmpi.w       #$28, d1                                      ; $01AC00
        ble.b        loc_01AC0A                                    ; $01AC04
        move.w       #$28, d1                                      ; $01AC06

loc_01AC0A:
        cmpi.b       #$1, ActorState(a0)                           ; $01AC0A
        beq.w        TickGunnerAttack                              ; $01AC10
        move.w       d0, ActorMotionX(a0)                          ; $01AC14
        move.w       d1, ActorMotionY(a0)                          ; $01AC18
        bsr.w        TickGunnerAttack                              ; $01AC1C
        cmpi.b       #$1, ActorState(a0)                           ; $01AC20
        beq.w        loc_01AC88                                    ; $01AC26
        move.w       ActorMotionX(a0), d0                          ; $01AC2A
        move.w       ActorMotionY(a0), d1                          ; $01AC2E
        bsr.w        MoveActorWithWallMargin32                     ; $01AC32
        move.w       ActorGoalX(a0), d0                            ; $01AC36
        sub.w        ActorX(a0), d0                                ; $01AC3A
        asr.w        #$4, d0                                       ; $01AC3E
        move.w       ActorGoalY(a0), d1                            ; $01AC40
        sub.w        ActorY(a0), d1                                ; $01AC44
        asr.w        #$4, d1                                       ; $01AC48
        tst.w        d0                                            ; $01AC4A
        bpl.b        loc_01AC50                                    ; $01AC4C
        neg.w        d0                                            ; $01AC4E

loc_01AC50:
        cmpi.w       #$28, d0                                      ; $01AC50
        bgt.w        RefreshEnemyTargetOrExit                      ; $01AC54
        tst.w        d1                                            ; $01AC58
        bpl.b        loc_01AC5E                                    ; $01AC5A
        neg.w        d1                                            ; $01AC5C

loc_01AC5E:
        cmpi.w       #$28, d1                                      ; $01AC5E
        bgt.w        RefreshEnemyTargetOrExit                      ; $01AC62
        bra.w        RefreshEnemyTargetOrExit                      ; $01AC66
        ifne *-$1AC6A
        fail "ROM end moved"
        endif
