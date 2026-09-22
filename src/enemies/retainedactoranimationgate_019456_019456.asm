; $019456..$01946F | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$19456
        fail "ROM start moved"
        endif

RetainedActorAnimationGate_019456:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $019456
        beq.w        loc_019462                                    ; $01945C
        rts                                                        ; $019460

loc_019462:
        move.w       #$4, d0                                       ; $019462
        move.w       #$3, d2                                       ; $019466
        jmp          DrawActorAnimation.l                          ; $01946A
        ifne *-$19470
        fail "ROM end moved"
        endif
