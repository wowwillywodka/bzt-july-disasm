; $07BDF0..$07C14F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7BDF0
        fail "ROM start moved"
        endif

CharacterMenuFrameTiles equ $07BDF0

        incbin "generated/data/07bdf0.bin"
        ifne *-$7C150
        fail "ROM end moved"
        endif
