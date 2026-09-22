; $0198B4..$0198B5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$198B4
        fail "ROM start moved"
        endif

RetainedActorReturn_0198B4:
        rts                                                        ; $0198B4
        ifne *-$198B6
        fail "ROM end moved"
        endif
