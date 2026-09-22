; $11FE64..$121663 | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$11FE64
        fail "ROM start moved"
        endif

Episode4SpriteColorRemaps equ $11FE64
Episode4SpriteColorRemap01 equ $11FF64
Episode4SpriteColorRemap02 equ $120064
Episode4SpriteColorRemap03 equ $120164
Episode4SpriteColorRemap04 equ $120264
Episode4SpriteColorRemap05 equ $120364
Episode4SpriteColorRemap06 equ $120464
Episode4SpriteColorRemap07 equ $120564
Episode4SpriteColorRemap08 equ $120664
Episode4SpriteColorRemap09 equ $120764
Episode4SpriteColorRemap10 equ $120864
Episode4SpriteColorRemap11 equ $120964
Episode4SpriteColorRemap12 equ $120A64
Episode4SpriteColorRemap13 equ $120B64
Episode4SpriteColorRemap14 equ $120C64
Episode4SpriteColorRemap15 equ $120D64
Episode4SpriteColorRemap16 equ $120E64
Episode4SpriteColorRemap17 equ $120F64
Episode4SpriteColorRemap18 equ $121064
Episode4SpriteColorRemap19 equ $121164
Episode4SpriteColorRemap20 equ $121264
Episode4SpriteColorRemap21 equ $121364
Episode4SpriteColorRemap22 equ $121464
Episode4SpriteColorRemap23 equ $121564

        incbin "generated/data/11fe64.bin"
        ifne *-$121664
        fail "ROM end moved"
        endif
