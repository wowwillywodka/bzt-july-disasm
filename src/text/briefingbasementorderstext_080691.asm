; $080691..$080794 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$80691
        fail "ROM start moved"
        endif

BriefingBasementOrdersText equ $080691

        incbin "generated/data/080691.bin"
        ifne *-$80795
        fail "ROM end moved"
        endif
