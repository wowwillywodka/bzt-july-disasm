; $1227B0..$12284F | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1227B0
        fail "ROM start moved"
        endif

Episode4BackgroundProfile0 equ $1227B0

        incbin "generated/data/1227b0.bin"
        ifne *-$122850
        fail "ROM end moved"
        endif
