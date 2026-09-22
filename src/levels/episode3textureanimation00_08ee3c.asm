; $08EE3C..$08EEAD | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8EE3C
        fail "ROM start moved"
        endif

Episode3TextureAnimation00 equ $08EE3C

        incbin "generated/data/08ee3c.bin"
        ifne *-$8EEAE
        fail "ROM end moved"
        endif
