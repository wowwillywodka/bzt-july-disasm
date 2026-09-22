; $2B5FAA..$2B62AD | sprite-descriptors
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2B5FAA
        fail "ROM start moved"
        endif

UnassignedLegacySpriteBank equ $2B5FAA
UnassignedLegacySpriteBank_OffsetBase equ $2B5FAC
UnassignedLegacySpriteBank_Animation00 equ $2B5FB4
UnassignedLegacySpriteBank_Animation00_View00 equ $2B5FC2
UnassignedLegacySpriteBank_Animation00_View00_Frame00 equ $2B5FC4
UnassignedLegacySpriteBank_Animation00_View01 equ $2B5FEA
UnassignedLegacySpriteBank_Animation00_View01_Frame00 equ $2B5FEC
UnassignedLegacySpriteBank_Animation00_View02 equ $2B6012
UnassignedLegacySpriteBank_Animation00_View02_Frame00 equ $2B6014
UnassignedLegacySpriteBank_Animation00_View03 equ $2B603A
UnassignedLegacySpriteBank_Animation00_View03_Frame00 equ $2B603C
UnassignedLegacySpriteBank_Animation00_View04 equ $2B6062
UnassignedLegacySpriteBank_Animation00_View04_Frame00 equ $2B6064
UnassignedLegacySpriteBank_Animation00_View05 equ $2B608A
UnassignedLegacySpriteBank_Animation00_View05_Frame00 equ $2B608C
UnassignedLegacySpriteBank_Animation01 equ $2B60B2
UnassignedLegacySpriteBank_Animation01_View00 equ $2B60C0
UnassignedLegacySpriteBank_Animation01_View00_Frame00 equ $2B60C2
UnassignedLegacySpriteBank_Animation01_View01 equ $2B60E8
UnassignedLegacySpriteBank_Animation01_View01_Frame00 equ $2B60EA
UnassignedLegacySpriteBank_Animation01_View02 equ $2B6110
UnassignedLegacySpriteBank_Animation01_View02_Frame00 equ $2B6112
UnassignedLegacySpriteBank_Animation01_View03 equ $2B6138
UnassignedLegacySpriteBank_Animation01_View03_Frame00 equ $2B613A
UnassignedLegacySpriteBank_Animation01_View04 equ $2B6160
UnassignedLegacySpriteBank_Animation01_View04_Frame00 equ $2B6162
UnassignedLegacySpriteBank_Animation01_View05 equ $2B6188
UnassignedLegacySpriteBank_Animation01_View05_Frame00 equ $2B618A
UnassignedLegacySpriteBank_Animation02 equ $2B61B0
UnassignedLegacySpriteBank_Animation02_View00 equ $2B61BE
UnassignedLegacySpriteBank_Animation02_View00_Frame00 equ $2B61C0
UnassignedLegacySpriteBank_Animation02_View01 equ $2B61E6
UnassignedLegacySpriteBank_Animation02_View01_Frame00 equ $2B61E8
UnassignedLegacySpriteBank_Animation02_View02 equ $2B620E
UnassignedLegacySpriteBank_Animation02_View02_Frame00 equ $2B6210
UnassignedLegacySpriteBank_Animation02_View03 equ $2B6236
UnassignedLegacySpriteBank_Animation02_View03_Frame00 equ $2B6238
UnassignedLegacySpriteBank_Animation02_View04 equ $2B625E
UnassignedLegacySpriteBank_Animation02_View04_Frame00 equ $2B6260
UnassignedLegacySpriteBank_Animation02_View05 equ $2B6286
UnassignedLegacySpriteBank_Animation02_View05_Frame00 equ $2B6288

        incbin "generated/data/2b5faa.bin"
        ifne *-$2B62AE
        fail "ROM end moved"
        endif
