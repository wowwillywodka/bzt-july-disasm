; $122990..$1244F7 | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$122990
        fail "ROM start moved"
        endif

Episode4PanoramaCompressedTiles equ $122990
Episode4PanoramaCompressedTiles_Block00_Symbols equ $122A42

        incbin "generated/data/122990.bin"
        ifne *-$1244F8
        fail "ROM end moved"
        endif
