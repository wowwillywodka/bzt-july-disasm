; $028664..$028683 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$28664
        fail "ROM start moved"
        endif

JulyTitlePalette equ $028664

        incbin "generated/data/028664.bin"
        ifne *-$28684
        fail "ROM end moved"
        endif
