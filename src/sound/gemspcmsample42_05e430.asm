; $05E430..$05EEAF | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5E430
        fail "ROM start moved"
        endif

GemsPcmSample42 equ $05E430

        incbin "generated/data/05e430.bin"
        ifne *-$5EEB0
        fail "ROM end moved"
        endif
