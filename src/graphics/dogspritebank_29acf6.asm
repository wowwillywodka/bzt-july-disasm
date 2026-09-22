; $29ACF6..$29B8DF | sprite-descriptors
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$29ACF6
        fail "ROM start moved"
        endif

DogSpriteBank equ $29ACF6
DogSpriteBank_OffsetBase equ $29ACF8
DogSpriteBank_Animation00 equ $29AD08
DogSpriteBank_Animation00_View00 equ $29AD16
DogSpriteBank_Animation00_View00_Frame00 equ $29AD18
DogSpriteBank_Animation00_View00_Frame01 equ $29AD4E
DogSpriteBank_Animation00_View00_Frame02 equ $29AD84
DogSpriteBank_Animation00_View00_Frame03 equ $29ADBA
DogSpriteBank_Animation00_View00_Frame04 equ $29ADF0
DogSpriteBank_Animation00_View00_Frame05 equ $29AE26
DogSpriteBank_Animation00_View01 equ $29AE5C
DogSpriteBank_Animation00_View01_Frame00 equ $29AE5E
DogSpriteBank_Animation00_View01_Frame01 equ $29AE94
DogSpriteBank_Animation00_View01_Frame02 equ $29AECA
DogSpriteBank_Animation00_View01_Frame03 equ $29AF00
DogSpriteBank_Animation00_View01_Frame04 equ $29AF36
DogSpriteBank_Animation00_View01_Frame05 equ $29AF6C
DogSpriteBank_Animation00_View02 equ $29AFA2
DogSpriteBank_Animation00_View02_Frame00 equ $29AFA4
DogSpriteBank_Animation00_View02_Frame01 equ $29AFDA
DogSpriteBank_Animation00_View02_Frame02 equ $29B010
DogSpriteBank_Animation00_View02_Frame03 equ $29B046
DogSpriteBank_Animation00_View02_Frame04 equ $29B07C
DogSpriteBank_Animation00_View02_Frame05 equ $29B0B2
DogSpriteBank_Animation00_View03 equ $29B0E8
DogSpriteBank_Animation00_View03_Frame00 equ $29B0EA
DogSpriteBank_Animation00_View03_Frame01 equ $29B120
DogSpriteBank_Animation00_View03_Frame02 equ $29B156
DogSpriteBank_Animation00_View03_Frame03 equ $29B18C
DogSpriteBank_Animation00_View03_Frame04 equ $29B1C2
DogSpriteBank_Animation00_View03_Frame05 equ $29B1F8
DogSpriteBank_Animation00_View04 equ $29B22E
DogSpriteBank_Animation00_View04_Frame00 equ $29B230
DogSpriteBank_Animation00_View04_Frame01 equ $29B266
DogSpriteBank_Animation00_View04_Frame02 equ $29B29C
DogSpriteBank_Animation00_View04_Frame03 equ $29B2D2
DogSpriteBank_Animation00_View04_Frame04 equ $29B308
DogSpriteBank_Animation00_View04_Frame05 equ $29B33E
DogSpriteBank_Animation00_View05 equ $29B374
DogSpriteBank_Animation00_View05_Frame00 equ $29B376
DogSpriteBank_Animation00_View05_Frame01 equ $29B3AC
DogSpriteBank_Animation00_View05_Frame02 equ $29B3E2
DogSpriteBank_Animation00_View05_Frame03 equ $29B418
DogSpriteBank_Animation00_View05_Frame04 equ $29B44E
DogSpriteBank_Animation00_View05_Frame05 equ $29B484
DogSpriteBank_Animation01 equ $29B4BA
DogSpriteBank_Animation01_View00 equ $29B4BE
DogSpriteBank_Animation01_View00_Frame00 equ $29B4C0
DogSpriteBank_Animation01_View00_Frame01 equ $29B4F6
DogSpriteBank_Animation02 equ $29B52C
DogSpriteBank_Animation02_View00 equ $29B530
DogSpriteBank_Animation02_View00_Frame00 equ $29B532
DogSpriteBank_Animation02_View00_Frame01 equ $29B568
DogSpriteBank_Animation03 equ $29B59E
DogSpriteBank_Animation03_View00 equ $29B5A2
DogSpriteBank_Animation03_View00_Frame00 equ $29B5A4
DogSpriteBank_Animation03_View00_Frame01 equ $29B5DA
DogSpriteBank_Animation03_View00_Frame02 equ $29B610
DogSpriteBank_Animation03_View00_Frame03 equ $29B646
DogSpriteBank_Animation04 equ $29B67C
DogSpriteBank_Animation04_View00 equ $29B680
DogSpriteBank_Animation04_View00_Frame00 equ $29B682
DogSpriteBank_Animation04_View00_Frame01 equ $29B6B8
DogSpriteBank_Animation04_View00_Frame02 equ $29B6EE
DogSpriteBank_Animation04_View00_Frame03 equ $29B724
DogSpriteBank_Animation05 equ $29B75A
DogSpriteBank_Animation05_View00 equ $29B75E
DogSpriteBank_Animation05_View00_Frame00 equ $29B760
DogSpriteBank_Animation05_View00_Frame01 equ $29B796
DogSpriteBank_Animation05_View00_Frame02 equ $29B7CC
DogSpriteBank_Animation05_View00_Frame03 equ $29B802
DogSpriteBank_Animation05_View00_Frame04 equ $29B838
DogSpriteBank_Animation06 equ $29B86E
DogSpriteBank_Animation06_View00 equ $29B872
DogSpriteBank_Animation06_View00_Frame00 equ $29B874
DogSpriteBank_Animation06_View00_Frame01 equ $29B8AA

        incbin "generated/data/29acf6.bin"
        ifne *-$29B8E0
        fail "ROM end moved"
        endif
