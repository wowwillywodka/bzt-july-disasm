; $0453FF..$0469CA | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$453FF
        fail "ROM start moved"
        endif

GemsPcmSample14 equ $0453FF

        incbin "generated/data/0453ff.bin"
        ifne *-$469CB
        fail "ROM end moved"
        endif
