; $01A0A2..$01A145 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Find type68/69/6A within six cells along N,S,E,W (priority, not nearest). Returns D7.w=0 on found, nonzero otherwise; sets Byte52 on found. No row/edge bounds checks.
        ifne *-$1A0A2
        fail "ROM start moved"
        endif

FindBeatressNeighborMarkerGoal:
; Find type68/69/6A within six cells along N,S,E,W (priority, not nearest). Returns D7.w=0 on found, nonzero otherwise; sets Byte52 on found. No row/edge bounds checks.
        clr.w        d0                                            ; $01A0A2
        lea.l        rVisibleMapWindow(a6), a1                     ; $01A0A4
        move.w       ActorX(a0), d0                                ; $01A0A8
        lsr.w        #$8, d0                                       ; $01A0AC
        adda.w       d0, a1                                        ; $01A0AE
        move.w       ActorY(a0), d0                                ; $01A0B0
        lsr.w        #$8, d0                                       ; $01A0B4
        lsl.w        #$5, d0                                       ; $01A0B6
        adda.w       d0, a1                                        ; $01A0B8
        move.l       a1, -(a7)                                     ; $01A0BA
        bsr.w        ScanBeatressMarkersNorth                      ; $01A0BC
        movea.l      (a7)+, a1                                     ; $01A0C0
        tst.w        d6                                            ; $01A0C2
        beq.b        loc_01A0DC                                    ; $01A0C4
        move.w       ActorY(a0), d0                                ; $01A0C6
        move.w       d0, ActorGoalY(a0)                            ; $01A0CA
        asl.w        #$8, d2                                       ; $01A0CE
        sub.w        d2, ActorGoalY(a0)                            ; $01A0D0
        st.b         ActorBehaviorByte52(a0)                       ; $01A0D4
        clr.w        d7                                            ; $01A0D8
        rts                                                        ; $01A0DA

loc_01A0DC:
        move.l       a1, -(a7)                                     ; $01A0DC
        bsr.w        ScanBeatressMarkersSouth                      ; $01A0DE
        movea.l      (a7)+, a1                                     ; $01A0E2
        tst.w        d6                                            ; $01A0E4
        beq.b        loc_01A0FE                                    ; $01A0E6
        move.w       ActorY(a0), d0                                ; $01A0E8
        move.w       d0, ActorGoalY(a0)                            ; $01A0EC
        asl.w        #$8, d2                                       ; $01A0F0
        add.w        d2, ActorGoalY(a0)                            ; $01A0F2
        st.b         ActorBehaviorByte52(a0)                       ; $01A0F6
        clr.w        d7                                            ; $01A0FA
        rts                                                        ; $01A0FC

loc_01A0FE:
        move.l       a1, -(a7)                                     ; $01A0FE
        bsr.w        ScanBeatressMarkersEast                       ; $01A100
        movea.l      (a7)+, a1                                     ; $01A104
        tst.w        d6                                            ; $01A106
        beq.b        loc_01A120                                    ; $01A108
        move.w       ActorX(a0), d0                                ; $01A10A
        move.w       d0, ActorGoalX(a0)                            ; $01A10E
        asl.w        #$8, d1                                       ; $01A112
        add.w        d1, ActorGoalX(a0)                            ; $01A114
        st.b         ActorBehaviorByte52(a0)                       ; $01A118
        clr.w        d7                                            ; $01A11C
        rts                                                        ; $01A11E

loc_01A120:
        move.l       a1, -(a7)                                     ; $01A120
        bsr.w        ScanBeatressMarkersWest                       ; $01A122
        movea.l      (a7)+, a1                                     ; $01A126
        tst.w        d6                                            ; $01A128
        beq.b        loc_01A142                                    ; $01A12A
        move.w       ActorX(a0), d0                                ; $01A12C
        move.w       d0, ActorGoalX(a0)                            ; $01A130
        asl.w        #$8, d1                                       ; $01A134
        sub.w        d1, ActorGoalX(a0)                            ; $01A136
        st.b         ActorBehaviorByte52(a0)                       ; $01A13A
        clr.w        d7                                            ; $01A13E
        rts                                                        ; $01A140

loc_01A142:
        st.b         d7                                            ; $01A142
        rts                                                        ; $01A144
        ifne *-$1A146
        fail "ROM end moved"
        endif
