; $019C06..$019C13 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$19C06
        fail "ROM start moved"
        endif

RetainedActorAnimationEntry_019C06:
        move.w       #$3, d0                                       ; $019C06
        move.w       #$1, d2                                       ; $019C0A
        jmp          DrawActorAnimation.l                          ; $019C0E
        ifne *-$19C14
        fail "ROM end moved"
        endif
