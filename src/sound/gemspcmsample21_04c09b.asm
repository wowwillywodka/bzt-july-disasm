; $04C09B..$04CED3 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4C09B
        fail "ROM start moved"
        endif

GemsPcmSample21 equ $04C09B

        incbin "generated/data/04c09b.bin"
        ifne *-$4CED4
        fail "ROM end moved"
        endif
