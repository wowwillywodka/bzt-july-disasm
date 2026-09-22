; $056E14..$057C5D | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$56E14
        fail "ROM start moved"
        endif

GemsPcmSample34 equ $056E14

        incbin "generated/data/056e14.bin"
        ifne *-$57C5E
        fail "ROM end moved"
        endif
