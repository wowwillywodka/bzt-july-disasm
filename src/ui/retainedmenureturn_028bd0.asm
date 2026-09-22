; $028BD0..$028BD1 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: isolated RTS after text routine
        ifne *-$28BD0
        fail "ROM start moved"
        endif

RetainedMenuReturn:
        rts                                                        ; $028BD0
        ifne *-$28BD2
        fail "ROM end moved"
        endif
