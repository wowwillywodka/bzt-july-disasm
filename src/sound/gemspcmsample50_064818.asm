; $064818..$06565B | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$64818
        fail "ROM start moved"
        endif

GemsPcmSample50 equ $064818

        incbin "generated/data/064818.bin"
        ifne *-$6565C
        fail "ROM end moved"
        endif
