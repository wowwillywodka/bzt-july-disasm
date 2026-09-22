; $0C8B24..$0CAB3B | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C8B24
        fail "ROM start moved"
        endif

Episode2PanoramaCompressedTiles equ $0C8B24
Episode2PanoramaCompressedTiles_Block00_Symbols equ $0C8BF4

        incbin "generated/data/0c8b24.bin"
        ifne *-$CAB3C
        fail "ROM end moved"
        endif
