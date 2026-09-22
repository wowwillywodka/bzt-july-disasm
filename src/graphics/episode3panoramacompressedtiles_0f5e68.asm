; $0F5E68..$0F7663 | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F5E68
        fail "ROM start moved"
        endif

Episode3PanoramaCompressedTiles equ $0F5E68
Episode3PanoramaCompressedTiles_Block00_Symbols equ $0F5F50

        incbin "generated/data/0f5e68.bin"
        ifne *-$F7664
        fail "ROM end moved"
        endif
