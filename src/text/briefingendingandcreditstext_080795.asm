; $080795..$08187E | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$80795
        fail "ROM start moved"
        endif

BriefingEndingAndCreditsText equ $080795

        incbin "generated/data/080795.bin"
        ifne *-$8187F
        fail "ROM end moved"
        endif
