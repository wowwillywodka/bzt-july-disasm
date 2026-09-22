; $054CD4..$055192 | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$54CD4
        fail "ROM start moved"
        endif

GemsPcmSample31 equ $054CD4

        incbin "generated/data/054cd4.bin"
        ifne *-$55193
        fail "ROM end moved"
        endif
