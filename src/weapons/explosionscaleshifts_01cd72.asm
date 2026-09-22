; $01CD72..$01CD77 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1CD72
        fail "ROM start moved"
        endif

ExplosionScaleShifts equ $01CD72

        incbin "generated/data/01cd72.bin"
        ifne *-$1CD78
        fail "ROM end moved"
        endif
