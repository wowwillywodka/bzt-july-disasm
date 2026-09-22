; $080212..$0802F0 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$80212
        fail "ROM start moved"
        endif

BriefingStationFailureText equ $080212

        incbin "generated/data/080212.bin"
        ifne *-$802F1
        fail "ROM end moved"
        endif
