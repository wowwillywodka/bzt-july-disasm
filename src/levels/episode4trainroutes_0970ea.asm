; $0970EA..$09711D | train-routes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$970EA
        fail "ROM start moved"
        endif

Episode4TrainRoutes equ $0970EA

        incbin "generated/data/0970ea.bin"
        ifne *-$9711E
        fail "ROM end moved"
        endif
