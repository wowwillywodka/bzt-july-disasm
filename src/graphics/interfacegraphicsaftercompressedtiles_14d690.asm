; $14D690..$15D457 | binary
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$14D690
        fail "ROM start moved"
        endif

InterfaceGraphicsAfterCompressedTiles equ $14D690
Data_14EB70 equ $14EB70
Data_14ECF0 equ $14ECF0
Data_1501F0 equ $1501F0
Data_150370 equ $150370
Data_151870 equ $151870
Data_1519F0 equ $1519F0
Data_152EF0 equ $152EF0
Data_153070 equ $153070
Data_154550 equ $154550
Data_1546D0 equ $1546D0
Data_155B90 equ $155B90
Data_155D10 equ $155D10
Data_1571D0 equ $1571D0
Data_157350 equ $157350
Data_158830 equ $158830
Data_1589B0 equ $1589B0
Data_159E90 equ $159E90
Data_15A010 equ $15A010
Data_15B4D0 equ $15B4D0
Data_15CA58 equ $15CA58
Data_15CA5A equ $15CA5A
Data_15CA68 equ $15CA68
Data_15CA6A equ $15CA6A
Data_15CA78 equ $15CA78
Data_15CA7A equ $15CA7A
Data_15CA88 equ $15CA88
Data_15CA8A equ $15CA8A
Data_15CCB8 equ $15CCB8
Data_15CCD8 equ $15CCD8

        incbin "generated/data/14d690.bin"
        ifne *-$15D458
        fail "ROM end moved"
        endif
