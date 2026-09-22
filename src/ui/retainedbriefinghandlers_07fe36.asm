; $07FE36..$07FE4D | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7FE36
        fail "ROM start moved"
        endif

RetainedBriefingHandlers equ $07FE36

        incbin "generated/data/07fe36.bin"
        ifne *-$7FE4E
        fail "ROM end moved"
        endif
