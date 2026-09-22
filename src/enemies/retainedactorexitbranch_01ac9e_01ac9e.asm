; $01AC9E..$01ACA1 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1AC9E
        fail "ROM start moved"
        endif

RetainedActorExitBranch_01AC9E:
        bra.w        RefreshEnemyTargetOrExit                      ; $01AC9E
        ifne *-$1ACA2
        fail "ROM end moved"
        endif
