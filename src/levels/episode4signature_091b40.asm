; $091B40..$091B43 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$91B40
        fail "ROM start moved"
        endif

Episode4Signature equ $091B40

        incbin "generated/data/091b40.bin"
        ifne *-$91B44
        fail "ROM end moved"
        endif
