; $020A3C..$020AB1 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$20A3C
        fail "ROM start moved"
        endif

StatusMessageTileLookup equ $020A3C

        incbin "generated/data/020a3c.bin"
        ifne *-$20AB2
        fail "ROM end moved"
        endif
