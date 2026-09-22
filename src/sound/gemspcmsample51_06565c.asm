; $06565C..$06649F | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6565C
        fail "ROM start moved"
        endif

GemsPcmSample51 equ $06565C

        incbin "generated/data/06565c.bin"
        ifne *-$664A0
        fail "ROM end moved"
        endif
