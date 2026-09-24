; $07C9A0..$07EB5F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7C9A0
        fail "ROM start moved"
        endif

DeceasedStampTiles equ $07C9A0

        incbin "generated/data/07c9a0.bin"
        ifne *-$7EB60
        fail "ROM end moved"
        endif
