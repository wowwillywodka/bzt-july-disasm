; $01C4FA..$01C595 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Blue Dummy gunrock-style projectile; also player weapons. Point-sampled XY collision, axis bounce with signed NEG/ASR1, ground physics and byte fuse. No actor/player proximity hit in this flight callback.
        ifne *-$1C4FA
        fail "ROM start moved"
        endif

UpdateBouncingProjectile:
; Blue Dummy gunrock-style projectile; also player weapons. Point-sampled XY collision, axis bounce with signed NEG/ASR1, ground physics and byte fuse. No actor/player proximity hit in this flight callback.
        clr.b        ActorUpdateDelay(a0)                          ; $01C4FA
        move.w       ActorMotionX(a0), d0                          ; $01C4FE
        or.w         ActorMotionY(a0), d0                          ; $01C502
        beq.w        TickBouncingProjectileHeight                  ; $01C506
        move.w       ActorX(a0), d0                                ; $01C50A
        add.w        ActorMotionX(a0), d0                          ; $01C50E
        move.w       ActorY(a0), d1                                ; $01C512
        add.w        ActorMotionY(a0), d1                          ; $01C516
; Tests ONLY next XY, no swept path and no Z check. Disabled surface test always returns clear, so special remove branch at $1C524 is not taken by ordinary execution.
        bsr.w        TestProjectilePointInActiveWindow             ; $01C51A
        beq.b        CommitBouncingProjectileXY                    ; $01C51E
        bsr.w        DisabledActorProjectileSurfaceTest            ; $01C520
        bne.w        RemoveActorAndSendLink                        ; $01C524
        move.w       #$63, d0                                      ; $01C528
        move.l       a0, -(a7)                                     ; $01C52C
        jsr          SoundRoutine_00DF64.l                         ; $01C52E
        movea.l      (a7)+, a0                                     ; $01C534
        move.w       ActorX(a0), d0                                ; $01C536
        add.w        ActorMotionX(a0), d0                          ; $01C53A
        move.w       ActorY(a0), d1                                ; $01C53E
        bsr.w        TestProjectilePointInActiveWindow             ; $01C542
        beq.b        loc_01C56C                                    ; $01C546
        move.w       ActorX(a0), d0                                ; $01C548
        move.w       ActorY(a0), d1                                ; $01C54C
        add.w        ActorMotionY(a0), d1                          ; $01C550
        bsr.w        TestProjectilePointInActiveWindow             ; $01C554
        beq.b        BounceProjectileX                             ; $01C558

BounceProjectileBothAxes:
; Both axes bounce if both isolated probes agree (both blocked OR both clear); preserve the original corner response.
        neg.w        ActorMotionY(a0)                              ; $01C55A
        asr.w        ActorMotionY(a0)                              ; $01C55E

BounceProjectileX:
        neg.w        ActorMotionX(a0)                              ; $01C562
        asr.w        ActorMotionX(a0)                              ; $01C566
        bra.b        CommitBouncingProjectileXY                    ; $01C56A

loc_01C56C:
        move.w       ActorX(a0), d0                                ; $01C56C
        move.w       ActorY(a0), d1                                ; $01C570
        add.w        ActorMotionY(a0), d1                          ; $01C574
        bsr.w        TestProjectilePointInActiveWindow             ; $01C578
        beq.b        BounceProjectileBothAxes                      ; $01C57C

BounceProjectileY:
        neg.w        ActorMotionY(a0)                              ; $01C57E
        asr.w        ActorMotionY(a0)                              ; $01C582

CommitBouncingProjectileXY:
        move.w       ActorMotionX(a0), d0                          ; $01C586
        add.w        d0, ActorX(a0)                                ; $01C58A
        move.w       ActorMotionY(a0), d0                          ; $01C58E
        add.w        d0, ActorY(a0)                                ; $01C592
        ifne *-$1C596
        fail "ROM end moved"
        endif
