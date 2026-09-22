; $07AC27..$07AC27 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$7AC27
        fail "ROM start moved"
        endif

SoundEventAlignment equ $07AC27

        incbin "generated/data/07ac27.bin"
        ifne *-$7AC28
        fail "ROM end moved"
        endif
