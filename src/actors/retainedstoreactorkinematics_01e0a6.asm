; $01E0A6..$01E0DB | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1E0A6
        fail "ROM start moved"
        endif

RetainedStoreActorKinematics:
        movem.w      d3-d4, -(a7)                                  ; $01E0A6
        move.w       d0, ActorX(a0)                                ; $01E0AA
        move.w       d1, ActorY(a0)                                ; $01E0AE
        move.w       d3, ActorMotionX(a0)                          ; $01E0B2
        move.w       d4, ActorMotionY(a0)                          ; $01E0B6
        move.w       d5, ActorZ(a0)                                ; $01E0BA
        move.w       d6, ActorVelocityZ(a0)                        ; $01E0BE
        clr.b        ActorUpdateDelay(a0)                          ; $01E0C2
        move.l       #WeaponsRoutine_01E0DC, ActorUpdateCallback(a0) ; $01E0C6
        move.l       #RendererRoutine_01E1AE, ActorDrawCallback(a0) ; $01E0CE
        movem.w      (a7)+, d3-d4                                  ; $01E0D6
        rts                                                        ; $01E0DA
        ifne *-$1E0DC
        fail "ROM end moved"
        endif
