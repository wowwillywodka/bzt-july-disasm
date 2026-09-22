; $060416..$06124E | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$60416
        fail "ROM start moved"
        endif

GemsPcmSample45 equ $060416

        incbin "generated/data/060416.bin"
        ifne *-$6124F
        fail "ROM end moved"
        endif
