; $003924..$0039C4 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3924
        fail "ROM start moved"
        endif

LevelStatisticsStrings equ $003924
Data_003939 equ $003939
Data_00394E equ $00394E
Data_003963 equ $003963
Data_003978 equ $003978
Data_00398D equ $00398D
Data_0039A2 equ $0039A2
Data_0039A9 equ $0039A9
Data_0039AE equ $0039AE
Data_0039B3 equ $0039B3
Data_0039C3 equ $0039C3

        incbin "generated/data/003924.bin"
        ifne *-$39C5
        fail "ROM end moved"
        endif
