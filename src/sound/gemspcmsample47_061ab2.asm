; $061AB2..$062880 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$61AB2
        fail "ROM start moved"
        endif

GemsPcmSample47 equ $061AB2

        incbin "generated/data/061ab2.bin"
        ifne *-$62881
        fail "ROM end moved"
        endif
