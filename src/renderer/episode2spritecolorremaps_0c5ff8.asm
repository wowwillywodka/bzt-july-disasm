; $0C5FF8..$0C77F7 | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C5FF8
        fail "ROM start moved"
        endif

Episode2SpriteColorRemaps equ $0C5FF8
Episode2SpriteColorRemap01 equ $0C60F8
Episode2SpriteColorRemap02 equ $0C61F8
Episode2SpriteColorRemap03 equ $0C62F8
Episode2SpriteColorRemap04 equ $0C63F8
Episode2SpriteColorRemap05 equ $0C64F8
Episode2SpriteColorRemap06 equ $0C65F8
Episode2SpriteColorRemap07 equ $0C66F8
Episode2SpriteColorRemap08 equ $0C67F8
Episode2SpriteColorRemap09 equ $0C68F8
Episode2SpriteColorRemap10 equ $0C69F8
Episode2SpriteColorRemap11 equ $0C6AF8
Episode2SpriteColorRemap12 equ $0C6BF8
Episode2SpriteColorRemap13 equ $0C6CF8
Episode2SpriteColorRemap14 equ $0C6DF8
Episode2SpriteColorRemap15 equ $0C6EF8
Episode2SpriteColorRemap16 equ $0C6FF8
Episode2SpriteColorRemap17 equ $0C70F8
Episode2SpriteColorRemap18 equ $0C71F8
Episode2SpriteColorRemap19 equ $0C72F8
Episode2SpriteColorRemap20 equ $0C73F8
Episode2SpriteColorRemap21 equ $0C74F8
Episode2SpriteColorRemap22 equ $0C75F8
Episode2SpriteColorRemap23 equ $0C76F8

        incbin "generated/data/0c5ff8.bin"
        ifne *-$C77F8
        fail "ROM end moved"
        endif
