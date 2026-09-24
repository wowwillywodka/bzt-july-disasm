; $07C1A0..$07C91F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7C1A0
        fail "ROM start moved"
        endif

CharacterMenuPromptTileUploadIndices equ $07C1A0

        incbin "generated/data/07c1a0.bin"
        ifne *-$7C920
        fail "ROM end moved"
        endif
