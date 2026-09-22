; $08D3F2..$08D425 | train-routes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8D3F2
        fail "ROM start moved"
        endif

Episode2TrainRoutes equ $08D3F2

        incbin "generated/data/08d3f2.bin"
        ifne *-$8D426
        fail "ROM end moved"
        endif
