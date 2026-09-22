; $028730..$02873F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$28730
        fail "ROM start moved"
        endif

RetainedScreenEffectColumnPixels equ $028730

        incbin "generated/data/028730.bin"
        ifne *-$28740
        fail "ROM end moved"
        endif
