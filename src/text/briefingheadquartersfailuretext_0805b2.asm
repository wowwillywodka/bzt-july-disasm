; $0805B2..$080690 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$805B2
        fail "ROM start moved"
        endif

BriefingHeadquartersFailureText equ $0805B2

        incbin "generated/data/0805b2.bin"
        ifne *-$80691
        fail "ROM end moved"
        endif
