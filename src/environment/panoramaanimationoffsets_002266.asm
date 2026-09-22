; $002266..$0022A5 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2266
        fail "ROM start moved"
        endif

PanoramaAnimationOffsets equ $002266

        incbin "generated/data/002266.bin"
        ifne *-$22A6
        fail "ROM end moved"
        endif
