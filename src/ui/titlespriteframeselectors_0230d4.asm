; $0230D4..$023213 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$230D4
        fail "ROM start moved"
        endif

TitleSpriteFrameSelectors equ $0230D4

        incbin "generated/data/0230d4.bin"
        ifne *-$23214
        fail "ROM end moved"
        endif
