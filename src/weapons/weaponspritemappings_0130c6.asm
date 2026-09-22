; $0130C6..$0130ED | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$130C6
        fail "ROM start moved"
        endif

WeaponSpriteMappings equ $0130C6

        incbin "generated/data/0130c6.bin"
        ifne *-$130EE
        fail "ROM end moved"
        endif
