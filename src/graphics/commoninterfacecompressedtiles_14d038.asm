; $14D038..$14D68F | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$14D038
        fail "ROM start moved"
        endif

CommonInterfaceCompressedTiles equ $14D038
CommonInterfaceCompressedTiles_Block00_Symbols equ $14D1D4

        incbin "generated/data/14d038.bin"
        ifne *-$14D690
        fail "ROM end moved"
        endif
