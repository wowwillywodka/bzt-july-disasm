; $00A628..$00A7C9 | actor:38
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$A628
        fail "ROM start moved"
        endif

ActorDefinitions equ $00A628
Data_00A640 equ $00A640
Data_00A64E equ $00A64E
Data_00A666 equ $00A666
Data_00A674 equ $00A674
Data_00A69A equ $00A69A
Data_00A6C0 equ $00A6C0
Data_00A6E6 equ $00A6E6
Data_00A70C equ $00A70C
Data_00A732 equ $00A732
Data_00A758 equ $00A758
Data_00A77E equ $00A77E
Data_00A7A4 equ $00A7A4

        incbin "generated/data/00a628.bin"
        ifne *-$A7CA
        fail "ROM end moved"
        endif
