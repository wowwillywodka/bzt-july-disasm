; $0F4B3C..$0F5B3B | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$F4B3C
        fail "ROM start moved"
        endif

Episode3WallColorRemaps equ $0F4B3C
Episode3WallColorRemap01 equ $0F4C3C
Episode3WallColorRemap02 equ $0F4D3C
Episode3WallColorRemap03 equ $0F4E3C
Episode3WallColorRemap04 equ $0F4F3C
Episode3WallColorRemap05 equ $0F503C
Episode3WallColorRemap06 equ $0F513C
Episode3WallColorRemap07 equ $0F523C
Episode3WallColorRemap08 equ $0F533C
Episode3WallColorRemap09 equ $0F543C
Episode3WallColorRemap10 equ $0F553C
Episode3WallColorRemap11 equ $0F563C
Episode3WallColorRemap12 equ $0F573C
Episode3WallColorRemap13 equ $0F583C
Episode3WallColorRemap14 equ $0F593C
Episode3WallColorRemap15 equ $0F5A3C

        incbin "generated/data/0f4b3c.bin"
        ifne *-$F5B3C
        fail "ROM end moved"
        endif
