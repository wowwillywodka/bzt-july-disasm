; $07AA98..$07AC26 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7AA98
        fail "ROM start moved"
        endif

SoundEventRecords equ $07AA98

        incbin "generated/data/07aa98.bin"
        ifne *-$7AC27
        fail "ROM end moved"
        endif
