; $08187F..$081ACF | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8187F
        fail "ROM start moved"
        endif

BriefingBlankScrollTail equ $08187F
BriefingScrollEnd equ $081ACF

        incbin "generated/data/08187f.bin"
        ifne *-$81AD0
        fail "ROM end moved"
        endif
