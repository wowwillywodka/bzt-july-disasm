; $05AB6C..$05B9D9 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5AB6C
        fail "ROM start moved"
        endif

GemsPcmSample38 equ $05AB6C

        incbin "generated/data/05ab6c.bin"
        ifne *-$5B9DA
        fail "ROM end moved"
        endif
