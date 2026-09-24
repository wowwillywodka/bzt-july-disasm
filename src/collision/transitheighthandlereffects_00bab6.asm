; $00BAB6..$00BB93 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Retained table targets. Boundary entries inspect the low
; X/Y byte, set height to +/-$40, and request a floor transition. None of the
; four episode type LUTs can select these targets without modification.
        ifne *-$BAB6
        fail "ROM start moved"
        endif

SetTransitHeightPositiveLimit:
        move.w       #$40, rTransitHeightOffset(a6)                              ; $00BAB6
        rts                                                        ; $00BABC

CheckTransitBoundaryXHighHalf:
        move.w       rPlayerX(a6), d0                              ; $00BABE
        cmpi.w       #$40, rTransitHeightOffset(a6)                              ; $00BAC2
        beq.b        loc_00BADA                                    ; $00BAC8
        tst.b        d0                                            ; $00BACA
        bpl.b        loc_00BAD8                                    ; $00BACC
        move.w       #$40, rTransitHeightOffset(a6)                              ; $00BACE
        bra.w        RequestHigherFloorTransition                  ; $00BAD4

loc_00BAD8:
        rts                                                        ; $00BAD8

loc_00BADA:
        tst.b        d0                                            ; $00BADA
        bmi.b        loc_00BAD8                                    ; $00BADC
        move.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BADE
        bra.w        RequestLowerFloorTransition                   ; $00BAE4

CheckTransitBoundaryXLowHalf:
        move.w       rPlayerX(a6), d0                              ; $00BAE8
        cmpi.w       #$40, rTransitHeightOffset(a6)                              ; $00BAEC
        beq.b        loc_00BB04                                    ; $00BAF2
        tst.b        d0                                            ; $00BAF4
        bmi.b        loc_00BB02                                    ; $00BAF6
        move.w       #$40, rTransitHeightOffset(a6)                              ; $00BAF8
        bra.w        RequestHigherFloorTransition                  ; $00BAFE

loc_00BB02:
        rts                                                        ; $00BB02

loc_00BB04:
        tst.b        d0                                            ; $00BB04
        bpl.b        loc_00BB02                                    ; $00BB06
        move.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BB08
        bra.w        RequestLowerFloorTransition                   ; $00BB0E

CheckTransitBoundaryYHighHalf:
        move.w       rPlayerY(a6), d0                              ; $00BB12
        cmpi.w       #$40, rTransitHeightOffset(a6)                              ; $00BB16
        beq.b        loc_00BB2E                                    ; $00BB1C
        tst.b        d0                                            ; $00BB1E
        bpl.b        loc_00BB2C                                    ; $00BB20
        move.w       #$40, rTransitHeightOffset(a6)                              ; $00BB22
        bra.w        RequestHigherFloorTransition                  ; $00BB28

loc_00BB2C:
        rts                                                        ; $00BB2C

loc_00BB2E:
        tst.b        d0                                            ; $00BB2E
        bmi.b        loc_00BB2C                                    ; $00BB30
        move.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BB32
        bra.w        RequestLowerFloorTransition                   ; $00BB38

CheckTransitBoundaryYLowHalf:
        move.w       rPlayerY(a6), d0                              ; $00BB3C
        cmpi.w       #$40, rTransitHeightOffset(a6)                              ; $00BB40
        beq.b        loc_00BB58                                    ; $00BB46
        tst.b        d0                                            ; $00BB48
        bmi.b        loc_00BB56                                    ; $00BB4A
        move.w       #$40, rTransitHeightOffset(a6)                              ; $00BB4C
        bra.w        RequestHigherFloorTransition                  ; $00BB52

loc_00BB56:
        rts                                                        ; $00BB56

loc_00BB58:
        tst.b        d0                                            ; $00BB58
        bpl.b        loc_00BB56                                    ; $00BB5A
        move.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BB5C
        bra.w        RequestLowerFloorTransition                   ; $00BB62

loc_00BB66:
        cmpi.b       #$33, d3                                      ; $00BB66
        beq.b        SettlePositiveTransitHeightAtCellBoundary                                    ; $00BB6A
        cmpi.b       #$52, d3                                      ; $00BB6C
        beq.b        SettlePositiveTransitHeightAtCellBoundary                                    ; $00BB70
        cmpi.b       #$56, d3                                      ; $00BB72
        beq.b        SettlePositiveTransitHeightAtCellBoundary                                    ; $00BB76
        cmpi.b       #$5a, d3                                      ; $00BB78
        beq.b        SettlePositiveTransitHeightAtCellBoundary                                    ; $00BB7C
        subq.w       #$4, rTransitHeightOffset(a6)                               ; $00BB7E
        cmpi.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BB82
        bge.b        loc_00BBD6                                    ; $00BB88
        move.w       #$40, rTransitHeightOffset(a6)                              ; $00BB8A
        bra.w        RequestHigherFloorTransition                  ; $00BB90
        ifne *-$BB94
        fail "ROM end moved"
        endif
