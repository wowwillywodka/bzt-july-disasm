; $07F420..$07F43F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7F420
        fail "ROM start moved"
        endif

DeceasedStampPalette equ $07F420

        incbin "generated/data/07f420.bin"
        ifne *-$7F440
        fail "ROM end moved"
        endif
