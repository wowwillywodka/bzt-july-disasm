; $017AA8..$017ACF | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$17AA8
        fail "ROM start moved"
        endif

InventoryChoiceRows equ $017AA8
Data_017AB0 equ $017AB0
Data_017AB8 equ $017AB8
Data_017AC0 equ $017AC0
Data_017AC8 equ $017AC8

        incbin "generated/data/017aa8.bin"
        ifne *-$17AD0
        fail "ROM end moved"
        endif
