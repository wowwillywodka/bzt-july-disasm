; $09371E..$09379B | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9371E
        fail "ROM start moved"
        endif

Episode4TextureAnimation05 equ $09371E

        incbin "generated/data/09371e.bin"
        ifne *-$9379C
        fail "ROM end moved"
        endif
