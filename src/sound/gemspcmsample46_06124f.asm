; $06124F..$061AB1 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6124F
        fail "ROM start moved"
        endif

GemsPcmSample46 equ $06124F

        incbin "generated/data/06124f.bin"
        ifne *-$61AB2
        fail "ROM end moved"
        endif
