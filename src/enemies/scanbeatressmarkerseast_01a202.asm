; $01A202..$01A23D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; East counterpart; D1=distance. Search caller tries east BEFORE west.
        ifne *-$1A202
        fail "ROM start moved"
        endif

ScanBeatressMarkersEast:
; East counterpart; D1=distance. Search caller tries east BEFORE west.
        clr.w        d1                                            ; $01A202
        clr.w        d2                                            ; $01A204
        moveq        #$5, d7                                       ; $01A206

loc_01A208:
        addq.l       #$1, a1                                       ; $01A208
        addq.w       #$1, d1                                       ; $01A20A
        lea.l        rCellTypeByIndex(a6), a5                      ; $01A20C
        clr.w        d0                                            ; $01A210
        move.b       (a1), d0                                      ; $01A212
        move.b       (a5, d0.w), d0                                ; $01A214
        beq.b        loc_01A220                                    ; $01A218
        cmpi.b       #$7, d0                                       ; $01A21A
        ble.b        loc_01A236                                    ; $01A21E

loc_01A220:
        cmpi.b       #$68, d0                                      ; $01A220
        beq.b        loc_01A23A                                    ; $01A224
        cmpi.b       #$69, d0                                      ; $01A226
        beq.b        loc_01A23A                                    ; $01A22A
        cmpi.b       #$6a, d0                                      ; $01A22C
        beq.b        loc_01A23A                                    ; $01A230
        dbra         d7, loc_01A208                                ; $01A232

loc_01A236:
        clr.w        d6                                            ; $01A236
        rts                                                        ; $01A238

loc_01A23A:
        st.b         d6                                            ; $01A23A
        rts                                                        ; $01A23C
        ifne *-$1A23E
        fail "ROM end moved"
        endif
