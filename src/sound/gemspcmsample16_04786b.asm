; $04786B..$0486ED | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4786B
        fail "ROM start moved"
        endif

GemsPcmSample16 equ $04786B

        incbin "generated/data/04786b.bin"
        ifne *-$486EE
        fail "ROM end moved"
        endif
