; $030D71..$032907 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$30D71
        fail "ROM start moved"
        endif

GemsPcmSample03 equ $030D71

        incbin "generated/data/030d71.bin"
        ifne *-$32908
        fail "ROM end moved"
        endif
