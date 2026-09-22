; $164148..$16481F | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$164148
        fail "ROM start moved"
        endif

InventoryIconBankTail equ $164148
Data_1641E0 equ $1641E0
Data_164320 equ $164320

        incbin "generated/data/164148.bin"
        ifne *-$164820
        fail "ROM end moved"
        endif
