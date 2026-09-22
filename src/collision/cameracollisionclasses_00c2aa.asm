; $00C2AA..$00C3A9 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C2AA
        fail "ROM start moved"
        endif

CameraCollisionClasses equ $00C2AA

        incbin "generated/data/00c2aa.bin"
        ifne *-$C3AA
        fail "ROM end moved"
        endif
