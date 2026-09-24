; $07BDF0..$07C14F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7BDF0
        fail "ROM start moved"
        endif

CharacterMenuSpriteTiles equ $07BDF0
CharacterMenuPromptTiles equ $07BF50

        incbin "generated/data/07bdf0.bin"
        ifne *-$7C150
        fail "ROM end moved"
        endif
