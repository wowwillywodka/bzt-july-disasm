; $0199EA..$0199ED | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$199EA
        fail "ROM start moved"
        endif

RetainedActorExitBranch_0199EA:
        bra.w        RefreshEnemyTargetOrExit                      ; $0199EA
        ifne *-$199EE
        fail "ROM end moved"
        endif
