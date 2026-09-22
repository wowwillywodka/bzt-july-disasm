; $08EE2C..$08EE3B | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8EE2C
        fail "ROM start moved"
        endif

Episode3Environment equ $08EE2C

        incbin "generated/data/08ee2c.bin"
        ifne *-$8EE3C
        fail "ROM end moved"
        endif
