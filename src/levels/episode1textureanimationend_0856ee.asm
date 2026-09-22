; $0856EE..$0856EF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$856EE
        fail "ROM start moved"
        endif

Episode1TextureAnimationEnd equ $0856EE

        incbin "generated/data/0856ee.bin"
        ifne *-$856F0
        fail "ROM end moved"
        endif
