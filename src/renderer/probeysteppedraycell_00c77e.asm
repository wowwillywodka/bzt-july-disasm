; $00C77E..$00C91F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Probe the Y-stepped cell of a diagonal ray. Class 4 uses the second
; slope crossing test. The dispatcher receives exchanged DDA register banks.
        ifne *-$C77E
        fail "ROM start moved"
        endif

ProbeYSteppedRayCell:
        andi.w       #$ff, d3                                      ; $00C77E
        move.b       (a5, d3.w), d3                                ; $00C782
        bne.b        loc_00C78A                                    ; $00C786
        rts                                                        ; $00C788

loc_00C78A:
        cmpi.b       #$6, d3                                       ; $00C78A
        bcc.b        loc_00C7A4                                    ; $00C78E
        cmpi.b       #$4, d3                                       ; $00C790
        bne.b        loc_00C7A2                                    ; $00C794
        move.w       d6, d3                                        ; $00C796
        add.w        $2(a4), d3                                    ; $00C798
        cmp.w        d7, d3                                        ; $00C79C
        bhi.b        loc_00C7BE                                    ; $00C79E
        moveq        #$4, d3                                       ; $00C7A0

loc_00C7A2:
        rts                                                        ; $00C7A2

loc_00C7A4:
        exg.l        d0, d4                                        ; $00C7A4
        exg.l        d1, d5                                        ; $00C7A6
        exg.l        d2, d6                                        ; $00C7A8
        exg.l        a0, a1                                        ; $00C7AA
        bsr.w        DispatchVisibleCell                           ; $00C7AC
        exg.l        d0, d4                                        ; $00C7B0
        exg.l        d1, d5                                        ; $00C7B2
        exg.l        d2, d6                                        ; $00C7B4
        exg.l        a0, a1                                        ; $00C7B6
        tst.b        d3                                            ; $00C7B8
        bne.b        loc_00C78A                                    ; $00C7BA
        rts                                                        ; $00C7BC

loc_00C7BE:
        clr.w        d3                                            ; $00C7BE
        rts                                                        ; $00C7C0

loc_00C7C2:
        cmpa.l       rCurrentWallMapCellPointer(a6), a0                                ; $00C7C2
        beq.w        loc_00C71A                                    ; $00C7C6
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00C7CA
        clr.w        d4                                            ; $00C7CE
        move.b       (a0), d4                                      ; $00C7D0
; Cell index * 8: four word texture IDs per cell; map width is unrelated to this fixed record size.
        lsl.w        #$3, d4                                       ; $00C7D2
        lea.l        rTextureOrder(a6), a2                         ; $00C7D4
        adda.w       d4, a2                                        ; $00C7D8
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C7DA
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00C7DE
        add.w        rPlayerCellX(a6), d0                          ; $00C7E2
        lsl.w        #$8, d0                                       ; $00C7E6
        add.w        rPlayerCellY(a6), d1                          ; $00C7E8
        lsl.w        #$8, d1                                       ; $00C7EC
        bra.w        RenderWallEdgeX0                        ; $00C7EE

loc_00C7F2:
        cmpa.l       rCurrentWallMapCellPointer(a6), a1                                ; $00C7F2
        beq.w        loc_00C71A                                    ; $00C7F6
        move.w       d4, d0                                        ; $00C7FA
        move.w       d5, d1                                        ; $00C7FC
        move.w       d6, d2                                        ; $00C7FE
        movea.l      a1, a0                                        ; $00C800
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00C802
        clr.w        d4                                            ; $00C806
        move.b       (a0), d4                                      ; $00C808
        lsl.w        #$3, d4                                       ; $00C80A
        lea.l        rTextureOrder(a6), a2                         ; $00C80C
        adda.w       d4, a2                                        ; $00C810
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C812
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00C816
        add.w        rPlayerCellX(a6), d0                          ; $00C81A
        lsl.w        #$8, d0                                       ; $00C81E
        add.w        rPlayerCellY(a6), d1                          ; $00C820
        lsl.w        #$8, d1                                       ; $00C824
        clr.w        d4                                            ; $00C826
        move.b       -$1(a0), d4                                   ; $00C828
        move.b       (a5, d4.w), d4                                ; $00C82C
        cmpi.b       #$1, d4                                       ; $00C830
        beq.b        loc_00C858                                    ; $00C834
        cmpi.b       #$2, d4                                       ; $00C836
        beq.b        loc_00C858                                    ; $00C83A
        cmpi.b       #$3, d4                                       ; $00C83C
        beq.b        loc_00C858                                    ; $00C840
        cmpi.b       #$5, d4                                       ; $00C842
        beq.b        loc_00C858                                    ; $00C846
        movem.w      d0-d1/d3, -(a7)                               ; $00C848
        bsr.w        RenderWallEdgeY0                        ; $00C84C
        movem.w      (a7)+, d0-d1/d3                               ; $00C850
        bra.w        RenderWallEdgeX0                        ; $00C854

loc_00C858:
        bra.w        RenderWallEdgeY0                        ; $00C858

