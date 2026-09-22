; $2B92AE..$2B937D | demo-input
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B92AE
        fail "ROM start moved"
        endif

DemoInputRecording1 equ $2B92AE
DemoInputRecording1_ControllerBytes equ $2B92B2
DemoInputRecording1_UnconsumedTail equ $2B937A

        incbin "generated/data/2b92ae.bin"
        ifne *-$2B937E
        fail "ROM end moved"
        endif
