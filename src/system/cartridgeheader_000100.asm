; $000100..$0001FF | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$100
        fail "ROM start moved"
        endif

CartridgeHeader equ $000100
Data_0001A4 equ $0001A4
Data_0001F0 equ $0001F0

        incbin "generated/data/000100.bin"
        ifne *-$200
        fail "ROM end moved"
        endif
