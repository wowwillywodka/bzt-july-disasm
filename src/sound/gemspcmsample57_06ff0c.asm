; $06FF0C..$070D64 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6FF0C
        fail "ROM start moved"
        endif

GemsPcmSample57 equ $06FF0C

        incbin "generated/data/06ff0c.bin"
        ifne *-$70D65
        fail "ROM end moved"
        endif
