; $0293AE..$0293DD | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$293AE
        fail "ROM start moved"
        endif

HudFontRemap equ $0293AE

        incbin "generated/data/0293ae.bin"
        ifne *-$293DE
        fail "ROM end moved"
        endif
