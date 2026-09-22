; $018F44..$018F47 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$18F44
        fail "ROM start moved"
        endif

RetainedActorExitBranch_018F44:
        bra.w        RefreshEnemyTargetOrExit                      ; $018F44
        ifne *-$18F48
        fail "ROM end moved"
        endif
