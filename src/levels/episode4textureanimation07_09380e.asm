; $09380E..$09388F | texture-animation
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9380E
        fail "ROM start moved"
        endif

Episode4TextureAnimation07 equ $09380E

        incbin "generated/data/09380e.bin"
        ifne *-$93890
        fail "ROM end moved"
        endif
