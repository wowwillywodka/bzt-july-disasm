; $07C920..$07C93F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7C920
        fail "ROM start moved"
        endif

CharacterMenuBackgroundPalette equ $07C920

        incbin "generated/data/07c920.bin"
        ifne *-$7C940
        fail "ROM end moved"
        endif
