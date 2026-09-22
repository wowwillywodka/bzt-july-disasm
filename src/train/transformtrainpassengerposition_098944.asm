; $098944..$098A9D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0/D1=source-relative fixed-point XY; D2=old orientation; D3/D4=player fraction bytes; D5=new orientation; A0=destination record. Out D3/D4=global destination XY, angle/vector updated if orientation changes.
        ifne *-$98944
        fail "ROM start moved"
        endif

TransformTrainPassengerPosition:
; D0/D1=source-relative fixed-point XY; D2=old orientation; D3/D4=player fraction bytes; D5=new orientation; A0=destination record. Out D3/D4=global destination XY, angle/vector updated if orientation changes.
        cmpi.b       #$1, d2                                       ; $098944
        beq.w        loc_098966                                    ; $098948
        cmpi.b       #$2, d2                                       ; $09894C
        beq.w        loc_098988                                    ; $098950
        cmpi.b       #$3, d2                                       ; $098954
        beq.w        loc_0989AA                                    ; $098958
        cmpi.b       #$4, d2                                       ; $09895C
        beq.w        loc_0989CC                                    ; $098960
        rts                                                        ; $098964

loc_098966:
        cmpi.b       #$1, d5                                       ; $098966
        beq.w        loc_0989EE                                    ; $09896A
        cmpi.b       #$2, d5                                       ; $09896E
        beq.w        loc_098A00                                    ; $098972
        cmpi.b       #$3, d5                                       ; $098976
        beq.w        loc_098A2A                                    ; $09897A
        cmpi.b       #$4, d5                                       ; $09897E
        beq.w        loc_098A64                                    ; $098982
        rts                                                        ; $098986

loc_098988:
        cmpi.b       #$1, d5                                       ; $098988
        beq.w        loc_098A00                                    ; $09898C
        cmpi.b       #$2, d5                                       ; $098990
        beq.w        loc_0989EE                                    ; $098994
        cmpi.b       #$3, d5                                       ; $098998
        beq.w        loc_098A64                                    ; $09899C
        cmpi.b       #$4, d5                                       ; $0989A0
        beq.w        loc_098A2A                                    ; $0989A4
        rts                                                        ; $0989A8

loc_0989AA:
        cmpi.b       #$1, d5                                       ; $0989AA
        beq.w        loc_098A16                                    ; $0989AE
        cmpi.b       #$2, d5                                       ; $0989B2
        beq.w        loc_098A54                                    ; $0989B6
        cmpi.b       #$3, d5                                       ; $0989BA
        beq.w        loc_0989EE                                    ; $0989BE
        cmpi.b       #$4, d5                                       ; $0989C2
        beq.w        loc_098A3E                                    ; $0989C6
        rts                                                        ; $0989CA

loc_0989CC:
        cmpi.b       #$1, d5                                       ; $0989CC
        beq.w        loc_098A54                                    ; $0989D0
        cmpi.b       #$2, d5                                       ; $0989D4
        beq.w        loc_098A16                                    ; $0989D8
        cmpi.b       #$3, d5                                       ; $0989DC
        beq.w        loc_098A3E                                    ; $0989E0
        cmpi.b       #$4, d5                                       ; $0989E4
        beq.w        loc_0989EE                                    ; $0989E8
        rts                                                        ; $0989EC

loc_0989EE:
; Same orientation preserves both full relative coordinates. Changed orientations may discard one integer component and mirror around $2000; not a general rigid-body rotation.
        move.b       TrainOriginX(a0), d3                          ; $0989EE
        move.b       TrainOriginY(a0), d4                          ; $0989F2
        lsl.w        #$8, d3                                       ; $0989F6
        lsl.w        #$8, d4                                       ; $0989F8
        add.w        d0, d3                                        ; $0989FA
        add.w        d1, d4                                        ; $0989FC
        rts                                                        ; $0989FE

loc_098A00:
        move.w       #$2000, d3                                    ; $098A00
        sub.w        d0, d3                                        ; $098A04
        andi.w       #$ff, d4                                      ; $098A06
        neg.b        d4                                            ; $098A0A
        addi.w       #$100, -$71ee(a6)                             ; $098A0C
        bra.w        loc_098A70                                    ; $098A12

loc_098A16:
        move.w       #$2000, d3                                    ; $098A16
        sub.w        d1, d3                                        ; $098A1A
        andi.w       #$ff, d4                                      ; $098A1C
        addi.w       #$80, -$71ee(a6)                              ; $098A20
        bra.w        loc_098A70                                    ; $098A26

loc_098A2A:
        andi.w       #$ff, d3                                      ; $098A2A
        move.w       #$2000, d4                                    ; $098A2E
        sub.w        d0, d4                                        ; $098A32
        addi.w       #$80, -$71ee(a6)                              ; $098A34
        bra.w        loc_098A70                                    ; $098A3A

loc_098A3E:
        andi.w       #$ff, d3                                      ; $098A3E
        neg.b        d3                                            ; $098A42
        move.w       #$2000, d4                                    ; $098A44
        sub.w        d1, d4                                        ; $098A48
        addi.w       #$100, -$71ee(a6)                             ; $098A4A
        bra.w        loc_098A70                                    ; $098A50

loc_098A54:
        move.w       d1, d3                                        ; $098A54
        andi.w       #$ff, d4                                      ; $098A56
        subi.w       #$80, -$71ee(a6)                              ; $098A5A
        bra.w        loc_098A70                                    ; $098A60

loc_098A64:
        andi.w       #$ff, d3                                      ; $098A64
        move.w       d0, d4                                        ; $098A68
        subi.w       #$80, -$71ee(a6)                              ; $098A6A

loc_098A70:
        move.b       TrainOriginX(a0), d0                          ; $098A70
        move.b       TrainOriginY(a0), d1                          ; $098A74
        lsl.w        #$8, d0                                       ; $098A78
        lsl.w        #$8, d1                                       ; $098A7A
        add.w        d0, d3                                        ; $098A7C
        add.w        d1, d4                                        ; $098A7E
        andi.w       #$1ff, -$71ee(a6)                             ; $098A80
        lea.l        AngleVectorPairs.w, a1                        ; $098A86
        move.w       -$71ee(a6), d0                                ; $098A8A
        lsl.w        #$2, d0                                       ; $098A8E
        move.w       (a1, d0.w), -$71f2(a6)                        ; $098A90
        move.w       $2(a1, d0.w), -$71f0(a6)                      ; $098A96
        rts                                                        ; $098A9C
        ifne *-$98A9E
        fail "ROM end moved"
        endif
