; $0141A4..$0141EB | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$141A4
        fail "ROM start moved"
        endif

WeaponActionHandlers equ $0141A4

        incbin "generated/data/0141a4.bin"
        ifne *-$141EC
        fail "ROM end moved"
        endif
