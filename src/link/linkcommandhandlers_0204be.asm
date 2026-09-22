; $0204BE..$020529 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$204BE
        fail "ROM start moved"
        endif

LinkCommandHandlers equ $0204BE

        incbin "generated/data/0204be.bin"
        ifne *-$2052A
        fail "ROM end moved"
        endif
