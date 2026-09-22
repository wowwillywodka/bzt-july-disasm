; $0227D2..$022811 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$227D2
        fail "ROM start moved"
        endif

InterfacePalettes equ $0227D2

        incbin "generated/data/0227d2.bin"
        ifne *-$22812
        fail "ROM end moved"
        endif
