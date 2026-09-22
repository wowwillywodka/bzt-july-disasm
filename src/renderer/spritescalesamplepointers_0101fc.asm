; $0101FC..$01033F | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$101FC
        fail "ROM start moved"
        endif

SpriteScaleSamplePointers equ $0101FC

        incbin "generated/data/0101fc.bin"
        ifne *-$10340
        fail "ROM end moved"
        endif
