; $073829..$074B63 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$73829
        fail "ROM start moved"
        endif

GemsPcmSample60 equ $073829

        incbin "generated/data/073829.bin"
        ifne *-$74B64
        fail "ROM end moved"
        endif
