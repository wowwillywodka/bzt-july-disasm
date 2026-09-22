; $01624C..$01624D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1624C
        fail "ROM start moved"
        endif

RetainedActorStateReturn:
        rts                                                        ; $01624C
        ifne *-$1624E
        fail "ROM end moved"
        endif
