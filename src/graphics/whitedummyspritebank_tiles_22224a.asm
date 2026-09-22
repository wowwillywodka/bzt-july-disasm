; $22224A..$23E849 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$22224A
        fail "ROM start moved"
        endif

WhiteDummySpriteBank_Tiles equ $22224A

        incbin "generated/data/22224a.bin"
        ifne *-$23E84A
        fail "ROM end moved"
        endif
