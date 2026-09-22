; $093558..$0935D9 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93558
        fail "ROM start moved"
        endif

Episode4TextureAnimation02 equ $093558

        incbin "generated/data/093558.bin"
        ifne *-$935DA
        fail "ROM end moved"
        endif
