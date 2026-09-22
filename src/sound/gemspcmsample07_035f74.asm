; $035F74..$036FC8 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$35F74
        fail "ROM start moved"
        endif

GemsPcmSample07 equ $035F74

        incbin "generated/data/035f74.bin"
        ifne *-$36FC9
        fail "ROM end moved"
        endif
