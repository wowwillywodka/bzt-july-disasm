; $0C87F8..$0C8803 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C87F8
        fail "ROM start moved"
        endif

Episode2FloorColorModes equ $0C87F8

        incbin "generated/data/0c87f8.bin"
        ifne *-$C8804
        fail "ROM end moved"
        endif
