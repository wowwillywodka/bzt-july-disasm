; $01E856..$01E91D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Single ray counterpart using fixed active window FFA5FA each sample. Used for explosion->actor; player path uses VisibleMapBasePointer counterpart. No independent per-actor floor map selection.
        ifne *-$1E856
        fail "ROM start moved"
        endif

TraceObstructionInActiveWindow:
; Single ray counterpart using fixed active window FFA5FA each sample. Used for explosion->actor; player path uses VisibleMapBasePointer counterpart. No independent per-actor floor map selection.
        move.l       a1, -(a7)                                     ; $01E856
        movem.w      d0-d1, -(a7)                                  ; $01E858
        sub.w        d3, d0                                        ; $01E85C
        sub.w        d4, d1                                        ; $01E85E
        jsr          OctagonalDistance.l                           ; $01E860
        move.w       d0, d2                                        ; $01E866
        movem.w      (a7)+, d0-d1                                  ; $01E868
        sub.w        d0, d3                                        ; $01E86C
        sub.w        d1, d4                                        ; $01E86E
        lsr.w        #$6, d2                                       ; $01E870
        beq.w        loc_01E90E                                    ; $01E872
        cmpi.w       #$1, d2                                       ; $01E876
        beq.w        loc_01E90E                                    ; $01E87A
        ext.l        d3                                            ; $01E87E
        ext.l        d4                                            ; $01E880
        tst.w        d2                                            ; $01E882
        beq.b        loc_01E88A                                    ; $01E884
        divs.w       d2, d3                                        ; $01E886
        divs.w       d2, d4                                        ; $01E888

loc_01E88A:
        move.w       d3, d6                                        ; $01E88A
        subq.w       #$2, d2                                       ; $01E88C
        lea.l        rCellTypeByIndex(a6), a5                      ; $01E88E

loc_01E892:
        bsr.w        GetVisibleMapBase                             ; $01E892
        add.w        d6, d0                                        ; $01E896
        add.w        d4, d1                                        ; $01E898
        move.w       d0, d5                                        ; $01E89A
        asr.w        #$8, d5                                       ; $01E89C
        adda.w       d5, a1                                        ; $01E89E
        move.w       d1, d5                                        ; $01E8A0
        clr.b        d5                                            ; $01E8A2
        asr.w        #$3, d5                                       ; $01E8A4
        clr.w        d3                                            ; $01E8A6
        move.b       (a1, d5.w), d3                                ; $01E8A8
        move.b       (a5, d3.w), d3                                ; $01E8AC
        jsr          GetCellCollisionClass.l                       ; $01E8B0
        beq.w        loc_01E90A                                    ; $01E8B6
        cmpi.b       #$6, d3                                       ; $01E8BA
        bcs.w        loc_01E8C4                                    ; $01E8BE
        bra.b        loc_01E916                                    ; $01E8C2

loc_01E8C4:
        cmpi.b       #$1, d3                                       ; $01E8C4
        beq.b        loc_01E916                                    ; $01E8C8
        clr.w        d5                                            ; $01E8CA
        move.b       d0, d5                                        ; $01E8CC
        cmpi.b       #$2, d3                                       ; $01E8CE
        beq.b        loc_01E902                                    ; $01E8D2
        cmpi.b       #$3, d3                                       ; $01E8D4
        beq.b        loc_01E8EC                                    ; $01E8D8
        cmpi.b       #$4, d3                                       ; $01E8DA
        beq.b        loc_01E8F8                                    ; $01E8DE
        move.w       #$ff, d3                                      ; $01E8E0
        sub.b        d1, d3                                        ; $01E8E4
        cmp.w        d3, d5                                        ; $01E8E6
        bge.b        loc_01E90A                                    ; $01E8E8
        bra.b        loc_01E916                                    ; $01E8EA

loc_01E8EC:
        move.w       #$ff, d3                                      ; $01E8EC
        sub.b        d1, d3                                        ; $01E8F0
        cmp.w        d3, d5                                        ; $01E8F2
        ble.b        loc_01E90A                                    ; $01E8F4
        bra.b        loc_01E916                                    ; $01E8F6

loc_01E8F8:
        clr.w        d3                                            ; $01E8F8
        move.b       d1, d3                                        ; $01E8FA
        cmp.w        d3, d5                                        ; $01E8FC
        bge.b        loc_01E90A                                    ; $01E8FE
        bra.b        loc_01E916                                    ; $01E900

loc_01E902:
        clr.w        d3                                            ; $01E902
        move.b       d1, d3                                        ; $01E904
        cmp.w        d3, d5                                        ; $01E906
        bgt.b        loc_01E916                                    ; $01E908

loc_01E90A:
        dbra         d2, loc_01E892                                ; $01E90A

loc_01E90E:
        movea.l      (a7)+, a1                                     ; $01E90E
        move.w       #$0, d0                                       ; $01E910
        rts                                                        ; $01E914

loc_01E916:
        movea.l      (a7)+, a1                                     ; $01E916
        move.w       #$1, d0                                       ; $01E918
        rts                                                        ; $01E91C
        ifne *-$1E91E
        fail "ROM end moved"
        endif
