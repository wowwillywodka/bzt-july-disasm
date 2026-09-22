; $0225EC..$022627 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$225EC
        fail "ROM start moved"
        endif

WaitingForPartnerMenuText equ $0225EC
Data_022611 equ $022611

        incbin "generated/data/0225ec.bin"
        ifne *-$22628
        fail "ROM end moved"
        endif
