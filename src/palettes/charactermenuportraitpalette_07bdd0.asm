; $07BDD0..$07BDEF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7BDD0
        fail "ROM start moved"
        endif

CharacterMenuPortraitPalette equ $07BDD0

        incbin "generated/data/07bdd0.bin"
        ifne *-$7BDF0
        fail "ROM end moved"
        endif
