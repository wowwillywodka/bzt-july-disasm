; $07A719..$07A71B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7A719
        fail "ROM start moved"
        endif

GemsSampleBankAlignment equ $07A719

        incbin "generated/data/07a719.bin"
        ifne *-$7A71C
        fail "ROM end moved"
        endif
