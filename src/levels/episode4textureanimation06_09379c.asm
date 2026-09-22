; $09379C..$09380D | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9379C
        fail "ROM start moved"
        endif

Episode4TextureAnimation06 equ $09379C

        incbin "generated/data/09379c.bin"
        ifne *-$9380E
        fail "ROM end moved"
        endif
