; $02A410..$02A44F | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2A410
        fail "ROM start moved"
        endif

PasswordDecoderTable equ $02A410

        incbin "generated/data/02a410.bin"
        ifne *-$2A450
        fail "ROM end moved"
        endif
