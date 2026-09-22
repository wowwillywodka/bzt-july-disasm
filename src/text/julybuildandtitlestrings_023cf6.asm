; $023CF6..$023D13 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$23CF6
        fail "ROM start moved"
        endif

JulyBuildAndTitleStrings equ $023CF6
Data_023D05 equ $023D05
Data_023D0B equ $023D0B

        incbin "generated/data/023cf6.bin"
        ifne *-$23D14
        fail "ROM end moved"
        endif
