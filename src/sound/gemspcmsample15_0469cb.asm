; $0469CB..$04786A | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$469CB
        fail "ROM start moved"
        endif

GemsPcmSample15 equ $0469CB

        incbin "generated/data/0469cb.bin"
        ifne *-$4786B
        fail "ROM end moved"
        endif
