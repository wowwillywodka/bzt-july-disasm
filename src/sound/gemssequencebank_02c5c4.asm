; $02C5C4..$02E8D3 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2C5C4
        fail "ROM start moved"
        endif

GemsSequenceBank equ $02C5C4

        incbin "generated/data/02c5c4.bin"
        ifne *-$2E8D4
        fail "ROM end moved"
        endif
