; $06B55A..$06C39D | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$6B55A
        fail "ROM start moved"
        endif

GemsPcmSample53 equ $06B55A

        incbin "generated/data/06b55a.bin"
        ifne *-$6C39E
        fail "ROM end moved"
        endif
