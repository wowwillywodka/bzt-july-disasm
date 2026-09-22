; $098DB4..$09A5B3 | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$98DB4
        fail "ROM start moved"
        endif

Episode1SpriteColorRemaps equ $098DB4
Episode1SpriteColorRemap01 equ $098EB4
Episode1SpriteColorRemap02 equ $098FB4
Episode1SpriteColorRemap03 equ $0990B4
Episode1SpriteColorRemap04 equ $0991B4
Episode1SpriteColorRemap05 equ $0992B4
Episode1SpriteColorRemap06 equ $0993B4
Episode1SpriteColorRemap07 equ $0994B4
Episode1SpriteColorRemap08 equ $0995B4
Episode1SpriteColorRemap09 equ $0996B4
Episode1SpriteColorRemap10 equ $0997B4
Episode1SpriteColorRemap11 equ $0998B4
Episode1SpriteColorRemap12 equ $0999B4
Episode1SpriteColorRemap13 equ $099AB4
Episode1SpriteColorRemap14 equ $099BB4
Episode1SpriteColorRemap15 equ $099CB4
Episode1SpriteColorRemap16 equ $099DB4
Episode1SpriteColorRemap17 equ $099EB4
Episode1SpriteColorRemap18 equ $099FB4
Episode1SpriteColorRemap19 equ $09A0B4
Episode1SpriteColorRemap20 equ $09A1B4
Episode1SpriteColorRemap21 equ $09A2B4
Episode1SpriteColorRemap22 equ $09A3B4
Episode1SpriteColorRemap23 equ $09A4B4

        incbin "generated/data/098db4.bin"
        ifne *-$9A5B4
        fail "ROM end moved"
        endif
