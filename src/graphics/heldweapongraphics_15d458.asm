; $15D458..$15F5B7 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$15D458
        fail "ROM start moved"
        endif

HeldWeaponGraphics equ $15D458
Data_15D6D8 equ $15D6D8
Data_15DB78 equ $15DB78
Data_15DE18 equ $15DE18
Data_15E0B8 equ $15E0B8
Data_15E358 equ $15E358
Data_15E5F8 equ $15E5F8
Data_15E898 equ $15E898
Data_15EB38 equ $15EB38
Data_15EDD8 equ $15EDD8
Data_15F078 equ $15F078
Data_15F318 equ $15F318

        incbin "generated/data/15d458.bin"
        ifne *-$15F5B8
        fail "ROM end moved"
        endif
