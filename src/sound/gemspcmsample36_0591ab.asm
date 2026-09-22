; $0591AB..$059D1D | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$591AB
        fail "ROM start moved"
        endif

GemsPcmSample36 equ $0591AB

        incbin "generated/data/0591ab.bin"
        ifne *-$59D1E
        fail "ROM end moved"
        endif
