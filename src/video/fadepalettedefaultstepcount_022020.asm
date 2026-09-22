; $022020..$022021 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$22020
        fail "ROM start moved"
        endif

FadePaletteDefaultStepCount:
        moveq        #$f, d5                                       ; $022020
        ifne *-$22022
        fail "ROM end moved"
        endif
