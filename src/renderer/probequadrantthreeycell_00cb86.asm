; $00CB86..$00CD27 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проверка попадания луча в клетку (ветка A1): celltype=(A5,D3), код 2 (грань стены) с add (2,A4),D3>D7 даёт промах; celltype>=6 — exg D0..A1 и рекурсия в диспетчер 0x8b50 на встречном направлении; hit через Z-флаг
        ifne *-$CB86
        fail "ROM start moved"
        endif

ProbeQuadrantThreeYCell:
; A1 cell: class 2 uses D6+slopeY; >=6 dispatches with the cursor banks swapped.
        andi.w       #$ff, d3                                      ; $00CB86
        move.b       (a5, d3.w), d3                                ; $00CB8A
        bne.b        loc_00CB92                                    ; $00CB8E
        rts                                                        ; $00CB90

loc_00CB92:
        cmpi.b       #$6, d3                                       ; $00CB92
        bcc.b        loc_00CBAC                                    ; $00CB96
        cmpi.b       #$2, d3                                       ; $00CB98
        bne.b        loc_00CBAA                                    ; $00CB9C
        move.w       d6, d3                                        ; $00CB9E
        add.w        $2(a4), d3                                    ; $00CBA0
        cmp.w        d7, d3                                        ; $00CBA4
        bhi.b        loc_00CBC6                                    ; $00CBA6
        moveq        #$2, d3                                       ; $00CBA8

loc_00CBAA:
        rts                                                        ; $00CBAA

loc_00CBAC:
        exg.l        d0, d4                                        ; $00CBAC
        exg.l        d1, d5                                        ; $00CBAE
        exg.l        d2, d6                                        ; $00CBB0
        exg.l        a0, a1                                        ; $00CBB2
        bsr.w        DispatchVisibleCell                           ; $00CBB4
        exg.l        d0, d4                                        ; $00CBB8
        exg.l        d1, d5                                        ; $00CBBA
        exg.l        d2, d6                                        ; $00CBBC
        exg.l        a0, a1                                        ; $00CBBE
        tst.b        d3                                            ; $00CBC0
        bne.b        loc_00CB92                                    ; $00CBC2
        rts                                                        ; $00CBC4

loc_00CBC6:
        clr.w        d3                                            ; $00CBC6
        rts                                                        ; $00CBC8

loc_00CBCA:
        cmpa.l       rCurrentWallMapCellPointer(a6), a0                                ; $00CBCA
        beq.w        loc_00CB22                                    ; $00CBCE
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00CBD2
        clr.w        d4                                            ; $00CBD6
        move.b       (a0), d4                                      ; $00CBD8
        lsl.w        #$3, d4                                       ; $00CBDA
        lea.l        rTextureOrder(a6), a2                         ; $00CBDC
        adda.w       d4, a2                                        ; $00CBE0
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CBE2
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00CBE6
        add.w        rPlayerCellX(a6), d0                          ; $00CBEA
        lsl.w        #$8, d0                                       ; $00CBEE
        add.w        rPlayerCellY(a6), d1                          ; $00CBF0
        lsl.w        #$8, d1                                       ; $00CBF4
        bra.w        RenderWallEdgeX1                        ; $00CBF6

loc_00CBFA:
        cmpa.l       rCurrentWallMapCellPointer(a6), a1                                ; $00CBFA
        beq.w        loc_00CB22                                    ; $00CBFE
        move.w       d4, d0                                        ; $00CC02
        move.w       d5, d1                                        ; $00CC04
        move.w       d6, d2                                        ; $00CC06
        movea.l      a1, a0                                        ; $00CC08
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00CC0A
        clr.w        d4                                            ; $00CC0E
        move.b       (a0), d4                                      ; $00CC10
        lsl.w        #$3, d4                                       ; $00CC12
        lea.l        rTextureOrder(a6), a2                         ; $00CC14
        adda.w       d4, a2                                        ; $00CC18
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CC1A
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00CC1E
        add.w        rPlayerCellX(a6), d0                          ; $00CC22
        lsl.w        #$8, d0                                       ; $00CC26
        add.w        rPlayerCellY(a6), d1                          ; $00CC28
        lsl.w        #$8, d1                                       ; $00CC2C
        clr.w        d4                                            ; $00CC2E
        move.b       $1(a0), d4                                    ; $00CC30
        move.b       (a5, d4.w), d4                                ; $00CC34
        cmpi.b       #$1, d4                                       ; $00CC38
        beq.b        loc_00CC60                                    ; $00CC3C
        cmpi.b       #$3, d4                                       ; $00CC3E
        beq.b        loc_00CC60                                    ; $00CC42
        cmpi.b       #$4, d4                                       ; $00CC44
        beq.b        loc_00CC60                                    ; $00CC48
        cmpi.b       #$5, d4                                       ; $00CC4A
        beq.b        loc_00CC60                                    ; $00CC4E
        movem.w      d0-d1/d3, -(a7)                               ; $00CC50
        bsr.w        RenderWallEdgeY1                        ; $00CC54
        movem.w      (a7)+, d0-d1/d3                               ; $00CC58
        bra.w        RenderWallEdgeX1                        ; $00CC5C

loc_00CC60:
        bra.w        RenderWallEdgeY1                        ; $00CC60

