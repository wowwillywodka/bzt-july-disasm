; $0486EE..$049531 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$486EE
        fail "ROM start moved"
        endif

GemsPcmSample17 equ $0486EE

        incbin "generated/data/0486ee.bin"
        ifne *-$49532
        fail "ROM end moved"
        endif
