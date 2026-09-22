; $074B64..$076055 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$74B64
        fail "ROM start moved"
        endif

GemsPcmSample61 equ $074B64

        incbin "generated/data/074b64.bin"
        ifne *-$76056
        fail "ROM end moved"
        endif
