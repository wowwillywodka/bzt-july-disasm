; $0129D6..$012A1D | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$129D6
        fail "ROM start moved"
        endif

HeldWeaponGraphicsPointers equ $0129D6

        incbin "generated/data/0129d6.bin"
        ifne *-$12A1E
        fail "ROM end moved"
        endif
