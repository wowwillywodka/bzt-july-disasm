; $2B937E..$2B944D | demo-input
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B937E
        fail "ROM start moved"
        endif

DemoInputRecording2 equ $2B937E
DemoInputRecording2_ControllerBytes equ $2B9382
DemoInputRecording2_UnconsumedTail equ $2B944A

        incbin "generated/data/2b937e.bin"
        ifne *-$2B944E
        fail "ROM end moved"
        endif
