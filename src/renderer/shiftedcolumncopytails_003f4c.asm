; $003F4C..$00408F | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3F4C
        fail "ROM start moved"
        endif

ShiftedColumnCopyTails equ $003F4C
ShiftedColumnCopyTailCenter equ ShiftedColumnCopyTails+$A0

        incbin "generated/data/003f4c.bin"
        ifne *-$4090
        fail "ROM end moved"
        endif
