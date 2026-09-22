; $08FA14..$08FF49 | map-grid:46
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8FA14
        fail "ROM start moved"
        endif

Episode3Floor02Cells equ $08FA14

        incbin "generated/data/08fa14.bin"
        ifne *-$8FF4A
        fail "ROM end moved"
        endif
