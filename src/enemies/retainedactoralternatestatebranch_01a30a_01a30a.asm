; $01A30A..$01A30D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1A30A
        fail "ROM start moved"
        endif

RetainedActorAlternateStateBranch_01A30A:
        bra.w        ChooseRandomDoubledRadiusGoal                 ; $01A30A
        ifne *-$1A30E
        fail "ROM end moved"
        endif
