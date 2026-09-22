; $08367C..$0836BB | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8367C
        fail "ROM start moved"
        endif

OptionsWindowTilePatterns equ $08367C

        incbin "generated/data/08367c.bin"
        ifne *-$836BC
        fail "ROM end moved"
        endif
