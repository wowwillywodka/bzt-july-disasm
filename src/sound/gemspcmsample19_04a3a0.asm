; $04A3A0..$04B1E3 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$4A3A0
        fail "ROM start moved"
        endif

GemsPcmSample19 equ $04A3A0

        incbin "generated/data/04a3a0.bin"
        ifne *-$4B1E4
        fail "ROM end moved"
        endif
