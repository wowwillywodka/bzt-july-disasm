; $01A186..$01A1C5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; South counterpart, same six-cell/type contract; D2=distance.
        ifne *-$1A186
        fail "ROM start moved"
        endif

ScanBeatressMarkersSouth:
; South counterpart, same six-cell/type contract; D2=distance.
        clr.w        d1                                            ; $01A186
        clr.w        d2                                            ; $01A188
        moveq        #$5, d7                                       ; $01A18A

loc_01A18C:
        adda.l       #$20, a1                                      ; $01A18C
        addq.w       #$1, d2                                       ; $01A192
        lea.l        rCellTypeByIndex(a6), a5                      ; $01A194
        clr.w        d0                                            ; $01A198
        move.b       (a1), d0                                      ; $01A19A
        move.b       (a5, d0.w), d0                                ; $01A19C
        beq.b        loc_01A1A8                                    ; $01A1A0
        cmpi.b       #$7, d0                                       ; $01A1A2
        ble.b        loc_01A1BE                                    ; $01A1A6

loc_01A1A8:
        cmpi.b       #$68, d0                                      ; $01A1A8
        beq.b        loc_01A1C2                                    ; $01A1AC
        cmpi.b       #$69, d0                                      ; $01A1AE
        beq.b        loc_01A1C2                                    ; $01A1B2
        cmpi.b       #$6a, d0                                      ; $01A1B4
        beq.b        loc_01A1C2                                    ; $01A1B8
        dbra         d7, loc_01A18C                                ; $01A1BA

loc_01A1BE:
        clr.w        d6                                            ; $01A1BE
        rts                                                        ; $01A1C0

loc_01A1C2:
        st.b         d6                                            ; $01A1C2
        rts                                                        ; $01A1C4
        ifne *-$1A1C6
        fail "ROM end moved"
        endif
