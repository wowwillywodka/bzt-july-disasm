; $06F0C8..$06FF0B | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6F0C8
        fail "ROM start moved"
        endif

GemsPcmSample56 equ $06F0C8

        incbin "generated/data/06f0c8.bin"
        ifne *-$6FF0C
        fail "ROM end moved"
        endif
