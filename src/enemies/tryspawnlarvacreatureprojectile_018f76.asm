; $018F76..$01905D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; LOS then sound$2A/allocation. Set update$1CBEE, draw$1CC86, hit$1C4F0; State80. Same delta>>4 launch geometry as Blue Dummy, Z=-6/MotionZ8; allocator Flags1 retained, no OR$C8.
        ifne *-$18F76
        fail "ROM start moved"
        endif

TrySpawnLarvaCreatureProjectile:
; LOS then sound$2A/allocation. Set update$1CBEE, draw$1CC86, hit$1C4F0; State80. Same delta>>4 launch geometry as Blue Dummy, Z=-6/MotionZ8; allocator Flags1 retained, no OR$C8.
        movea.l      ActorTarget(a0), a3                           ; $018F76
        move.w       ActorX(a3), d0                                ; $018F7A
        move.w       ActorY(a3), d1                                ; $018F7E
        move.w       ActorX(a0), d3                                ; $018F82
        move.w       ActorY(a0), d4                                ; $018F86
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $018F8A
        bne.b        loc_018F3A                                    ; $018F8E
        movea.l      a0, a3                                        ; $018F90
        move.w       #$2a, d0                                      ; $018F92
        jsr          SoundRoutine_00DF64.l                         ; $018F96
        bsr.w        AllocateActor                                 ; $018F9C
        beq.w        loc_01905C                                    ; $018FA0
        clr.w        ActorGoalAngle(a0)                            ; $018FA4
; State80 is assigned to the NEW projectile in A0, not to the Larva Creature that fired it.
        move.b       #$50, ActorState(a0)                          ; $018FA8
        clr.b        ActorUpdateDelay(a0)                          ; $018FAE
        move.l       #UpdateSlowProjectile, ActorUpdateCallback(a0) ; $018FB2
        move.l       #DrawSlowProjectileTile, ActorDrawCallback(a0) ; $018FBA
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $018FC2
        movea.l      ActorTarget(a3), a2                           ; $018FCA
        move.w       $24(a2), d0                                   ; $018FCE
        sub.w        ActorX(a3), d0                                ; $018FD2
        asr.w        #$4, d0                                       ; $018FD6
        move.w       d0, d2                                        ; $018FD8
        asl.w        #$1, d2                                       ; $018FDA
        move.w       d2, ActorMotionX(a0)                          ; $018FDC
        asr.w        #$1, d0                                       ; $018FE0
        add.w        ActorX(a3), d0                                ; $018FE2
        move.w       d0, ActorX(a0)                                ; $018FE6
        move.w       $26(a2), d0                                   ; $018FEA
        sub.w        ActorY(a3), d0                                ; $018FEE
        asr.w        #$4, d0                                       ; $018FF2
        move.w       d0, d2                                        ; $018FF4
        asl.w        #$1, d2                                       ; $018FF6
        move.w       d2, ActorMotionY(a0)                          ; $018FF8
        asr.w        #$1, d0                                       ; $018FFC
        add.w        ActorY(a3), d0                                ; $018FFE
        move.w       d0, ActorY(a0)                                ; $019002
        move.w       #$fffa, ActorZ(a0)                            ; $019006
        move.w       #$8, ActorVelocityZ(a0)                       ; $01900C
; Link command04/subtype0 has same generic payload as Blue projectile, although local callbacks differ; remote behavior not certified.
        tst.w        rLinkRole(a6)                                 ; $019012
        beq.b        loc_01905C                                    ; $019016
        move.l       #SoundRoutine_01EDB4, ActorLinkCallback(a0)   ; $019018
        lea.l        -$6fdc(a6), a1                                ; $019020
        move.b       #$4, (a1)+                                    ; $019024
        move.b       ActorLinkId(a0), (a1)+                        ; $019028
        move.w       ActorX(a0), (a1)+                             ; $01902C
        move.w       ActorY(a0), (a1)+                             ; $019030
        move.b       ActorZLow(a0), (a1)+                          ; $019034
        move.b       ActorFlagsLow(a0), d0                         ; $019038
        ori.w        #$20, d0                                      ; $01903C
        move.b       d0, (a1)+                                     ; $019040
        move.b       ActorFloor(a0), (a1)+                         ; $019042
        move.b       #$0, (a1)+                                    ; $019046
        move.w       ActorMotionX(a0), (a1)+                       ; $01904A
        move.w       ActorMotionY(a0), (a1)+                       ; $01904E
        lea.l        -$6fdc(a6), a0                                ; $019052
        jmp          QueueLinkCommand.l                            ; $019056

loc_01905C:
        rts                                                        ; $01905C
        ifne *-$1905E
        fail "ROM end moved"
        endif
