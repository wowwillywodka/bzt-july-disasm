; $04CED4..$04DD21 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4CED4
        fail "ROM start moved"
        endif

GemsPcmSample22 equ $04CED4

        incbin "generated/data/04ced4.bin"
        ifne *-$4DD22
        fail "ROM end moved"
        endif
