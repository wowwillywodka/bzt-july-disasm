; $08EF8C..$08F051 | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8EF8C
        fail "ROM start moved"
        endif

Episode3TextureAnimation02 equ $08EF8C

        incbin "generated/data/08ef8c.bin"
        ifne *-$8F052
        fail "ROM end moved"
        endif
