; $02FA24..$03085C | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2FA24
        fail "ROM start moved"
        endif

GemsPcmSample01 equ $02FA24

        incbin "generated/data/02fa24.bin"
        ifne *-$3085D
        fail "ROM end moved"
        endif
