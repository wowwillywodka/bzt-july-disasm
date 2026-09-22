; $012ECE..$012EF5 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$12ECE
        fail "ROM start moved"
        endif

RetainedWeaponSpriteMappings equ $012ECE

        incbin "generated/data/012ece.bin"
        ifne *-$12EF6
        fail "ROM end moved"
        endif
