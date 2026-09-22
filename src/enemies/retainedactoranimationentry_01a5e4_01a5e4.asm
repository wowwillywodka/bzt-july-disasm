; $01A5E4..$01A5F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained animation4/frame1 entry after unconditional recoil draw jump. Active state5 drawing starts separately at $1A5F2.
        ifne *-$1A5E4
        fail "ROM start moved"
        endif

RetainedActorAnimationEntry_01A5E4:
; Retained animation4/frame1 entry after unconditional recoil draw jump. Active state5 drawing starts separately at $1A5F2.
        move.w       #$4, d0                                       ; $01A5E4
        move.w       #$1, d2                                       ; $01A5E8
        jmp          DrawActorAnimation.l                          ; $01A5EC
        ifne *-$1A5F2
        fail "ROM end moved"
        endif
