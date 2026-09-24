; $00C982..$00CB23 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Зонд клетки Y-луча (восходящий октант): celltype через (0,A5,D3), спецслучай type5 с тестом по (2,A4); своп банков D0-D4/A0-A1 вокруг 0x8b50 для ортогонального луча
        ifne *-$C982
        fail "ROM start moved"
        endif

ProbeQuadrantTwoYCell:
; A1 cell: class 5 uses D6+slopeY; >=6 dispatches with the cursor banks swapped.
        andi.w       #$ff, d3                                      ; $00C982
        move.b       (a5, d3.w), d3                                ; $00C986
        bne.b        loc_00C98E                                    ; $00C98A
        rts                                                        ; $00C98C

loc_00C98E:
        cmpi.b       #$6, d3                                       ; $00C98E
        bcc.b        loc_00C9A8                                    ; $00C992
        cmpi.b       #$5, d3                                       ; $00C994
        bne.b        loc_00C9A6                                    ; $00C998
        move.w       d6, d3                                        ; $00C99A
        add.w        $2(a4), d3                                    ; $00C99C
        cmp.w        d7, d3                                        ; $00C9A0
        bhi.b        loc_00C9C2                                    ; $00C9A2
        moveq        #$5, d3                                       ; $00C9A4

loc_00C9A6:
        rts                                                        ; $00C9A6

loc_00C9A8:
        exg.l        d0, d4                                        ; $00C9A8
        exg.l        d1, d5                                        ; $00C9AA
        exg.l        d2, d6                                        ; $00C9AC
        exg.l        a0, a1                                        ; $00C9AE
        bsr.w        DispatchVisibleCell                           ; $00C9B0
        exg.l        d0, d4                                        ; $00C9B4
        exg.l        d1, d5                                        ; $00C9B6
        exg.l        d2, d6                                        ; $00C9B8
        exg.l        a0, a1                                        ; $00C9BA
        tst.b        d3                                            ; $00C9BC
        bne.b        loc_00C98E                                    ; $00C9BE
        rts                                                        ; $00C9C0

loc_00C9C2:
        clr.w        d3                                            ; $00C9C2
        rts                                                        ; $00C9C4

loc_00C9C6:
        cmpa.l       rCurrentWallMapCellPointer(a6), a0                                ; $00C9C6
        beq.w        loc_00C91E                                    ; $00C9CA
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00C9CE
        clr.w        d4                                            ; $00C9D2
        move.b       (a0), d4                                      ; $00C9D4
        lsl.w        #$3, d4                                       ; $00C9D6
        lea.l        rTextureOrder(a6), a2                         ; $00C9D8
        adda.w       d4, a2                                        ; $00C9DC
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C9DE
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00C9E2
        add.w        rPlayerCellX(a6), d0                          ; $00C9E6
        lsl.w        #$8, d0                                       ; $00C9EA
        add.w        rPlayerCellY(a6), d1                          ; $00C9EC
        lsl.w        #$8, d1                                       ; $00C9F0
        clr.w        d4                                            ; $00C9F2
        move.b       $20(a0), d4                                   ; $00C9F4
        move.b       (a5, d4.w), d4                                ; $00C9F8
        cmpi.b       #$1, d4                                       ; $00C9FC
        beq.b        loc_00CA24                                    ; $00CA00
        cmpi.b       #$2, d4                                       ; $00CA02
        beq.b        loc_00CA24                                    ; $00CA06
        cmpi.b       #$4, d4                                       ; $00CA08
        beq.b        loc_00CA24                                    ; $00CA0C
        cmpi.b       #$5, d4                                       ; $00CA0E
        beq.b        loc_00CA24                                    ; $00CA12
        movem.w      d0-d1/d3, -(a7)                               ; $00CA14
        bsr.w        RenderWallEdgeX0                        ; $00CA18
        movem.w      (a7)+, d0-d1/d3                               ; $00CA1C
        bra.w        RenderWallEdgeY1                        ; $00CA20

loc_00CA24:
        bra.w        RenderWallEdgeX0                        ; $00CA24

loc_00CA28:
        cmpa.l       rCurrentWallMapCellPointer(a6), a1                                ; $00CA28
        beq.w        loc_00C91E                                    ; $00CA2C
        move.w       d4, d0                                        ; $00CA30
        move.w       d5, d1                                        ; $00CA32
        move.w       d6, d2                                        ; $00CA34
        movea.l      a1, a0                                        ; $00CA36
        move.l       a0, rCurrentWallMapCellPointer(a6)                                ; $00CA38
        clr.w        d4                                            ; $00CA3C
        move.b       (a0), d4                                      ; $00CA3E
        lsl.w        #$3, d4                                       ; $00CA40
        lea.l        rTextureOrder(a6), a2                         ; $00CA42
        adda.w       d4, a2                                        ; $00CA46
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CA48
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00CA4C
        add.w        rPlayerCellX(a6), d0                          ; $00CA50
        lsl.w        #$8, d0                                       ; $00CA54
        add.w        rPlayerCellY(a6), d1                          ; $00CA56
        lsl.w        #$8, d1                                       ; $00CA5A
        bra.w        RenderWallEdgeY1                        ; $00CA5C

