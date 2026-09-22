; $00980C..$00981B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$980C
        fail "ROM start moved"
        endif

RetainedActorScanBranches:
        bsr.w        EnemiesRoutine_00989E                         ; $00980C
        bra.w        loc_009824                                    ; $009810
        bsr.w        EnemiesRoutine_009860                         ; $009814
        bra.w        loc_0098DC                                    ; $009818
        ifne *-$981C
        fail "ROM end moved"
        endif
