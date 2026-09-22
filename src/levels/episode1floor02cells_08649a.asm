; $08649A..$086B3F | map-grid:46
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8649A
        fail "ROM start moved"
        endif

Episode1Floor02Cells equ $08649A

        incbin "generated/data/08649a.bin"
        ifne *-$86B40
        fail "ROM end moved"
        endif
