; $09854E..$098671 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Write eight solid $D9 cells along the selected train face, then re-extract window. This seals the side for the passenger ride; former OpenFace label was wrong.
        ifne *-$9854E
        fail "ROM start moved"
        endif

WriteTrainSealedCells:
; Write eight solid $D9 cells along the selected train face, then re-extract window. This seals the side for the passenger ride; former OpenFace label was wrong.
        cmpi.b       #$1, d0                                       ; $09854E
        beq.b        loc_09856C                                    ; $098552
        cmpi.b       #$2, d0                                       ; $098554
        beq.b        loc_0985A4                                    ; $098558
        cmpi.b       #$3, d0                                       ; $09855A
        beq.b        loc_0985DC                                    ; $09855E
        cmpi.b       #$4, d0                                       ; $098560
        beq.w        loc_098628                                    ; $098564
        bra.w        loc_098670                                    ; $098568

loc_09856C:
        adda.w       rCurrentFloorWidth(a6), a1                    ; $09856C
        adda.w       #$c, a1                                       ; $098570
        move.b       #$d9, (a1)+                                   ; $098574
        move.b       #$d9, (a1)+                                   ; $098578
        move.b       #$d9, (a1)+                                   ; $09857C
        move.b       #$d9, (a1)+                                   ; $098580
        move.b       #$d9, (a1)+                                   ; $098584
        move.b       #$d9, (a1)+                                   ; $098588
        move.b       #$d9, (a1)+                                   ; $09858C
        move.b       #$d9, (a1)                                    ; $098590
        move.w       rMapWindowOriginX(a6), d4                     ; $098594
        move.w       rMapWindowOriginY(a6), d5                     ; $098598
        jsr          ExtractVisibleMapWindow(pc)                   ; $09859C
        bra.w        loc_098670                                    ; $0985A0

loc_0985A4:
        suba.w       rCurrentFloorWidth(a6), a1                    ; $0985A4
        adda.w       #$c, a1                                       ; $0985A8
        move.b       #$d9, (a1)+                                   ; $0985AC
        move.b       #$d9, (a1)+                                   ; $0985B0
        move.b       #$d9, (a1)+                                   ; $0985B4
        move.b       #$d9, (a1)+                                   ; $0985B8
        move.b       #$d9, (a1)+                                   ; $0985BC
        move.b       #$d9, (a1)+                                   ; $0985C0
        move.b       #$d9, (a1)+                                   ; $0985C4
        move.b       #$d9, (a1)                                    ; $0985C8
        move.w       rMapWindowOriginX(a6), d4                     ; $0985CC
        move.w       rMapWindowOriginY(a6), d5                     ; $0985D0
        jsr          ExtractVisibleMapWindow(pc)                   ; $0985D4
        bra.w        loc_098670                                    ; $0985D8

loc_0985DC:
        move.w       rCurrentFloorWidth(a6), d0                    ; $0985DC
        move.w       d0, d1                                        ; $0985E0
        mulu.w       #$c, d0                                       ; $0985E2
        adda.w       d0, a1                                        ; $0985E6
        addq.w       #$1, a1                                       ; $0985E8
        move.b       #$d9, (a1)                                    ; $0985EA
        adda.w       d1, a1                                        ; $0985EE
        move.b       #$d9, (a1)                                    ; $0985F0
        adda.w       d1, a1                                        ; $0985F4
        move.b       #$d9, (a1)                                    ; $0985F6
        adda.w       d1, a1                                        ; $0985FA
        move.b       #$d9, (a1)                                    ; $0985FC
        adda.w       d1, a1                                        ; $098600
        move.b       #$d9, (a1)                                    ; $098602
        adda.w       d1, a1                                        ; $098606
        move.b       #$d9, (a1)                                    ; $098608
        adda.w       d1, a1                                        ; $09860C
        move.b       #$d9, (a1)                                    ; $09860E
        adda.w       d1, a1                                        ; $098612
        move.b       #$d9, (a1)                                    ; $098614
        move.w       rMapWindowOriginX(a6), d4                     ; $098618
        move.w       rMapWindowOriginY(a6), d5                     ; $09861C
        jsr          ExtractVisibleMapWindow(pc)                   ; $098620
        bra.w        loc_098670                                    ; $098624

loc_098628:
        move.w       rCurrentFloorWidth(a6), d0                    ; $098628
        move.w       d0, d1                                        ; $09862C
        mulu.w       #$c, d0                                       ; $09862E
        adda.w       d0, a1                                        ; $098632
        subq.w       #$1, a1                                       ; $098634
        move.b       #$d9, (a1)                                    ; $098636
        adda.w       d1, a1                                        ; $09863A
        move.b       #$d9, (a1)                                    ; $09863C
        adda.w       d1, a1                                        ; $098640
        move.b       #$d9, (a1)                                    ; $098642
        adda.w       d1, a1                                        ; $098646
        move.b       #$d9, (a1)                                    ; $098648
        adda.w       d1, a1                                        ; $09864C
        move.b       #$d9, (a1)                                    ; $09864E
        adda.w       d1, a1                                        ; $098652
        move.b       #$d9, (a1)                                    ; $098654
        adda.w       d1, a1                                        ; $098658
        move.b       #$d9, (a1)                                    ; $09865A
        adda.w       d1, a1                                        ; $09865E
        move.b       #$d9, (a1)                                    ; $098660
        move.w       rMapWindowOriginX(a6), d4                     ; $098664
        move.w       rMapWindowOriginY(a6), d5                     ; $098668
        jsr          ExtractVisibleMapWindow(pc)                   ; $09866C

loc_098670:
        rts                                                        ; $098670
        ifne *-$98672
        fail "ROM end moved"
        endif
