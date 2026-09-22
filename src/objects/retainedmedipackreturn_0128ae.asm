; $0128AE..$0128AF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$128AE
        fail "ROM start moved"
        endif

RetainedMedipackReturn:
        rts                                                        ; $0128AE
        ifne *-$128B0
        fail "ROM end moved"
        endif
