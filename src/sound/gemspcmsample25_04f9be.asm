; $04F9BE..$050526 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4F9BE
        fail "ROM start moved"
        endif

GemsPcmSample25 equ $04F9BE

        incbin "generated/data/04f9be.bin"
        ifne *-$50527
        fail "ROM end moved"
        endif
