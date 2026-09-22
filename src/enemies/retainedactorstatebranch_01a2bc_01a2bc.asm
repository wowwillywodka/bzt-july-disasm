; $01A2BC..$01A2BF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1A2BC
        fail "ROM start moved"
        endif

RetainedActorStateBranch_01A2BC:
        bra.w        ChooseRandomDoubledRadiusGoal                 ; $01A2BC
        ifne *-$1A2C0
        fail "ROM end moved"
        endif
