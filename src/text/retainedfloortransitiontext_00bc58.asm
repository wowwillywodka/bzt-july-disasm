; $00BC58..$00BC7D | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$BC58
        fail "ROM start moved"
        endif

RetainedFloorTransitionText equ $00BC58

        incbin "generated/data/00bc58.bin"
        ifne *-$BC7E
        fail "ROM end moved"
        endif
