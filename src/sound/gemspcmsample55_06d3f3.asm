; $06D3F3..$06F0C7 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6D3F3
        fail "ROM start moved"
        endif

GemsPcmSample55 equ $06D3F3

        incbin "generated/data/06d3f3.bin"
        ifne *-$6F0C8
        fail "ROM end moved"
        endif
