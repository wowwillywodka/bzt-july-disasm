; $00D274..$00D275 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$D274
        fail "ROM start moved"
        endif

ReturnFromWallProjection:
        rts                                                        ; $00D274
        ifne *-$D276
        fail "ROM end moved"
        endif
