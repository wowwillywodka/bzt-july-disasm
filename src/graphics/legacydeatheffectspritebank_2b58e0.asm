; $2B58E0..$2B59A9 | sprite-descriptors
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B58E0
        fail "ROM start moved"
        endif

LegacyDeathEffectSpriteBank equ $2B58E0
LegacyDeathEffectSpriteBank_OffsetBase equ $2B58E2
LegacyDeathEffectSpriteBank_Animation00 equ $2B58E6
LegacyDeathEffectSpriteBank_Animation00_View00 equ $2B58EA
LegacyDeathEffectSpriteBank_Animation00_View00_Frame00 equ $2B58EC
LegacyDeathEffectSpriteBank_Animation00_View00_Frame01 equ $2B5912
LegacyDeathEffectSpriteBank_Animation00_View00_Frame02 equ $2B5938
LegacyDeathEffectSpriteBank_Animation00_View00_Frame03 equ $2B595E
LegacyDeathEffectSpriteBank_Animation00_View00_Frame04 equ $2B5984

        incbin "generated/data/2b58e0.bin"
        ifne *-$2B59AA
        fail "ROM end moved"
        endif
