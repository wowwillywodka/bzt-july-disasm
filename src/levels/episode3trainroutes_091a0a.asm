; $091A0A..$091A3D | train-routes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$91A0A
        fail "ROM start moved"
        endif

Episode3TrainRoutes equ $091A0A

        incbin "generated/data/091a0a.bin"
        ifne *-$91A3E
        fail "ROM end moved"
        endif
