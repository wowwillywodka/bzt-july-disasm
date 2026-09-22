; $08D4A0..$08D527 | episode-header
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8D4A0
        fail "ROM start moved"
        endif

Episode3Header equ $08D4A0

        incbin "generated/data/08d4a0.bin"
        ifne *-$8D528
        fail "ROM end moved"
        endif
