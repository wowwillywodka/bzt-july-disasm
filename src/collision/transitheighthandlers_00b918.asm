; $00B918..$00BA0F | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$B918
        fail "ROM start moved"
        endif

TransitHeightHandlers equ $00B918

        incbin "generated/data/00b918.bin"
        ifne *-$BA10
        fail "ROM end moved"
        endif
