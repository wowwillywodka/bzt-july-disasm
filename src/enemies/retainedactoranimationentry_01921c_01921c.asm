; $01921C..$019229 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1921C
        fail "ROM start moved"
        endif

RetainedActorAnimationEntry_01921C:
        move.w       #$4, d0                                       ; $01921C
        move.w       #$1, d2                                       ; $019220
        jmp          DrawActorAnimation.l                          ; $019224
        ifne *-$1922A
        fail "ROM end moved"
        endif
