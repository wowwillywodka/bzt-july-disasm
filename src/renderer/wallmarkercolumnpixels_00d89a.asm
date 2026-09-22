; $00D89A..$00D8E9 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$D89A
        fail "ROM start moved"
        endif

WallMarkerColumnPixels equ $00D89A

        incbin "generated/data/00d89a.bin"
        ifne *-$D8EA
        fail "ROM end moved"
        endif
