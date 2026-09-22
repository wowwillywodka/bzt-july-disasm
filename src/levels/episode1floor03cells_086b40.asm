; $086B40..$086F3B | map-grid:34
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$86B40
        fail "ROM start moved"
        endif

Episode1Floor03Cells equ $086B40

        incbin "generated/data/086b40.bin"
        ifne *-$86F3C
        fail "ROM end moved"
        endif
