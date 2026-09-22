; $080489..$0805B1 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$80489
        fail "ROM start moved"
        endif

BriefingHeadquartersOrdersText equ $080489

        incbin "generated/data/080489.bin"
        ifne *-$805B2
        fail "ROM end moved"
        endif
