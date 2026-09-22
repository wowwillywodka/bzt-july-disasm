; $033F3E..$034D76 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$33F3E
        fail "ROM start moved"
        endif

GemsPcmSample05 equ $033F3E

        incbin "generated/data/033f3e.bin"
        ifne *-$34D77
        fail "ROM end moved"
        endif
