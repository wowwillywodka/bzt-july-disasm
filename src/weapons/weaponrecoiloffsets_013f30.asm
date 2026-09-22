; $013F30..$013F35 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$13F30
        fail "ROM start moved"
        endif

WeaponRecoilOffsets equ $013F30

        incbin "generated/data/013f30.bin"
        ifne *-$13F36
        fail "ROM end moved"
        endif
