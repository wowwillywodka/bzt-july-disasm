; $01CBEE..$01CC13 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Larva slow projectile; also player weapon. State byte fuse decremented; zero or blocked next point ->finish. Otherwise commit XY. Z=-6 and VelocityZ8 from spawn are NOT integrated by this callback.
        ifne *-$1CBEE
        fail "ROM start moved"
        endif

UpdateSlowProjectile:
; Larva slow projectile; also player weapon. State byte fuse decremented; zero or blocked next point ->finish. Otherwise commit XY. Z=-6 and VelocityZ8 from spawn are NOT integrated by this callback.
        clr.b        ActorUpdateDelay(a0)                          ; $01CBEE
        subq.b       #$1, ActorState(a0)                           ; $01CBF2
        beq.b        FinishSlowProjectileAtNextPoint               ; $01CBF6
        bsr.w        GetVisibleMapBase                             ; $01CBF8
        move.w       ActorX(a0), d0                                ; $01CBFC
        add.w        ActorMotionX(a0), d0                          ; $01CC00
        move.w       ActorY(a0), d1                                ; $01CC04
        add.w        ActorMotionY(a0), d1                          ; $01CC08
        bsr.w        TestProjectilePointInActiveWindow             ; $01CC0C
        beq.w        loc_01CC7C                                    ; $01CC10
        ifne *-$1CC14
        fail "ROM end moved"
        endif
