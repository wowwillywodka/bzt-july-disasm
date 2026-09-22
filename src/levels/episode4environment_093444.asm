; $093444..$093453 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$93444
        fail "ROM start moved"
        endif

Episode4Environment equ $093444

        incbin "generated/data/093444.bin"
        ifne *-$93454
        fail "ROM end moved"
        endif
