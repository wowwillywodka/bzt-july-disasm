; $00BB96..$00BBE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Active motion/transition tail reached from DispatchTransitHeight.
        ifne *-$BB96
        fail "ROM start moved"
        endif

SettlePositiveTransitHeightAtCellBoundary:
        subq.w       #$4, rTransitHeightOffset(a6)                               ; $00BB96
        bpl.b        loc_00BBD6                                    ; $00BB9A
        move.w       #$2, rTransitDirectionState(a6)                               ; $00BB9C
        clr.w        rTransitHeightOffset(a6)                                    ; $00BBA2
        rts                                                        ; $00BBA6

loc_00BBA8:
        cmpi.b       #$32, d3                                      ; $00BBA8
        beq.b        loc_00BBD8                                    ; $00BBAC
        cmpi.b       #$51, d3                                      ; $00BBAE
        beq.b        loc_00BBD8                                    ; $00BBB2
        cmpi.b       #$55, d3                                      ; $00BBB4
        beq.b        loc_00BBD8                                    ; $00BBB8
        cmpi.b       #$59, d3                                      ; $00BBBA
        beq.b        loc_00BBD8                                    ; $00BBBE
        addq.w       #$4, rTransitHeightOffset(a6)                               ; $00BBC0
        cmpi.w       #$40, rTransitHeightOffset(a6)                              ; $00BBC4
        ble.b        loc_00BBD6                                    ; $00BBCA
        move.w       #$ffc0, rTransitHeightOffset(a6)                            ; $00BBCC
        bra.w        RequestLowerFloorTransition                   ; $00BBD2

loc_00BBD6:
        rts                                                        ; $00BBD6

loc_00BBD8:
        addq.w       #$4, rTransitHeightOffset(a6)                               ; $00BBD8
        bmi.b        loc_00BBD6                                    ; $00BBDC
        move.w       #$fffe, rTransitDirectionState(a6)                            ; $00BBDE
        clr.w        rTransitHeightOffset(a6)                                    ; $00BBE4
        rts                                                        ; $00BBE8
        ifne *-$BBEA
        fail "ROM end moved"
        endif
