; $01A146..$01A185 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Six cells north in LOCAL 32x32 window. Raw byte -> active type table. Zero passes; signed type<=7 blocks (including $80..FF), then types68/69/6A match. D2=cell distance; D6 nonzero on found.
        ifne *-$1A146
        fail "ROM start moved"
        endif

ScanBeatressMarkersNorth:
; Six cells north in LOCAL 32x32 window. Raw byte -> active type table. Zero passes; signed type<=7 blocks (including $80..FF), then types68/69/6A match. D2=cell distance; D6 nonzero on found.
        clr.w        d1                                            ; $01A146
        clr.w        d2                                            ; $01A148
        moveq        #$5, d7                                       ; $01A14A

loc_01A14C:
        suba.l       #$20, a1                                      ; $01A14C
        addq.w       #$1, d2                                       ; $01A152
        lea.l        rCellTypeByIndex(a6), a5                      ; $01A154
        clr.w        d0                                            ; $01A158
        move.b       (a1), d0                                      ; $01A15A
        move.b       (a5, d0.w), d0                                ; $01A15C
        beq.b        loc_01A168                                    ; $01A160
        cmpi.b       #$7, d0                                       ; $01A162
        ble.b        loc_01A17E                                    ; $01A166

loc_01A168:
        cmpi.b       #$68, d0                                      ; $01A168
        beq.b        loc_01A182                                    ; $01A16C
        cmpi.b       #$69, d0                                      ; $01A16E
        beq.b        loc_01A182                                    ; $01A172
        cmpi.b       #$6a, d0                                      ; $01A174
        beq.b        loc_01A182                                    ; $01A178
        dbra         d7, loc_01A14C                                ; $01A17A

loc_01A17E:
        clr.w        d6                                            ; $01A17E
        rts                                                        ; $01A180

loc_01A182:
        st.b         d6                                            ; $01A182
        rts                                                        ; $01A184
        ifne *-$1A186
        fail "ROM end moved"
        endif
