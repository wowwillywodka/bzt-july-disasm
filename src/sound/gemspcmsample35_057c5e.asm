; $057C5E..$0591AA | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$57C5E
        fail "ROM start moved"
        endif

GemsPcmSample35 equ $057C5E

        incbin "generated/data/057c5e.bin"
        ifne *-$591AB
        fail "ROM end moved"
        endif
