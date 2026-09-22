; $09842A..$09854D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0=orientation 1..4, A1=persistent map anchor. Write eight docked cells with two passable door positions, then re-extract current local window. Former ClosedFace label was misleading.
        ifne *-$9842A
        fail "ROM start moved"
        endif

WriteTrainDockedCells:
; D0=orientation 1..4, A1=persistent map anchor. Write eight docked cells with two passable door positions, then re-extract current local window. Former ClosedFace label was misleading.
        cmpi.b       #$1, d0                                       ; $09842A
        beq.b        loc_098448                                    ; $09842E
        cmpi.b       #$2, d0                                       ; $098430
        beq.b        loc_098480                                    ; $098434
        cmpi.b       #$3, d0                                       ; $098436
        beq.b        loc_0984B8                                    ; $09843A
        cmpi.b       #$4, d0                                       ; $09843C
        beq.w        loc_098504                                    ; $098440
        bra.w        loc_09854C                                    ; $098444

loc_098448:
        adda.w       rCurrentFloorWidth(a6), a1                    ; $098448
        adda.w       #$c, a1                                       ; $09844C
        move.b       #$e3, (a1)+                                   ; $098450
        move.b       #$e3, (a1)+                                   ; $098454
        move.b       #$d4, (a1)+                                   ; $098458
        move.b       #$e3, (a1)+                                   ; $09845C
        move.b       #$e3, (a1)+                                   ; $098460
        move.b       #$d4, (a1)+                                   ; $098464
        move.b       #$e3, (a1)+                                   ; $098468
        move.b       #$e3, (a1)                                    ; $09846C
        move.w       rMapWindowOriginX(a6), d4                     ; $098470
        move.w       rMapWindowOriginY(a6), d5                     ; $098474
        jsr          ExtractVisibleMapWindow(pc)                   ; $098478
        bra.w        loc_09854C                                    ; $09847C

loc_098480:
        suba.w       rCurrentFloorWidth(a6), a1                    ; $098480
        adda.w       #$c, a1                                       ; $098484
        move.b       #$e2, (a1)+                                   ; $098488
        move.b       #$e2, (a1)+                                   ; $09848C
        move.b       #$d6, (a1)+                                   ; $098490
        move.b       #$e2, (a1)+                                   ; $098494
        move.b       #$e2, (a1)+                                   ; $098498
        move.b       #$d6, (a1)+                                   ; $09849C
        move.b       #$e2, (a1)+                                   ; $0984A0
        move.b       #$e2, (a1)                                    ; $0984A4
        move.w       rMapWindowOriginX(a6), d4                     ; $0984A8
        move.w       rMapWindowOriginY(a6), d5                     ; $0984AC
        jsr          ExtractVisibleMapWindow(pc)                   ; $0984B0
        bra.w        loc_09854C                                    ; $0984B4

loc_0984B8:
        move.w       rCurrentFloorWidth(a6), d0                    ; $0984B8
        move.w       d0, d1                                        ; $0984BC
        mulu.w       #$c, d0                                       ; $0984BE
        adda.w       d0, a1                                        ; $0984C2
        addq.w       #$1, a1                                       ; $0984C4
        move.b       #$e4, (a1)                                    ; $0984C6
        adda.w       d1, a1                                        ; $0984CA
        move.b       #$e4, (a1)                                    ; $0984CC
        adda.w       d1, a1                                        ; $0984D0
        move.b       #$d5, (a1)                                    ; $0984D2
        adda.w       d1, a1                                        ; $0984D6
        move.b       #$e4, (a1)                                    ; $0984D8
        adda.w       d1, a1                                        ; $0984DC
        move.b       #$e4, (a1)                                    ; $0984DE
        adda.w       d1, a1                                        ; $0984E2
        move.b       #$d5, (a1)                                    ; $0984E4
        adda.w       d1, a1                                        ; $0984E8
        move.b       #$e4, (a1)                                    ; $0984EA
        adda.w       d1, a1                                        ; $0984EE
        move.b       #$e4, (a1)                                    ; $0984F0
        move.w       rMapWindowOriginX(a6), d4                     ; $0984F4
        move.w       rMapWindowOriginY(a6), d5                     ; $0984F8
        jsr          ExtractVisibleMapWindow(pc)                   ; $0984FC
        bra.w        loc_09854C                                    ; $098500

loc_098504:
        move.w       rCurrentFloorWidth(a6), d0                    ; $098504
        move.w       d0, d1                                        ; $098508
        mulu.w       #$c, d0                                       ; $09850A
        adda.w       d0, a1                                        ; $09850E
        subq.w       #$1, a1                                       ; $098510
        move.b       #$e5, (a1)                                    ; $098512
        adda.w       d1, a1                                        ; $098516
        move.b       #$e5, (a1)                                    ; $098518
        adda.w       d1, a1                                        ; $09851C
        move.b       #$d7, (a1)                                    ; $09851E
        adda.w       d1, a1                                        ; $098522
        move.b       #$e5, (a1)                                    ; $098524
        adda.w       d1, a1                                        ; $098528
        move.b       #$e5, (a1)                                    ; $09852A
        adda.w       d1, a1                                        ; $09852E
        move.b       #$d7, (a1)                                    ; $098530
        adda.w       d1, a1                                        ; $098534
        move.b       #$e5, (a1)                                    ; $098536
        adda.w       d1, a1                                        ; $09853A
        move.b       #$e5, (a1)                                    ; $09853C
        move.w       rMapWindowOriginX(a6), d4                     ; $098540
        move.w       rMapWindowOriginY(a6), d5                     ; $098544
        jsr          ExtractVisibleMapWindow(pc)                   ; $098548

loc_09854C:
        rts                                                        ; $09854C
        ifne *-$9854E
        fail "ROM end moved"
        endif
