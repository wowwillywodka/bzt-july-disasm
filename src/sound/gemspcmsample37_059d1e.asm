; $059D1E..$05AB6B | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$59D1E
        fail "ROM start moved"
        endif

GemsPcmSample37 equ $059D1E

        incbin "generated/data/059d1e.bin"
        ifne *-$5AB6C
        fail "ROM end moved"
        endif
