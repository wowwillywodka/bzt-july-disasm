; $013680..$0136EF | words
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$13680
        fail "ROM start moved"
        endif

WeaponAnimationSpriteMappings equ $013680
Data_013688 equ $013688
Data_013690 equ $013690
Data_013698 equ $013698
Data_0136A0 equ $0136A0
Data_0136A8 equ $0136A8
Data_0136B0 equ $0136B0
Data_0136C0 equ $0136C0
Data_0136C8 equ $0136C8
Data_0136D0 equ $0136D0
Data_0136D8 equ $0136D8
Data_0136E0 equ $0136E0
Data_0136E8 equ $0136E8

        incbin "generated/data/013680.bin"
        ifne *-$136F0
        fail "ROM end moved"
        endif
