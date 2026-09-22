; $0856AC..$0856ED | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$856AC
        fail "ROM start moved"
        endif

Episode1TextureAnimation02 equ $0856AC

        incbin "generated/data/0856ac.bin"
        ifne *-$856EE
        fail "ROM end moved"
        endif
