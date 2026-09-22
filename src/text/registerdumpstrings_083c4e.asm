; $083C4E..$083CAF | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$83C4E
        fail "ROM start moved"
        endif

RegisterDumpStrings equ $083C4E
Data_083C52 equ $083C52
Data_083C56 equ $083C56
Data_083C5A equ $083C5A
Data_083C5E equ $083C5E
Data_083C62 equ $083C62
Data_083C66 equ $083C66
Data_083C6A equ $083C6A
Data_083C6E equ $083C6E
Data_083C72 equ $083C72
Data_083C76 equ $083C76
Data_083C7A equ $083C7A
Data_083C7E equ $083C7E
Data_083C82 equ $083C82
Data_083C86 equ $083C86
Data_083C8A equ $083C8A
Data_083C8E equ $083C8E
Data_083C93 equ $083C93
Data_083C96 equ $083C96
Data_083C99 equ $083C99
Data_083C9C equ $083C9C
Data_083CA0 equ $083CA0
Data_083CA4 equ $083CA4
Data_083CA8 equ $083CA8
Data_083CAC equ $083CAC

        incbin "generated/data/083c4e.bin"
        ifne *-$83CB0
        fail "ROM end moved"
        endif
