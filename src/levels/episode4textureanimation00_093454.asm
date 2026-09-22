; $093454..$0934D5 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93454
        fail "ROM start moved"
        endif

Episode4TextureAnimation00 equ $093454

        incbin "generated/data/093454.bin"
        ifne *-$934D6
        fail "ROM end moved"
        endif
