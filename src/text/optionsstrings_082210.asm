; $082210..$08226B | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$82210
        fail "ROM start moved"
        endif

OptionsStrings equ $082210
Data_08221A equ $08221A
Data_082223 equ $082223
Data_08222A equ $08222A
Data_082231 equ $082231
Data_08223D equ $08223D
Data_08224E equ $08224E
Data_08225E equ $08225E
Data_082262 equ $082262
Data_082266 equ $082266

        incbin "generated/data/082210.bin"
        ifne *-$8226C
        fail "ROM end moved"
        endif
