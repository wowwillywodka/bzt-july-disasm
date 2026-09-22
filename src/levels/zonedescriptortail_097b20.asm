; $097B20..$097B9F | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97B20
        fail "ROM start moved"
        endif

ZoneDescriptorTail equ $097B20

        incbin "generated/data/097b20.bin"
        ifne *-$97BA0
        fail "ROM end moved"
        endif
