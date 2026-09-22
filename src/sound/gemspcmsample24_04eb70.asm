; $04EB70..$04F9BD | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4EB70
        fail "ROM start moved"
        endif

GemsPcmSample24 equ $04EB70

        incbin "generated/data/04eb70.bin"
        ifne *-$4F9BE
        fail "ROM end moved"
        endif
