; $008B84..$008DD7 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8B84
        fail "ROM start moved"
        endif

VisibleCellHandlers equ $008B84

        incbin "generated/data/008b84.bin"
        ifne *-$8DD8
        fail "ROM end moved"
        endif
