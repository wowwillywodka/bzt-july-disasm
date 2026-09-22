; $0039C5..$0039DA | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$39C5
        fail "ROM start moved"
        endif

StatisticsPasswordLabel equ $0039C5

        incbin "generated/data/0039c5.bin"
        ifne *-$39DB
        fail "ROM end moved"
        endif
