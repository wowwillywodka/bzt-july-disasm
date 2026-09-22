; $00A1D0..$00A203 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0/D1=fixed-point XY. Request types $79/$7B/$7D/$7F -> $7A/$7C/$7E/$80 through CellIndexByType and commit. All target types are absent in July, so actual replacement is raw cell 0. Not a generic wall hit-point routine.
        ifne *-$A1D0
        fail "ROM start moved"
        endif

DamagePanelCellAtPoint:
; D0/D1=fixed-point XY. Request types $79/$7B/$7D/$7F -> $7A/$7C/$7E/$80 through CellIndexByType and commit. All target types are absent in July, so actual replacement is raw cell 0. Not a generic wall hit-point routine.
        movea.l      rVisibleMapBasePointer(a6), a0                ; $00A1D0
        asr.w        #$8, d0                                       ; $00A1D4
        adda.w       d0, a0                                        ; $00A1D6
        clr.b        d1                                            ; $00A1D8
        asr.w        #$3, d1                                       ; $00A1DA
        adda.w       d1, a0                                        ; $00A1DC
        clr.w        d3                                            ; $00A1DE
        move.b       (a0), d3                                      ; $00A1E0
        lea.l        rCellTypeByIndex(a6), a5                      ; $00A1E2
        move.b       (a5, d3.w), d3                                ; $00A1E6
        cmpi.b       #$79, d3                                      ; $00A1EA
        beq.b        ObjectsRoutine_00A204                         ; $00A1EE
        cmpi.b       #$7b, d3                                      ; $00A1F0
        beq.b        loc_00A230                                    ; $00A1F4
        cmpi.b       #$7d, d3                                      ; $00A1F6
        beq.b        loc_00A254                                    ; $00A1FA
        cmpi.b       #$7f, d3                                      ; $00A1FC
        beq.b        loc_00A278                                    ; $00A200
        rts                                                        ; $00A202
        ifne *-$A204
        fail "ROM end moved"
        endif
