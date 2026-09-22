; $05C83D..$05D695 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5C83D
        fail "ROM start moved"
        endif

GemsPcmSample40 equ $05C83D

        incbin "generated/data/05c83d.bin"
        ifne *-$5D696
        fail "ROM end moved"
        endif
