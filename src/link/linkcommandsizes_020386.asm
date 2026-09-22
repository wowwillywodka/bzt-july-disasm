; $020386..$0203A1 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$20386
        fail "ROM start moved"
        endif

LinkCommandSizes equ $020386

        incbin "generated/data/020386.bin"
        ifne *-$203A2
        fail "ROM end moved"
        endif
