; $0836BC..$0836DB | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$836BC
        fail "ROM start moved"
        endif

OptionsBlankTile equ $0836BC

        incbin "generated/data/0836bc.bin"
        ifne *-$836DC
        fail "ROM end moved"
        endif
