; $00044E..$0004B7 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$44E
        fail "ROM start moved"
        endif

RegionWarningStrings equ $00044E
Data_00046B equ $00046B
Data_00046E equ $00046E

        incbin "generated/data/00044e.bin"
        ifne *-$4B8
        fail "ROM end moved"
        endif
