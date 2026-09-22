; $122850..$1228EF | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$122850
        fail "ROM start moved"
        endif

Episode4BackgroundProfile3 equ $122850

        incbin "generated/data/122850.bin"
        ifne *-$1228F0
        fail "ROM end moved"
        endif