loc_00C85C:
        lea.l        RaySlopePairs(pc), a4                         ; $00C85C
        lsl.w        #$2, d0                                       ; $00C860
        adda.w       d0, a4                                        ; $00C862
        move.w       #$ff, d7                                      ; $00C864
        clr.w        d0                                            ; $00C868
        clr.w        d1                                            ; $00C86A
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C86C
        clr.w        d3                                            ; $00C870
        move.b       (a0), d3                                      ; $00C872
        move.b       (a5, d3.w), d3                                ; $00C874
        cmpi.b       #$2, d3                                       ; $00C878
        beq.w        loc_00CFD8                                    ; $00C87C
        move.w       rPlayerCellFractionXComplement(a6), d2                                ; $00C880
        mulu.w       (a4), d2                                      ; $00C884
        lsr.l        #$8, d2                                       ; $00C886
        add.w        rPlayerCellFractionYComplement(a6), d2                                ; $00C888
        cmp.w        d7, d2                                        ; $00C88C
        bhi.b        loc_00C898                                    ; $00C88E
        cmpi.b       #$3, d3                                       ; $00C890
        beq.w        loc_00D0B4                                    ; $00C894

loc_00C898:
        move.w       rPlayerCellFractionY(a6), d6                                ; $00C898
        mulu.w       $2(a4), d6                                    ; $00C89C
        lsr.l        #$8, d6                                       ; $00C8A0
        add.w        rPlayerCellFractionX(a6), d6                                ; $00C8A2
        cmp.w        d7, d6                                        ; $00C8A6
        bhi.b        loc_00C8B2                                    ; $00C8A8
        cmpi.b       #$5, d3                                       ; $00C8AA
        beq.w        loc_00D044                                    ; $00C8AE

loc_00C8B2:
        move.w       d0, d4                                        ; $00C8B2
        move.w       d1, d5                                        ; $00C8B4
        movea.l      a0, a1                                        ; $00C8B6
        addq.w       #$1, a0                                       ; $00C8B8
        addq.w       #$1, d0                                       ; $00C8BA
        suba.w       #$20, a1                                      ; $00C8BC
        subq.w       #$1, d5                                       ; $00C8C0
        cmp.w        d7, d2                                        ; $00C8C2
        bls.b        loc_00C8D2                                    ; $00C8C4
        move.w       d2, d3                                        ; $00C8C6
        and.w        d7, d2                                        ; $00C8C8
        lsr.w        #$8, d3                                       ; $00C8CA
        sub.w        d3, d1                                        ; $00C8CC
        lsl.w        #$5, d3                                       ; $00C8CE
        suba.w       d3, a0                                        ; $00C8D0

loc_00C8D2:
        cmp.w        d7, d6                                        ; $00C8D2
        bls.b        loc_00C8E0                                    ; $00C8D4
        move.w       d6, d3                                        ; $00C8D6
        and.w        d7, d6                                        ; $00C8D8
        lsr.w        #$8, d3                                       ; $00C8DA
        add.w        d3, d4                                        ; $00C8DC
        adda.w       d3, a1                                        ; $00C8DE

loc_00C8E0:
        cmp.w        d4, d0                                        ; $00C8E0
        blt.b        loc_00C8EA                                    ; $00C8E2
        bgt.b        loc_00C904                                    ; $00C8E4
        cmp.w        d5, d1                                        ; $00C8E6
        ble.b        loc_00C904                                    ; $00C8E8

loc_00C8EA:
        cmp.w        rVisibleRayMaxLocalX(a6), d0                                ; $00C8EA
        bgt.b        loc_00C91E                                    ; $00C8EE
        cmp.w        rVisibleRayMinLocalY(a6), d1                                ; $00C8F0
        blt.b        loc_00C91E                                    ; $00C8F4
        move.b       (a0), d3                                      ; $00C8F6
        beq.b        loc_00C900                                    ; $00C8F8
        bsr.b        ProbeQuadrantTwoXCell                        ; $00C8FA
        bne.w        loc_00C9C6                                    ; $00C8FC

loc_00C900:
        bsr.b        RayStepQuadrantTwoX                           ; $00C900
        bra.b        loc_00C8E0                                    ; $00C902

loc_00C904:
        cmp.w        rVisibleRayMaxLocalX(a6), d4                                ; $00C904
        bgt.b        loc_00C91E                                    ; $00C908
        cmp.w        rVisibleRayMinLocalY(a6), d5                                ; $00C90A
        blt.b        loc_00C91E                                    ; $00C90E
        move.b       (a1), d3                                      ; $00C910
        beq.b        loc_00C91A                                    ; $00C912
        bsr.b        ProbeQuadrantTwoYCell                        ; $00C914
        bne.w        loc_00CA28                                    ; $00C916

loc_00C91A:
        bsr.b        RayStepQuadrantTwoY                           ; $00C91A
        bra.b        loc_00C8E0                                    ; $00C91C

loc_00C91E:
        rts                                                        ; $00C91E
        ifne *-$C920
        fail "ROM end moved"
        endif
