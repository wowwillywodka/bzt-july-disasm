; $0245D4..$028663 | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$245D4
        fail "ROM start moved"
        endif

JulyTitleCompressedTiles equ $0245D4
JulyTitleCompressedTiles_Block00_Symbols equ $024680
JulyTitleCompressedTiles_Block01 equ $026B92
JulyTitleCompressedTiles_Block01_Symbols equ $026D0A

        incbin "generated/data/0245d4.bin"
        ifne *-$28664
        fail "ROM end moved"
        endif
