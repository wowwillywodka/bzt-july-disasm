; $121664..$122663 | color-remaps
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$121664
        fail "ROM start moved"
        endif

Episode4WallColorRemaps equ $121664
Episode4WallColorRemap01 equ $121764
Episode4WallColorRemap02 equ $121864
Episode4WallColorRemap03 equ $121964
Episode4WallColorRemap04 equ $121A64
Episode4WallColorRemap05 equ $121B64
Episode4WallColorRemap06 equ $121C64
Episode4WallColorRemap07 equ $121D64
Episode4WallColorRemap08 equ $121E64
Episode4WallColorRemap09 equ $121F64
Episode4WallColorRemap10 equ $122064
Episode4WallColorRemap11 equ $122164
Episode4WallColorRemap12 equ $122264
Episode4WallColorRemap13 equ $122364
Episode4WallColorRemap14 equ $122464
Episode4WallColorRemap15 equ $122564

        incbin "generated/data/121664.bin"
        ifne *-$122664
        fail "ROM end moved"
        endif
