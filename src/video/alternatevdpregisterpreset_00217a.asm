; $00217A..$00219F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$217A
        fail "ROM start moved"
        endif

AlternateVdpRegisterPreset equ $00217A

        incbin "generated/data/00217a.bin"
        ifne *-$21A0
        fail "ROM end moved"
        endif