TraceRayQuadrantThree:
; Top-level angle dispatcher enters here; this is not a fall-through from the Y probe.
        lea.l        RaySlopePairs(pc), a4                         ; $00CA60
        lsl.w        #$2, d0                                       ; $00CA64
        adda.w       d0, a4                                        ; $00CA66
        move.w       #$ff, d7                                      ; $00CA68
        clr.w        d0                                            ; $00CA6C
        clr.w        d1                                            ; $00CA6E
        movea.l      rPlayerCellPointer(a6), a0                    ; $00CA70
        clr.w        d3                                            ; $00CA74
        move.b       (a0), d3                                      ; $00CA76
        move.b       (a5, d3.w), d3                                ; $00CA78
        cmpi.b       #$5, d3                                       ; $00CA7C
        beq.w        loc_00D044                                    ; $00CA80
        move.w       rPlayerCellFractionX(a6), d2                                ; $00CA84
        mulu.w       (a4), d2                                      ; $00CA88
        lsr.l        #$8, d2                                       ; $00CA8A
        add.w        rPlayerCellFractionYComplement(a6), d2                                ; $00CA8C
        cmp.w        d7, d2                                        ; $00CA90
        bhi.b        loc_00CA9C                                    ; $00CA92
        cmpi.b       #$4, d3                                       ; $00CA94
        beq.w        loc_00CF6E                                    ; $00CA98

loc_00CA9C:
        move.w       rPlayerCellFractionY(a6), d6                                ; $00CA9C
        mulu.w       $2(a4), d6                                    ; $00CAA0
        lsr.l        #$8, d6                                       ; $00CAA4
        add.w        rPlayerCellFractionXComplement(a6), d6                                ; $00CAA6
        cmp.w        d7, d6                                        ; $00CAAA
        bhi.b        loc_00CAB6                                    ; $00CAAC
        cmpi.b       #$2, d3                                       ; $00CAAE
        beq.w        loc_00CFD8                                    ; $00CAB2

loc_00CAB6:
        move.w       d0, d4                                        ; $00CAB6
        move.w       d1, d5                                        ; $00CAB8
        movea.l      a0, a1                                        ; $00CABA
        subq.w       #$1, a0                                       ; $00CABC
        subq.w       #$1, d0                                       ; $00CABE
        suba.w       #$20, a1                                      ; $00CAC0
        subq.w       #$1, d5                                       ; $00CAC4
        cmp.w        d7, d2                                        ; $00CAC6
        bls.b        loc_00CAD6                                    ; $00CAC8
        move.w       d2, d3                                        ; $00CACA
        and.w        d7, d2                                        ; $00CACC
        lsr.w        #$8, d3                                       ; $00CACE
        sub.w        d3, d1                                        ; $00CAD0
        lsl.w        #$5, d3                                       ; $00CAD2
        suba.w       d3, a0                                        ; $00CAD4

loc_00CAD6:
        cmp.w        d7, d6                                        ; $00CAD6
        bls.b        loc_00CAE4                                    ; $00CAD8
        move.w       d6, d3                                        ; $00CADA
        and.w        d7, d6                                        ; $00CADC
        lsr.w        #$8, d3                                       ; $00CADE
        sub.w        d3, d4                                        ; $00CAE0
        suba.w       d3, a1                                        ; $00CAE2

loc_00CAE4:
        cmp.w        d4, d0                                        ; $00CAE4
        bgt.b        loc_00CAEE                                    ; $00CAE6
        blt.b        loc_00CB08                                    ; $00CAE8
        cmp.w        d5, d1                                        ; $00CAEA
        ble.b        loc_00CB08                                    ; $00CAEC

loc_00CAEE:
        cmp.w        rVisibleRayMinLocalX(a6), d0                                ; $00CAEE
        blt.b        loc_00CB22                                    ; $00CAF2
        cmp.w        rVisibleRayMinLocalY(a6), d1                                ; $00CAF4
        blt.b        loc_00CB22                                    ; $00CAF8
        move.b       (a0), d3                                      ; $00CAFA
        beq.b        loc_00CB04                                    ; $00CAFC
        bsr.b        ProbeQuadrantThreeXCell                        ; $00CAFE
        bne.w        loc_00CBCA                                    ; $00CB00

loc_00CB04:
        bsr.b        RayStepQuadrantThreeX                         ; $00CB04
        bra.b        loc_00CAE4                                    ; $00CB06

loc_00CB08:
        cmp.w        rVisibleRayMinLocalX(a6), d4                                ; $00CB08
        blt.b        loc_00CB22                                    ; $00CB0C
        cmp.w        rVisibleRayMinLocalY(a6), d5                                ; $00CB0E
        blt.b        loc_00CB22                                    ; $00CB12
        move.b       (a1), d3                                      ; $00CB14
        beq.b        loc_00CB1E                                    ; $00CB16
        bsr.b        ProbeQuadrantThreeYCell                        ; $00CB18
        bne.w        loc_00CBFA                                    ; $00CB1A

loc_00CB1E:
        bsr.b        RayStepQuadrantThreeY                         ; $00CB1E
        bra.b        loc_00CAE4                                    ; $00CB20

loc_00CB22:
        rts                                                        ; $00CB22
        ifne *-$CB24
        fail "ROM end moved"
        endif
