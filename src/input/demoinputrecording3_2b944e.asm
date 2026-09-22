; $2B944E..$2B951D | demo-input
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B944E
        fail "ROM start moved"
        endif

DemoInputRecording3 equ $2B944E
DemoInputRecording3_ControllerBytes equ $2B9452
DemoInputRecording3_UnconsumedTail equ $2B951A

        incbin "generated/data/2b944e.bin"
        ifne *-$2B951E
        fail "ROM end moved"
        endif
