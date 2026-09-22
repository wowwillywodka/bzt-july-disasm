; $08EEAE..$08EF8B | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8EEAE
        fail "ROM start moved"
        endif

Episode3TextureAnimation01 equ $08EEAE

        incbin "generated/data/08eeae.bin"
        ifne *-$8EF8C
        fail "ROM end moved"
        endif
