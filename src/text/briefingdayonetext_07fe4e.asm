; $07FE4E..$080054 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7FE4E
        fail "ROM start moved"
        endif

BriefingDayOneText equ $07FE4E

        incbin "generated/data/07fe4e.bin"
        ifne *-$80055
        fail "ROM end moved"
        endif
