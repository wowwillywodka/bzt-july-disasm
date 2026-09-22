; $086F3C..$087283 | map-grid:30
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$86F3C
        fail "ROM start moved"
        endif

Episode1Floor04Cells equ $086F3C

        incbin "generated/data/086f3c.bin"
        ifne *-$87284
        fail "ROM end moved"
        endif
