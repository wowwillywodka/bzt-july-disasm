; $122664..$12266F | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$122664
        fail "ROM start moved"
        endif

Episode4FloorColorModes equ $122664

        incbin "generated/data/122664.bin"
        ifne *-$122670
        fail "ROM end moved"
        endif
