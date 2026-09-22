; $08FF4A..$090101 | map-grid:22
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8FF4A
        fail "ROM start moved"
        endif

Episode3Floor03Cells equ $08FF4A

        incbin "generated/data/08ff4a.bin"
        ifne *-$90102
        fail "ROM end moved"
        endif
