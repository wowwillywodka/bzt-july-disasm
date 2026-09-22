; $122670..$12270F | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$122670
        fail "ROM start moved"
        endif

Episode4BackgroundProfile1 equ $122670

        incbin "generated/data/122670.bin"
        ifne *-$122710
        fail "ROM end moved"
        endif
