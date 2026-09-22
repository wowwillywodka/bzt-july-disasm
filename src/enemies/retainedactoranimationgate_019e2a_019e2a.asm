; $019E2A..$019E43 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$19E2A
        fail "ROM start moved"
        endif

RetainedActorAnimationGate_019E2A:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $019E2A
        beq.w        loc_019E36                                    ; $019E30
        rts                                                        ; $019E34

loc_019E36:
        move.w       #$3, d0                                       ; $019E36
        move.w       #$3, d2                                       ; $019E3A
        jmp          DrawActorAnimation.l                          ; $019E3E
        ifne *-$19E44
        fail "ROM end moved"
        endif
