; $010340..$010FE9 | bytes
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$10340
        fail "ROM start moved"
        endif

SpriteScaleSampleRows equ $010340
Data_010341 equ $010341
Data_010342 equ $010342
Data_010344 equ $010344
Data_010347 equ $010347
Data_01034B equ $01034B
Data_010350 equ $010350
Data_010356 equ $010356
Data_01035D equ $01035D
Data_010365 equ $010365
Data_01036E equ $01036E
Data_010378 equ $010378
Data_010383 equ $010383
Data_01038F equ $01038F
Data_01039C equ $01039C
Data_0103AA equ $0103AA
Data_0103B9 equ $0103B9
Data_0103C9 equ $0103C9
Data_0103DA equ $0103DA
Data_0103EC equ $0103EC
Data_0103FF equ $0103FF
Data_010413 equ $010413
Data_010428 equ $010428
Data_01043E equ $01043E
Data_010455 equ $010455
Data_01046D equ $01046D
Data_010486 equ $010486
Data_0104A0 equ $0104A0
Data_0104BB equ $0104BB
Data_0104D7 equ $0104D7
Data_0104F4 equ $0104F4
Data_010512 equ $010512
Data_010531 equ $010531
Data_010551 equ $010551
Data_010572 equ $010572
Data_010594 equ $010594
Data_0105B7 equ $0105B7
Data_0105DB equ $0105DB
Data_010600 equ $010600
Data_010626 equ $010626
Data_01064D equ $01064D
Data_010675 equ $010675
Data_01069E equ $01069E
Data_0106C8 equ $0106C8
Data_0106F3 equ $0106F3
Data_01071F equ $01071F
Data_01074C equ $01074C
Data_01077A equ $01077A
Data_0107A9 equ $0107A9
Data_0107D9 equ $0107D9
Data_01080A equ $01080A
Data_01083C equ $01083C
Data_01086F equ $01086F
Data_0108A3 equ $0108A3
Data_0108D8 equ $0108D8
Data_01090E equ $01090E
Data_010945 equ $010945
Data_01097D equ $01097D
Data_0109B6 equ $0109B6
Data_0109F0 equ $0109F0
Data_010A2B equ $010A2B
Data_010A67 equ $010A67
Data_010AA4 equ $010AA4
Data_010AE2 equ $010AE2
Data_010B21 equ $010B21
Data_010B61 equ $010B61
Data_010BA2 equ $010BA2
Data_010BE4 equ $010BE4
Data_010C27 equ $010C27
Data_010C6B equ $010C6B
Data_010CB0 equ $010CB0
Data_010CF6 equ $010CF6
Data_010D3D equ $010D3D
Data_010D85 equ $010D85
Data_010DCE equ $010DCE
Data_010E18 equ $010E18
Data_010E63 equ $010E63
Data_010EAF equ $010EAF
Data_010EFC equ $010EFC
Data_010F4A equ $010F4A
Data_010F99 equ $010F99

        incbin "generated/data/010340.bin"
        ifne *-$10FEA
        fail "ROM end moved"
        endif
