; $0CAB3C..$0CBB3B | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$CAB3C
        fail "ROM start moved"
        endif

Episode2PanoramaTilemap equ $0CAB3C

        incbin "generated/data/0cab3c.bin"
        ifne *-$CBB3C
        fail "ROM end moved"
        endif
