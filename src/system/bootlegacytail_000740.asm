; $000740..$000743 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$740
        fail "ROM start moved"
        endif

BootLegacyTail equ $000740

        incbin "generated/data/000740.bin"
        ifne *-$744
        fail "ROM end moved"
        endif
