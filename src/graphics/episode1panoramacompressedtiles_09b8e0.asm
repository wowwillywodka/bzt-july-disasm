; $09B8E0..$09C7F7 | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9B8E0
        fail "ROM start moved"
        endif

Episode1PanoramaCompressedTiles equ $09B8E0
Episode1PanoramaCompressedTiles_Block00_Symbols equ $09BA40

        incbin "generated/data/09b8e0.bin"
        ifne *-$9C7F8
        fail "ROM end moved"
        endif
