; $022712..$022791 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$22712
        fail "ROM start moved"
        endif

BlackFadePalette equ $022712

        incbin "generated/data/022712.bin"
        ifne *-$22792
        fail "ROM end moved"
        endif
