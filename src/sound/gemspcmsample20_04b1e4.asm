; $04B1E4..$04C09A | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4B1E4
        fail "ROM start moved"
        endif

GemsPcmSample20 equ $04B1E4

        incbin "generated/data/04b1e4.bin"
        ifne *-$4C09B
        fail "ROM end moved"
        endif
