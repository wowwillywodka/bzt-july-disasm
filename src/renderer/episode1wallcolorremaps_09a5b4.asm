; $09A5B4..$09B5B3 | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$9A5B4
        fail "ROM start moved"
        endif

Episode1WallColorRemaps equ $09A5B4
Episode1WallColorRemap01 equ $09A6B4
Episode1WallColorRemap02 equ $09A7B4
Episode1WallColorRemap03 equ $09A8B4
Episode1WallColorRemap04 equ $09A9B4
Episode1WallColorRemap05 equ $09AAB4
Episode1WallColorRemap06 equ $09ABB4
Episode1WallColorRemap07 equ $09ACB4
Episode1WallColorRemap08 equ $09ADB4
Episode1WallColorRemap09 equ $09AEB4
Episode1WallColorRemap10 equ $09AFB4
Episode1WallColorRemap11 equ $09B0B4
Episode1WallColorRemap12 equ $09B1B4
Episode1WallColorRemap13 equ $09B2B4
Episode1WallColorRemap14 equ $09B3B4
Episode1WallColorRemap15 equ $09B4B4

        incbin "generated/data/09a5b4.bin"
        ifne *-$9B5B4
        fail "ROM end moved"
        endif
