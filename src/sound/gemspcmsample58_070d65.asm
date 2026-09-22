; $070D65..$071BA8 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$70D65
        fail "ROM start moved"
        endif

GemsPcmSample58 equ $070D65

        incbin "generated/data/070d65.bin"
        ifne *-$71BA9
        fail "ROM end moved"
        endif
