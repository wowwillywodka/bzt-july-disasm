; $0C77F8..$0C87F7 | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C77F8
        fail "ROM start moved"
        endif

Episode2WallColorRemaps equ $0C77F8
Episode2WallColorRemap01 equ $0C78F8
Episode2WallColorRemap02 equ $0C79F8
Episode2WallColorRemap03 equ $0C7AF8
Episode2WallColorRemap04 equ $0C7BF8
Episode2WallColorRemap05 equ $0C7CF8
Episode2WallColorRemap06 equ $0C7DF8
Episode2WallColorRemap07 equ $0C7EF8
Episode2WallColorRemap08 equ $0C7FF8
Episode2WallColorRemap09 equ $0C80F8
Episode2WallColorRemap10 equ $0C81F8
Episode2WallColorRemap11 equ $0C82F8
Episode2WallColorRemap12 equ $0C83F8
Episode2WallColorRemap13 equ $0C84F8
Episode2WallColorRemap14 equ $0C85F8
Episode2WallColorRemap15 equ $0C86F8

        incbin "generated/data/0c77f8.bin"
        ifne *-$C87F8
        fail "ROM end moved"
        endif
