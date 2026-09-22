; $017D32..$017D35 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$17D32
        fail "ROM start moved"
        endif

RetainedActorExitBranch:
        bra.w        RefreshEnemyTargetOrExit                      ; $017D32
        ifne *-$17D36
        fail "ROM end moved"
        endif
