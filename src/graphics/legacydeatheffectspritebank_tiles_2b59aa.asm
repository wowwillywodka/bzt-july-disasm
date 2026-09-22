; $2B59AA..$2B5FA9 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B59AA
        fail "ROM start moved"
        endif

LegacyDeathEffectSpriteBank_Tiles equ $2B59AA

        incbin "generated/data/2b59aa.bin"
        ifne *-$2B5FAA
        fail "ROM end moved"
        endif
