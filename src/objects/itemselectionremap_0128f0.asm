; $0128F0..$012903 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$128F0
        fail "ROM start moved"
        endif

ItemSelectionRemap equ $0128F0

        incbin "generated/data/0128f0.bin"
        ifne *-$12904
        fail "ROM end moved"
        endif