TraceRayQuadrantFour:
; Top-level angle dispatcher enters here; this is not a fall-through from the Y probe.
        lea.l        RaySlopePairs(pc), a4                         ; $00CC64
        lsl.w        #$2, d0                                       ; $00CC68
        adda.w       d0, a4                                        ; $00CC6A
        move.w       #$ff, d7                                      ; $00CC6C
        clr.w        d0                                            ; $00CC70
        clr.w        d1                                            ; $00CC72
        movea.l      rPlayerCellPointer(a6), a0                    ; $00CC74
        clr.w        d3                                            ; $00CC78
        move.b       (a0), d3                                      ; $00CC7A
        move.b       (a5, d3.w), d3                                ; $00CC7C
        cmpi.b       #$4, d3                                       ; $00CC80
        beq.w        loc_00CF6E                                    ; $00CC84
        move.w       rPlayerCellFractionX(a6), d2                                ; $00CC88
        mulu.w       (a4), d2                                      ; $00CC8C
        lsr.l        #$8, d2                                       ; $00CC8E
        add.w        rPlayerCellFractionY(a6), d2                                ; $00CC90
        cmp.w        d7, d2                                        ; $00CC94
        bhi.b        loc_00CCA0                                    ; $00CC96
        cmpi.b       #$5, d3                                       ; $00CC98
        beq.w        loc_00D044                                    ; $00CC9C

loc_00CCA0:
        move.w       rPlayerCellFractionYComplement(a6), d6                                ; $00CCA0
        mulu.w       $2(a4), d6                                    ; $00CCA4
        lsr.l        #$8, d6                                       ; $00CCA8
        add.w        rPlayerCellFractionXComplement(a6), d6                                ; $00CCAA
        cmp.w        d7, d6                                        ; $00CCAE
        bhi.b        loc_00CCBA                                    ; $00CCB0
        cmpi.b       #$3, d3                                       ; $00CCB2
        beq.w        loc_00D0B4                                    ; $00CCB6

loc_00CCBA:
        move.w       d0, d4                                        ; $00CCBA
        move.w       d1, d5                                        ; $00CCBC
        movea.l      a0, a1                                        ; $00CCBE
        subq.w       #$1, a0                                       ; $00CCC0
        subq.w       #$1, d0                                       ; $00CCC2
        adda.w       #$20, a1                                      ; $00CCC4
        addq.w       #$1, d5                                       ; $00CCC8
        cmp.w        d7, d2                                        ; $00CCCA
        bls.b        loc_00CCDA                                    ; $00CCCC
        move.w       d2, d3                                        ; $00CCCE
        and.w        d7, d2                                        ; $00CCD0
        lsr.w        #$8, d3                                       ; $00CCD2
        add.w        d3, d1                                        ; $00CCD4
        lsl.w        #$5, d3                                       ; $00CCD6
        adda.w       d3, a0                                        ; $00CCD8

loc_00CCDA:
        cmp.w        d7, d6                                        ; $00CCDA
        bls.b        loc_00CCE8                                    ; $00CCDC
        move.w       d6, d3                                        ; $00CCDE
        and.w        d7, d6                                        ; $00CCE0
        lsr.w        #$8, d3                                       ; $00CCE2
        sub.w        d3, d4                                        ; $00CCE4
        suba.w       d3, a1                                        ; $00CCE6

loc_00CCE8:
        cmp.w        d4, d0                                        ; $00CCE8
        bgt.b        loc_00CCF2                                    ; $00CCEA
        blt.b        loc_00CD0C                                    ; $00CCEC
        cmp.w        d5, d1                                        ; $00CCEE
        bge.b        loc_00CD0C                                    ; $00CCF0

loc_00CCF2:
        cmp.w        rVisibleRayMinLocalX(a6), d0                                ; $00CCF2
        blt.b        loc_00CD26                                    ; $00CCF6
        cmp.w        rVisibleRayMaxLocalY(a6), d1                                ; $00CCF8
        bgt.b        loc_00CD26                                    ; $00CCFC
        move.b       (a0), d3                                      ; $00CCFE
        beq.b        loc_00CD08                                    ; $00CD00
        bsr.b        ProbeQuadrantFourXCell                        ; $00CD02
        bne.w        loc_00CDCE                                    ; $00CD04

loc_00CD08:
        bsr.b        RayStepQuadrantFourX                          ; $00CD08
        bra.b        loc_00CCE8                                    ; $00CD0A

loc_00CD0C:
        cmp.w        rVisibleRayMinLocalX(a6), d4                                ; $00CD0C
        blt.b        loc_00CD26                                    ; $00CD10
        cmp.w        rVisibleRayMaxLocalY(a6), d5                                ; $00CD12
        bgt.b        loc_00CD26                                    ; $00CD16
        move.b       (a1), d3                                      ; $00CD18
        beq.b        loc_00CD22                                    ; $00CD1A
        bsr.b        ProbeQuadrantFourYCell                        ; $00CD1C
        bne.w        loc_00CE30                                    ; $00CD1E

loc_00CD22:
        bsr.b        RayStepQuadrantFourY                          ; $00CD22
        bra.b        loc_00CCE8                                    ; $00CD24

loc_00CD26:
        rts                                                        ; $00CD26
        ifne *-$CD28
        fail "ROM end moved"
        endif
