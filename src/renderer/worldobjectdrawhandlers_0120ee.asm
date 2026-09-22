; $0120EE..$012299 | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$120EE
        fail "ROM start moved"
        endif

WorldObjectDrawHandlers equ $0120EE

        incbin "generated/data/0120ee.bin"
        ifne *-$1229A
        fail "ROM end moved"
        endif
