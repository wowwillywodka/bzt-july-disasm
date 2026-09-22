; $02BCFC..$02C5B7 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2BCFC
        fail "ROM start moved"
        endif

GemsPatchBank equ $02BCFC

        incbin "generated/data/02bcfc.bin"
        ifne *-$2C5B8
        fail "ROM end moved"
        endif
