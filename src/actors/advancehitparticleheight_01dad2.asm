; $01DAD2..$01DB13 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: integrate Z/velocity and settle at Z=-32;
; landing selects state 2 and the ground-phase link callback.
        ifne *-$1DAD2
        fail "ROM start moved"
        endif

AdvanceHitParticleHeight:
        cmpi.w       #$ffe0, ActorZ(a0)                            ; $01DAD2
        beq.b        loc_01DB12                                    ; $01DAD8
        move.w       ActorVelocityZ(a0), d0                        ; $01DADA
        add.w        d0, ActorZ(a0)                                ; $01DADE
        cmpi.w       #$ffe0, ActorZ(a0)                            ; $01DAE2
        bgt.b        loc_01DB0C                                    ; $01DAE8
        move.w       #$ffe0, ActorZ(a0)                            ; $01DAEA
        clr.w        ActorMotionX(a0)                              ; $01DAF0
        clr.w        ActorMotionY(a0)                              ; $01DAF4
        move.l       #QueueActorLinkCommand10StateCounter0B, ActorLinkCallback(a0)                ; $01DAF8
        move.b       #$2, ActorState(a0)                           ; $01DB00
        clr.b        ActorStateCounter(a0)                         ; $01DB06
        bra.b        loc_01DB12                                    ; $01DB0A

loc_01DB0C:
        subq.w       #$2, d0                                       ; $01DB0C
        move.w       d0, ActorVelocityZ(a0)                        ; $01DB0E

loc_01DB12:
        rts                                                        ; $01DB12
        ifne *-$1DB14
        fail "ROM end moved"
        endif
