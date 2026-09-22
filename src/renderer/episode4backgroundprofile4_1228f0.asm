; $1228F0..$12298F | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$1228F0
        fail "ROM start moved"
        endif

Episode4BackgroundProfile4 equ $1228F0

        incbin "generated/data/1228f0.bin"
        ifne *-$122990
        fail "ROM end moved"
        endif
