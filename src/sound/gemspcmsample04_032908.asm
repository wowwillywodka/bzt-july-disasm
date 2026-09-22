; $032908..$033F3D | pcm-u8
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$32908
        fail "ROM start moved"
        endif

GemsPcmSample04 equ $032908

        incbin "generated/data/032908.bin"
        ifne *-$33F3E
        fail "ROM end moved"
        endif
