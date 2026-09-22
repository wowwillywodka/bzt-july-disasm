; $06C39E..$06D3F2 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6C39E
        fail "ROM start moved"
        endif

GemsPcmSample54 equ $06C39E

        incbin "generated/data/06c39e.bin"
        ifne *-$6D3F3
        fail "ROM end moved"
        endif
