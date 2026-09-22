; $088358..$08838B | train-routes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$88358
        fail "ROM start moved"
        endif

Episode1TrainRoutes equ $088358

        incbin "generated/data/088358.bin"
        ifne *-$8838C
        fail "ROM end moved"
        endif
