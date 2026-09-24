; $017D6C..$017E59 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; LOS gate then sound$2A and AllocateActor. Success: update$1C4FA, draw$1C984, hit$1C4F0; Flags OR$C8, State50. XY offset=(delta ASR4) ASR1; velocity=(delta ASR4)*2; Z=-6, MotionZ=8. No direct target hit here.
        ifne *-$17D6C
        fail "ROM start moved"
        endif

TrySpawnBlueDummyProjectile:
; LOS gate then sound$2A and AllocateActor. Success: update$1C4FA, draw$1C984, hit$1C4F0; Flags OR$C8, State50. XY offset=(delta ASR4) ASR1; velocity=(delta ASR4)*2; Z=-6, MotionZ=8. No direct target hit here.
        movea.l      ActorTarget(a0), a3                           ; $017D6C
        move.w       ActorX(a3), d0                                ; $017D70
        move.w       ActorY(a3), d1                                ; $017D74
        move.w       ActorX(a0), d3                                ; $017D78
        move.w       ActorY(a0), d4                                ; $017D7C
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $017D80
        bne.b        loc_017D28                                    ; $017D84
        movea.l      a0, a3                                        ; $017D86
        move.w       #$2a, d0                                      ; $017D88
        jsr          RouteSoundEventByActorFloor.l                         ; $017D8C
        bsr.w        AllocateActor                                 ; $017D92
        beq.w        loc_017E58                                    ; $017D96
        clr.w        ActorGoalAngle(a0)                            ; $017D9A
        clr.b        ActorUpdateDelay(a0)                          ; $017D9E
        move.l       #UpdateBouncingProjectile, ActorUpdateCallback(a0) ; $017DA2
        move.l       #DrawGunrockProjectileTile, ActorDrawCallback(a0) ; $017DAA
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $017DB2
        ori.w        #ActorFlagAimAnyView, ActorFlags(a0)                          ; $017DBA
; State50 is assigned to the NEW projectile in A0 after AllocateActor; it is not a Blue Dummy AI state.
        move.b       #$32, ActorState(a0)                          ; $017DC0
        movea.l      ActorTarget(a3), a2                           ; $017DC6
        move.w       $24(a2), d0                                   ; $017DCA
        sub.w        ActorX(a3), d0                                ; $017DCE
        asr.w        #$4, d0                                       ; $017DD2
        move.w       d0, d2                                        ; $017DD4
        asl.w        #$1, d2                                       ; $017DD6
        move.w       d2, ActorMotionX(a0)                          ; $017DD8
        asr.w        #$1, d0                                       ; $017DDC
        add.w        ActorX(a3), d0                                ; $017DDE
        move.w       d0, ActorX(a0)                                ; $017DE2
        move.w       $26(a2), d0                                   ; $017DE6
        sub.w        ActorY(a3), d0                                ; $017DEA
        asr.w        #$4, d0                                       ; $017DEE
        move.w       d0, d2                                        ; $017DF0
        asl.w        #$1, d2                                       ; $017DF2
        move.w       d2, ActorMotionY(a0)                          ; $017DF4
        asr.w        #$1, d0                                       ; $017DF8
        add.w        ActorY(a3), d0                                ; $017DFA
        move.w       d0, ActorY(a0)                                ; $017DFE
        move.w       #$fffa, ActorZ(a0)                            ; $017E02
        move.w       #$8, ActorVelocityZ(a0)                       ; $017E08
; Link command04 uses generic projectile payload and subtype0. Owner/target and update callback are not serialized; receiver must be reviewed separately.
        tst.w        rLinkRole(a6)                                 ; $017E0E
        beq.b        loc_017E58                                    ; $017E12
        move.l       #QueueActorPositionLinkCommand, ActorLinkCallback(a0)   ; $017E14
        lea.l        rSharedScratchBuffer(a6), a1                                ; $017E1C
        move.b       #$4, (a1)+                                    ; $017E20
        move.b       ActorLinkId(a0), (a1)+                        ; $017E24
        move.w       ActorX(a0), (a1)+                             ; $017E28
        move.w       ActorY(a0), (a1)+                             ; $017E2C
        move.b       ActorZLow(a0), (a1)+                          ; $017E30
        move.b       ActorFlagsLow(a0), d0                         ; $017E34
        ori.w        #$20, d0                                      ; $017E38
        move.b       d0, (a1)+                                     ; $017E3C
        move.b       ActorFloor(a0), (a1)+                         ; $017E3E
        move.b       #$0, (a1)+                                    ; $017E42
        move.w       ActorMotionX(a0), (a1)+                       ; $017E46
        move.w       ActorMotionY(a0), (a1)+                       ; $017E4A
        lea.l        rSharedScratchBuffer(a6), a0                                ; $017E4E
        jmp          QueueLinkCommand.l                            ; $017E52

loc_017E58:
        rts                                                        ; $017E58
        ifne *-$17E5A
        fail "ROM end moved"
        endif
