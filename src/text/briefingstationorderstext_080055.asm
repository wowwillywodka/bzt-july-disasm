; $080055..$080211 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$80055
        fail "ROM start moved"
        endif

BriefingStationOrdersText equ $080055

        incbin "generated/data/080055.bin"
        ifne *-$80212
        fail "ROM end moved"
        endif
