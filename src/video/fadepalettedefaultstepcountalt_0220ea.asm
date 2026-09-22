; $0220EA..$0220EB | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$220EA
        fail "ROM start moved"
        endif

FadePaletteDefaultStepCountAlt:
        moveq        #$f, d5                                       ; $0220EA
        ifne *-$220EC
        fail "ROM end moved"
        endif
