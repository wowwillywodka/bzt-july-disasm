; $1624C8..$162547 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1624C8
        fail "ROM start moved"
        endif

InventoryIconPalettes equ $1624C8

        incbin "generated/data/1624c8.bin"
        ifne *-$162548
        fail "ROM end moved"
        endif
