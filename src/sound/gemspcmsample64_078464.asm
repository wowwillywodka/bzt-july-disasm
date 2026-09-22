; $078464..$07A718 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$78464
        fail "ROM start moved"
        endif

GemsPcmSample64 equ $078464

        incbin "generated/data/078464.bin"
        ifne *-$7A719
        fail "ROM end moved"
        endif
