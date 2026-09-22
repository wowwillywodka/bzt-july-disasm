; $012A68..$012AAF | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$12A68
        fail "ROM start moved"
        endif

HeldWeaponDrawHandlers equ $012A68

        incbin "generated/data/012a68.bin"
        ifne *-$12AB0
        fail "ROM end moved"
        endif
