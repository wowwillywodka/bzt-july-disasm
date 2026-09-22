; $002154..$002179 | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2154
        fail "ROM start moved"
        endif

GameVdpRegisterPreset equ $002154

        incbin "generated/data/002154.bin"
        ifne *-$217A
        fail "ROM end moved"
        endif
