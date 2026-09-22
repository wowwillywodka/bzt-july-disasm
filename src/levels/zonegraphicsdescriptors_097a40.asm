; $097A40..$097B1F | pointers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$97A40
        fail "ROM start moved"
        endif

ZoneGraphicsDescriptors equ $097A40

        incbin "generated/data/097a40.bin"
        ifne *-$97B20
        fail "ROM end moved"
        endif
