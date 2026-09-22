; $081C3C..$081C5B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$81C3C
        fail "ROM start moved"
        endif

BriefingTextPalette equ $081C3C

        incbin "generated/data/081c3c.bin"
        ifne *-$81C5C
        fail "ROM end moved"
        endif
