; $0C8804..$0C88A3 | background-profile
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$C8804
        fail "ROM start moved"
        endif

Episode2BackgroundProfile1 equ $0C8804

        incbin "generated/data/0c8804.bin"
        ifne *-$C88A4
        fail "ROM end moved"
        endif
