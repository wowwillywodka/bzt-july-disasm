; $008A4E..$008B4F | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8A4E
        fail "ROM start moved"
        endif

CameraAngleOffsets equ $008A4E

        incbin "generated/data/008a4e.bin"
        ifne *-$8B50
        fail "ROM end moved"
        endif
