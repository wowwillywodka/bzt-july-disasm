; $09365C..$09371D | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9365C
        fail "ROM start moved"
        endif

Episode4TextureAnimation04 equ $09365C

        incbin "generated/data/09365c.bin"
        ifne *-$9371E
        fail "ROM end moved"
        endif
