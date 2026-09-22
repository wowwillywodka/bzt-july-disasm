; $01A1C6..$01A201 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; West counterpart; D1=distance. Linear pointer may wrap rows; no X check.
        ifne *-$1A1C6
        fail "ROM start moved"
        endif

ScanBeatressMarkersWest:
; West counterpart; D1=distance. Linear pointer may wrap rows; no X check.
        clr.w        d1                                            ; $01A1C6
        clr.w        d2                                            ; $01A1C8
        moveq        #$5, d7                                       ; $01A1CA

loc_01A1CC:
        subq.l       #$1, a1                                       ; $01A1CC
        addq.w       #$1, d1                                       ; $01A1CE
        lea.l        rCellTypeByIndex(a6), a5                      ; $01A1D0
        clr.w        d0                                            ; $01A1D4
        move.b       (a1), d0                                      ; $01A1D6
        move.b       (a5, d0.w), d0                                ; $01A1D8
        beq.b        loc_01A1E4                                    ; $01A1DC
        cmpi.b       #$7, d0                                       ; $01A1DE
        ble.b        loc_01A1FA                                    ; $01A1E2

loc_01A1E4:
        cmpi.b       #$68, d0                                      ; $01A1E4
        beq.b        loc_01A1FE                                    ; $01A1E8
        cmpi.b       #$69, d0                                      ; $01A1EA
        beq.b        loc_01A1FE                                    ; $01A1EE
        cmpi.b       #$6a, d0                                      ; $01A1F0
        beq.b        loc_01A1FE                                    ; $01A1F4
        dbra         d7, loc_01A1CC                                ; $01A1F6

loc_01A1FA:
        clr.w        d6                                            ; $01A1FA
        rts                                                        ; $01A1FC

loc_01A1FE:
        st.b         d6                                            ; $01A1FE
        rts                                                        ; $01A200
        ifne *-$1A202
        fail "ROM end moved"
        endif
