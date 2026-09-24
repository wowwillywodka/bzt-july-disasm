; $00A0C6..$00A11F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Nine forward samples with direction/4 step, stop on nonzero $01C772 collision result. Types $79/$7B/$7F select damaged replacements; July lacks the target types, so inverse lookup yields raw cell 0. Five firing-path callers.
        ifne *-$A0C6
        fail "ROM start moved"
        endif

TraceShotToDamageablePanel:
; Nine forward samples with direction/4 step, stop on nonzero $01C772 collision result. Types $79/$7B/$7F select damaged replacements; July lacks the target types, so inverse lookup yields raw cell 0. Five firing-path callers.
        move.w       rPlayerX(a6), d0                              ; $00A0C6
        move.w       rPlayerY(a6), d1                              ; $00A0CA
        move.w       rPlayerFacingVectorX(a6), d5                                ; $00A0CE
        move.w       rPlayerFacingVectorY(a6), d6                                ; $00A0D2
        asr.w        #$2, d5                                       ; $00A0D6
        asr.w        #$2, d6                                       ; $00A0D8
        move.w       #$8, d7                                       ; $00A0DA

loc_00A0DE:
        add.w        d5, d0                                        ; $00A0DE
        add.w        d6, d1                                        ; $00A0E0
        jsr          TestProjectilePointInVisibleMap.l             ; $00A0E2
        bne.b        loc_00A0F0                                    ; $00A0E8
        dbra         d7, loc_00A0DE                                ; $00A0EA
        rts                                                        ; $00A0EE

loc_00A0F0:
        movea.l      rVisibleMapBasePointer(a6), a0                ; $00A0F0
        asr.w        #$8, d0                                       ; $00A0F4
        adda.w       d0, a0                                        ; $00A0F6
        clr.b        d1                                            ; $00A0F8
        asr.w        #$3, d1                                       ; $00A0FA
        adda.w       d1, a0                                        ; $00A0FC
        clr.w        d3                                            ; $00A0FE
        move.b       (a0), d3                                      ; $00A100
        lea.l        rCellTypeByIndex(a6), a5                      ; $00A102
        move.b       (a5, d3.w), d3                                ; $00A106
        cmpi.b       #$79, d3                                      ; $00A10A
        beq.b        ReplaceShotPanelType79                         ; $00A10E
        cmpi.b       #$7b, d3                                      ; $00A110
        beq.b        ReplaceShotPanelType7B                                    ; $00A114
        cmpi.b       #$7f, d3                                      ; $00A116
        beq.w        loc_00A1A4                                    ; $00A11A
        rts                                                        ; $00A11E
        ifne *-$A120
        fail "ROM end moved"
        endif
