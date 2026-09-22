; $122710..$1227AF | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$122710
        fail "ROM start moved"
        endif

Episode4BackgroundProfile2 equ $122710

        incbin "generated/data/122710.bin"
        ifne *-$1227B0
        fail "ROM end moved"
        endif
