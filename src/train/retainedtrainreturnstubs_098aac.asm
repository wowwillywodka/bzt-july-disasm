; $098AAC..$098AB1 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$98AAC
        fail "ROM start moved"
        endif

RetainedTrainReturnStubs:
        rts                                                        ; $098AAC
        rts                                                        ; $098AAE
        rts                                                        ; $098AB0
        ifne *-$98AB2
        fail "ROM end moved"
        endif
