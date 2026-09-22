; $000436..$00044D | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$436
        fail "ROM start moved"
        endif

RegionCompatibilityData equ $000436
Data_00043A equ $00043A

        incbin "generated/data/000436.bin"
        ifne *-$44E
        fail "ROM end moved"
        endif
