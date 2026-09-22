; $0F333C..$0F4B3B | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F333C
        fail "ROM start moved"
        endif

Episode3SpriteColorRemaps equ $0F333C
Episode3SpriteColorRemap01 equ $0F343C
Episode3SpriteColorRemap02 equ $0F353C
Episode3SpriteColorRemap03 equ $0F363C
Episode3SpriteColorRemap04 equ $0F373C
Episode3SpriteColorRemap05 equ $0F383C
Episode3SpriteColorRemap06 equ $0F393C
Episode3SpriteColorRemap07 equ $0F3A3C
Episode3SpriteColorRemap08 equ $0F3B3C
Episode3SpriteColorRemap09 equ $0F3C3C
Episode3SpriteColorRemap10 equ $0F3D3C
Episode3SpriteColorRemap11 equ $0F3E3C
Episode3SpriteColorRemap12 equ $0F3F3C
Episode3SpriteColorRemap13 equ $0F403C
Episode3SpriteColorRemap14 equ $0F413C
Episode3SpriteColorRemap15 equ $0F423C
Episode3SpriteColorRemap16 equ $0F433C
Episode3SpriteColorRemap17 equ $0F443C
Episode3SpriteColorRemap18 equ $0F453C
Episode3SpriteColorRemap19 equ $0F463C
Episode3SpriteColorRemap20 equ $0F473C
Episode3SpriteColorRemap21 equ $0F483C
Episode3SpriteColorRemap22 equ $0F493C
Episode3SpriteColorRemap23 equ $0F4A3C

        incbin "generated/data/0f333c.bin"
        ifne *-$F4B3C
        fail "ROM end moved"
        endif
