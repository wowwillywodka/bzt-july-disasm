; $07C150..$07C19F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7C150
        fail "ROM start moved"
        endif

CharacterMenuFrameRow equ $07C150

        incbin "generated/data/07c150.bin"
        ifne *-$7C1A0
        fail "ROM end moved"
        endif
