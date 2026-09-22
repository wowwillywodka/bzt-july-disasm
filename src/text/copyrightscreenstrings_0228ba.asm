; $0228BA..$02297F | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$228BA
        fail "ROM start moved"
        endif

CopyrightScreenStrings equ $0228BA
Data_0228DB equ $0228DB
Data_0228FE equ $0228FE
Data_02291A equ $02291A
Data_02293F equ $02293F
Data_02295B equ $02295B

        incbin "generated/data/0228ba.bin"
        ifne *-$22980
        fail "ROM end moved"
        endif
