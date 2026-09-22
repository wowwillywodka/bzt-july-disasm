; $05EEB0..$05F5D7 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5EEB0
        fail "ROM start moved"
        endif

GemsPcmSample43 equ $05EEB0

        incbin "generated/data/05eeb0.bin"
        ifne *-$5F5D8
        fail "ROM end moved"
        endif
