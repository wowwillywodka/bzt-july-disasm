; $15F5B8..$16015B | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$15F5B8
        fail "ROM start moved"
        endif

GameplayFrameCompressedTiles equ $15F5B8
GameplayFrameCompressedTiles_Block00_Symbols equ $15F7F0

        incbin "generated/data/15f5b8.bin"
        ifne *-$16015C
        fail "ROM end moved"
        endif
