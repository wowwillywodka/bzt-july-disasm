; $05D696..$05E42F | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5D696
        fail "ROM start moved"
        endif

GemsPcmSample41 equ $05D696

        incbin "generated/data/05d696.bin"
        ifne *-$5E430
        fail "ROM end moved"
        endif
