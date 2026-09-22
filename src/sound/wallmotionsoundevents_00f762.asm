; $00F762..$00F771 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F762
        fail "ROM start moved"
        endif

WallMotionSoundEvents equ $00F762

        incbin "generated/data/00f762.bin"
        ifne *-$F772
        fail "ROM end moved"
        endif
