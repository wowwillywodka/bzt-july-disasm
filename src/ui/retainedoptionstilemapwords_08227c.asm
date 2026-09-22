; $08227C..$08367B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8227C
        fail "ROM start moved"
        endif

RetainedOptionsTilemapWords equ $08227C

        incbin "generated/data/08227c.bin"
        ifne *-$8367C
        fail "ROM end moved"
        endif
