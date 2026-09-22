; $00EDDC..$00F02F | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$EDDC
        fail "ROM start moved"
        endif

CellInteractionHandlers equ $00EDDC

        incbin "generated/data/00eddc.bin"
        ifne *-$F030
        fail "ROM end moved"
        endif
