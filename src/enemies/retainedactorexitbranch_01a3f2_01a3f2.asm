; $01A3F2..$01A3F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1A3F2
        fail "ROM start moved"
        endif

RetainedActorExitBranch_01A3F2:
        bra.w        RefreshEnemyTargetOrExit                      ; $01A3F2
        ifne *-$1A3F6
        fail "ROM end moved"
        endif
