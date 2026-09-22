; $05B9DA..$05C83C | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5B9DA
        fail "ROM start moved"
        endif

GemsPcmSample39 equ $05B9DA

        incbin "generated/data/05b9da.bin"
        ifne *-$5C83D
        fail "ROM end moved"
        endif
