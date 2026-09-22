; $03085D..$030D70 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3085D
        fail "ROM start moved"
        endif

GemsPcmSample02 equ $03085D

        incbin "generated/data/03085d.bin"
        ifne *-$30D71
        fail "ROM end moved"
        endif
