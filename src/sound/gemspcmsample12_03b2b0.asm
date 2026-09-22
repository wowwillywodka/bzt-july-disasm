; $03B2B0..$0407CC | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$3B2B0
        fail "ROM start moved"
        endif

GemsPcmSample12 equ $03B2B0

        incbin "generated/data/03b2b0.bin"
        ifne *-$407CD
        fail "ROM end moved"
        endif
