; $05137A..$05219F | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$5137A
        fail "ROM start moved"
        endif

GemsPcmSample27 equ $05137A

        incbin "generated/data/05137a.bin"
        ifne *-$521A0
        fail "ROM end moved"
        endif
