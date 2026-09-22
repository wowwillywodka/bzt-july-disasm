; $01B866..$01B873 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1B866
        fail "ROM start moved"
        endif

RetainedActorAnimationEntry_01B866:
        move.w       #$1, d0                                       ; $01B866
        move.w       #$1, d2                                       ; $01B86A
        jmp          DrawActorAnimation.l                          ; $01B86E
        ifne *-$1B874
        fail "ROM end moved"
        endif
