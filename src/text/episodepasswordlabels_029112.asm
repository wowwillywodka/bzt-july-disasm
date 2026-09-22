; $029112..$029143 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29112
        fail "ROM start moved"
        endif

EpisodePasswordLabels equ $029112
Data_02912B equ $02912B

        incbin "generated/data/029112.bin"
        ifne *-$29144
        fail "ROM end moved"
        endif
