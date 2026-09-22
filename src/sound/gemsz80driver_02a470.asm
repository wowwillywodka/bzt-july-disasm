; $02A470..$02BCFB | z80:gems
; Maintained assembly input; no extraction occurs during build.
        ifne *-$2A470
        fail "ROM start moved"
        endif

GemsZ80Driver:
        incbin "build/gems.bin"
        ifne *-$2BCFC
        fail "ROM end moved"
        endif
