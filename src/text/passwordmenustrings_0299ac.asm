; $0299AC..$029A5F | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$299AC
        fail "ROM start moved"
        endif

PasswordMenuStrings equ $0299AC
Data_0299BF equ $0299BF
Data_0299CF equ $0299CF
Data_0299DF equ $0299DF
Data_0299EF equ $0299EF
Data_0299FF equ $0299FF
Data_029A0F equ $029A0F
Data_029A1F equ $029A1F
Data_029A2F equ $029A2F
Data_029A3F equ $029A3F
Data_029A4F equ $029A4F

        incbin "generated/data/0299ac.bin"
        ifne *-$29A60
        fail "ROM end moved"
        endif
