; $034D77..$035F73 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$34D77
        fail "ROM start moved"
        endif

GemsPcmSample06 equ $034D77

        incbin "generated/data/034d77.bin"
        ifne *-$35F74
        fail "ROM end moved"
        endif
