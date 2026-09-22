; $160A1C..$160D7B | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$160A1C
        fail "ROM start moved"
        endif

GameplayFrameAuxiliaryData equ $160A1C
Data_160CFC equ $160CFC

        incbin "generated/data/160a1c.bin"
        ifne *-$160D7C
        fail "ROM end moved"
        endif
