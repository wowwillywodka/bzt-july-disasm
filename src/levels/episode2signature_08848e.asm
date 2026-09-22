; $08848E..$088491 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8848E
        fail "ROM start moved"
        endif

Episode2Signature equ $08848E

        incbin "generated/data/08848e.bin"
        ifne *-$88492
        fail "ROM end moved"
        endif
