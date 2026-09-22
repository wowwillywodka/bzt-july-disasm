; $098672..$098795 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Write $DA..$E1 (reversed for orientations 2/4) into persistent map, then re-extract window. All eight are solid, even when animation texture is zero.
        ifne *-$98672
        fail "ROM start moved"
        endif

WriteTrainAnimatedCells:
; Write $DA..$E1 (reversed for orientations 2/4) into persistent map, then re-extract window. All eight are solid, even when animation texture is zero.
        cmpi.b       #$1, d0                                       ; $098672
        beq.b        loc_098690                                    ; $098676
        cmpi.b       #$2, d0                                       ; $098678
        beq.b        loc_0986C8                                    ; $09867C
        cmpi.b       #$3, d0                                       ; $09867E
        beq.b        loc_098700                                    ; $098682
        cmpi.b       #$4, d0                                       ; $098684
        beq.w        loc_09874C                                    ; $098688
        bra.w        loc_098794                                    ; $09868C

loc_098690:
        adda.w       rCurrentFloorWidth(a6), a1                    ; $098690
        adda.w       #$c, a1                                       ; $098694
        move.b       #$da, (a1)+                                   ; $098698
        move.b       #$db, (a1)+                                   ; $09869C
        move.b       #$dc, (a1)+                                   ; $0986A0
        move.b       #$dd, (a1)+                                   ; $0986A4
        move.b       #$de, (a1)+                                   ; $0986A8
        move.b       #$df, (a1)+                                   ; $0986AC
        move.b       #$e0, (a1)+                                   ; $0986B0
        move.b       #$e1, (a1)                                    ; $0986B4
        move.w       rMapWindowOriginX(a6), d4                     ; $0986B8
        move.w       rMapWindowOriginY(a6), d5                     ; $0986BC
        jsr          ExtractVisibleMapWindow(pc)                   ; $0986C0
        bra.w        loc_098794                                    ; $0986C4

loc_0986C8:
        suba.w       rCurrentFloorWidth(a6), a1                    ; $0986C8
        adda.w       #$c, a1                                       ; $0986CC
        move.b       #$e1, (a1)+                                   ; $0986D0
        move.b       #$e0, (a1)+                                   ; $0986D4
        move.b       #$df, (a1)+                                   ; $0986D8
        move.b       #$de, (a1)+                                   ; $0986DC
        move.b       #$dd, (a1)+                                   ; $0986E0
        move.b       #$dc, (a1)+                                   ; $0986E4
        move.b       #$db, (a1)+                                   ; $0986E8
        move.b       #$da, (a1)                                    ; $0986EC
        move.w       rMapWindowOriginX(a6), d4                     ; $0986F0
        move.w       rMapWindowOriginY(a6), d5                     ; $0986F4
        jsr          ExtractVisibleMapWindow(pc)                   ; $0986F8
        bra.w        loc_098794                                    ; $0986FC

loc_098700:
        move.w       rCurrentFloorWidth(a6), d0                    ; $098700
        move.w       d0, d1                                        ; $098704
        mulu.w       #$c, d0                                       ; $098706
        adda.w       d0, a1                                        ; $09870A
        addq.w       #$1, a1                                       ; $09870C
        move.b       #$da, (a1)                                    ; $09870E
        adda.w       d1, a1                                        ; $098712
        move.b       #$db, (a1)                                    ; $098714
        adda.w       d1, a1                                        ; $098718
        move.b       #$dc, (a1)                                    ; $09871A
        adda.w       d1, a1                                        ; $09871E
        move.b       #$dd, (a1)                                    ; $098720
        adda.w       d1, a1                                        ; $098724
        move.b       #$de, (a1)                                    ; $098726
        adda.w       d1, a1                                        ; $09872A
        move.b       #$df, (a1)                                    ; $09872C
        adda.w       d1, a1                                        ; $098730
        move.b       #$e0, (a1)                                    ; $098732
        adda.w       d1, a1                                        ; $098736
        move.b       #$e1, (a1)                                    ; $098738
        move.w       rMapWindowOriginX(a6), d4                     ; $09873C
        move.w       rMapWindowOriginY(a6), d5                     ; $098740
        jsr          ExtractVisibleMapWindow(pc)                   ; $098744
        bra.w        loc_098794                                    ; $098748

loc_09874C:
        move.w       rCurrentFloorWidth(a6), d0                    ; $09874C
        move.w       d0, d1                                        ; $098750
        mulu.w       #$c, d0                                       ; $098752
        adda.w       d0, a1                                        ; $098756
        subq.w       #$1, a1                                       ; $098758
        move.b       #$e1, (a1)                                    ; $09875A
        adda.w       d1, a1                                        ; $09875E
        move.b       #$e0, (a1)                                    ; $098760
        adda.w       d1, a1                                        ; $098764
        move.b       #$df, (a1)                                    ; $098766
        adda.w       d1, a1                                        ; $09876A
        move.b       #$de, (a1)                                    ; $09876C
        adda.w       d1, a1                                        ; $098770
        move.b       #$dd, (a1)                                    ; $098772
        adda.w       d1, a1                                        ; $098776
        move.b       #$dc, (a1)                                    ; $098778
        adda.w       d1, a1                                        ; $09877C
        move.b       #$db, (a1)                                    ; $09877E
        adda.w       d1, a1                                        ; $098782
        move.b       #$da, (a1)                                    ; $098784
        move.w       rMapWindowOriginX(a6), d4                     ; $098788
        move.w       rMapWindowOriginY(a6), d5                     ; $09878C
        jsr          ExtractVisibleMapWindow(pc)                   ; $098790

loc_098794:
        rts                                                        ; $098794
        ifne *-$98796
        fail "ROM end moved"
        endif
