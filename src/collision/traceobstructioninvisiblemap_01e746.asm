; $01E746..$01E80D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Single sampled ray using VisibleMapBasePointer. N=octagonal distance>>6; N<2 returns clear without samples; else N-1 points with signed integer delta/N. Endpoints not tested; same collision classes/diagonals as projectile point. A1 restored, D0=0/1 and Z.
        ifne *-$1E746
        fail "ROM start moved"
        endif

TraceObstructionInVisibleMap:
; Single sampled ray using VisibleMapBasePointer. N=octagonal distance>>6; N<2 returns clear without samples; else N-1 points with signed integer delta/N. Endpoints not tested; same collision classes/diagonals as projectile point. A1 restored, D0=0/1 and Z.
        move.l       a1, -(a7)                                     ; $01E746
        movem.w      d0-d1, -(a7)                                  ; $01E748
        sub.w        d3, d0                                        ; $01E74C
        sub.w        d4, d1                                        ; $01E74E
        jsr          OctagonalDistance.l                           ; $01E750
        move.w       d0, d2                                        ; $01E756
        movem.w      (a7)+, d0-d1                                  ; $01E758
        sub.w        d0, d3                                        ; $01E75C
        sub.w        d1, d4                                        ; $01E75E
        lsr.w        #$6, d2                                       ; $01E760
        beq.w        loc_01E7FE                                    ; $01E762
        cmpi.w       #$1, d2                                       ; $01E766
        beq.w        loc_01E7FE                                    ; $01E76A
        ext.l        d3                                            ; $01E76E
        ext.l        d4                                            ; $01E770
        tst.w        d2                                            ; $01E772
        beq.b        loc_01E77A                                    ; $01E774
        divs.w       d2, d3                                        ; $01E776
        divs.w       d2, d4                                        ; $01E778

loc_01E77A:
        move.w       d3, d6                                        ; $01E77A
        subq.w       #$2, d2                                       ; $01E77C
        lea.l        rCellTypeByIndex(a6), a5                      ; $01E77E

loc_01E782:
        movea.l      rVisibleMapBasePointer(a6), a1                ; $01E782
        add.w        d6, d0                                        ; $01E786
        add.w        d4, d1                                        ; $01E788
        move.w       d0, d5                                        ; $01E78A
        asr.w        #$8, d5                                       ; $01E78C
        adda.w       d5, a1                                        ; $01E78E
        move.w       d1, d5                                        ; $01E790
        clr.b        d5                                            ; $01E792
        asr.w        #$3, d5                                       ; $01E794
        clr.w        d3                                            ; $01E796
        move.b       (a1, d5.w), d3                                ; $01E798
        move.b       (a5, d3.w), d3                                ; $01E79C
        jsr          GetCellCollisionClass.l                       ; $01E7A0
        beq.w        loc_01E7FA                                    ; $01E7A6
        cmpi.b       #$6, d3                                       ; $01E7AA
        bcs.w        loc_01E7B4                                    ; $01E7AE
        bra.b        loc_01E806                                    ; $01E7B2

loc_01E7B4:
        cmpi.b       #$1, d3                                       ; $01E7B4
        beq.b        loc_01E806                                    ; $01E7B8
        clr.w        d5                                            ; $01E7BA
        move.b       d0, d5                                        ; $01E7BC
        cmpi.b       #$2, d3                                       ; $01E7BE
        beq.b        loc_01E7F2                                    ; $01E7C2
        cmpi.b       #$3, d3                                       ; $01E7C4
        beq.b        loc_01E7DC                                    ; $01E7C8
        cmpi.b       #$4, d3                                       ; $01E7CA
        beq.b        loc_01E7E8                                    ; $01E7CE
        move.w       #$ff, d3                                      ; $01E7D0
        sub.b        d1, d3                                        ; $01E7D4
        cmp.w        d3, d5                                        ; $01E7D6
        bge.b        loc_01E7FA                                    ; $01E7D8
        bra.b        loc_01E806                                    ; $01E7DA

loc_01E7DC:
        move.w       #$ff, d3                                      ; $01E7DC
        sub.b        d1, d3                                        ; $01E7E0
        cmp.w        d3, d5                                        ; $01E7E2
        ble.b        loc_01E7FA                                    ; $01E7E4
        bra.b        loc_01E806                                    ; $01E7E6

loc_01E7E8:
        clr.w        d3                                            ; $01E7E8
        move.b       d1, d3                                        ; $01E7EA
        cmp.w        d3, d5                                        ; $01E7EC
        bge.b        loc_01E7FA                                    ; $01E7EE
        bra.b        loc_01E806                                    ; $01E7F0

loc_01E7F2:
        clr.w        d3                                            ; $01E7F2
        move.b       d1, d3                                        ; $01E7F4
        cmp.w        d3, d5                                        ; $01E7F6
        bgt.b        loc_01E806                                    ; $01E7F8

loc_01E7FA:
        dbra         d2, loc_01E782                                ; $01E7FA

loc_01E7FE:
        movea.l      (a7)+, a1                                     ; $01E7FE
        move.w       #$0, d0                                       ; $01E800
        rts                                                        ; $01E804

loc_01E806:
        movea.l      (a7)+, a1                                     ; $01E806
        move.w       #$1, d0                                       ; $01E808
        rts                                                        ; $01E80C
        ifne *-$1E80E
        fail "ROM end moved"
        endif
