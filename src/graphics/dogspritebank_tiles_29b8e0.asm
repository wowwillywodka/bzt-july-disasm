; $29B8E0..$2B58DF | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29B8E0
        fail "ROM start moved"
        endif

DogSpriteBank_Tiles equ $29B8E0

        incbin "generated/data/29b8e0.bin"
        ifne *-$2B58E0
        fail "ROM end moved"
        endif
