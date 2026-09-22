; $0773A5..$078463 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$773A5
        fail "ROM start moved"
        endif

GemsPcmSample63 equ $0773A5

        incbin "generated/data/0773a5.bin"
        ifne *-$78464
        fail "ROM end moved"
        endif
