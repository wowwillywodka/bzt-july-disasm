; $091AB8..$091B3F | episode-header
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$91AB8
        fail "ROM start moved"
        endif

Episode4Header equ $091AB8

        incbin "generated/data/091ab8.bin"
        ifne *-$91B40
        fail "ROM end moved"
        endif
