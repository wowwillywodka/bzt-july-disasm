; $00028E..$0002C3 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$28E
        fail "ROM start moved"
        endif

BootHardwareTables equ $00028E

        incbin "generated/data/00028e.bin"
        ifne *-$2C4
        fail "ROM end moved"
        endif
