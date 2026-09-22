; $0664A0..$06B559 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$664A0
        fail "ROM start moved"
        endif

GemsPcmSample52 equ $0664A0

        incbin "generated/data/0664a0.bin"
        ifne *-$6B55A
        fail "ROM end moved"
        endif
