; $02C5B8..$02C5C3 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2C5B8
        fail "ROM start moved"
        endif

GemsEnvelopeBank equ $02C5B8

        incbin "generated/data/02c5b8.bin"
        ifne *-$2C5C4
        fail "ROM end moved"
        endif
