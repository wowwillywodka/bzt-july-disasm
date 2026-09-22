; $017CC2..$017CC7 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$17CC2
        fail "ROM start moved"
        endif

RetainedActorExitTrampoline:
        jmp          RefreshEnemyTargetOrExit.l                    ; $017CC2
        ifne *-$17CC8
        fail "ROM end moved"
        endif
