; $0136F0..$0137AF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$136F0
        fail "ROM start moved"
        endif

WeaponOverlaySpriteMappings equ $0136F0

        incbin "generated/data/0136f0.bin"
        ifne *-$137B0
        fail "ROM end moved"
        endif
