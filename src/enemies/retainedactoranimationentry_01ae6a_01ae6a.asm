; $01AE6A..$01AE77 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained animation3/frame1 entry. State5 branches past it to $1AE78.
        ifne *-$1AE6A
        fail "ROM start moved"
        endif

RetainedActorAnimationEntry_01AE6A:
; Retained animation3/frame1 entry. State5 branches past it to $1AE78.
        move.w       #$3, d0                                       ; $01AE6A
        move.w       #$1, d2                                       ; $01AE6E
        jmp          DrawActorAnimation.l                          ; $01AE72
        ifne *-$1AE78
        fail "ROM end moved"
        endif
