; $07F4A0..$07F4DF | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7F4A0
        fail "ROM start moved"
        endif

RetainedZtCharacterMenuMarkerTiles equ $07F4A0
RetainedZtCharacterMenuBlankTile equ $07F4C0

        incbin "generated/data/07f4a0.bin"
        ifne *-$7F4E0
        fail "ROM end moved"
        endif
