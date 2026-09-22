; $05F5D8..$060415 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5F5D8
        fail "ROM start moved"
        endif

GemsPcmSample44 equ $05F5D8

        incbin "generated/data/05f5d8.bin"
        ifne *-$60416
        fail "ROM end moved"
        endif
