; $08D426..$08D49F | actor-markers
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$8D426
        fail "ROM start moved"
        endif

Episode2ActorMarkers equ $08D426

        incbin "generated/data/08d426.bin"
        ifne *-$8D4A0
        fail "ROM end moved"
        endif
