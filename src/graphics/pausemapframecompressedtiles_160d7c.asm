; $160D7C..$161C07 | byte-pair
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$160D7C
        fail "ROM start moved"
        endif

PauseMapFrameCompressedTiles equ $160D7C
PauseMapFrameCompressedTiles_Block00_Symbols equ $160F4E

        incbin "generated/data/160d7c.bin"
        ifne *-$161C08
        fail "ROM end moved"
        endif
