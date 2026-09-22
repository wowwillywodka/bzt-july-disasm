; $04DD22..$04EB6F | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4DD22
        fail "ROM start moved"
        endif

GemsPcmSample23 equ $04DD22

        incbin "generated/data/04dd22.bin"
        ifne *-$4EB70
        fail "ROM end moved"
        endif
