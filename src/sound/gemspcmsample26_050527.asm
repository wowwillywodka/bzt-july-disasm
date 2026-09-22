; $050527..$051379 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$50527
        fail "ROM start moved"
        endif

GemsPcmSample26 equ $050527

        incbin "generated/data/050527.bin"
        ifne *-$5137A
        fail "ROM end moved"
        endif
