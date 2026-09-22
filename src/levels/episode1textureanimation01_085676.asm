; $085676..$0856AB | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$85676
        fail "ROM start moved"
        endif

Episode1TextureAnimation01 equ $085676

        incbin "generated/data/085676.bin"
        ifne *-$856AC
        fail "ROM end moved"
        endif
