; $0802F1..$080488 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$802F1
        fail "ROM start moved"
        endif

BriefingStationCompleteText equ $0802F1

        incbin "generated/data/0802f1.bin"
        ifne *-$80489
        fail "ROM end moved"
        endif
