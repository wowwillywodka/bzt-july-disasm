; $0149F0..$014A0F | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$149F0
        fail "ROM start moved"
        endif

DestructibleWallCellVariants equ $0149F0
Data_0149F1 equ $0149F1
Data_0149F2 equ $0149F2
Data_0149F3 equ $0149F3
Data_0149F4 equ $0149F4
Data_0149F5 equ $0149F5
Data_0149F6 equ $0149F6
Data_0149F7 equ $0149F7
Data_0149F8 equ $0149F8
Data_014A00 equ $014A00
Data_014A08 equ $014A08

        incbin "generated/data/0149f0.bin"
        ifne *-$14A10
        fail "ROM end moved"
        endif
