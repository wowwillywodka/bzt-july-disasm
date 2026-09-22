; $02EBE0..$02FA23 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2EBE0
        fail "ROM start moved"
        endif

GemsPcmSample00 equ $02EBE0

        incbin "generated/data/02ebe0.bin"
        ifne *-$2FA24
        fail "ROM end moved"
        endif
