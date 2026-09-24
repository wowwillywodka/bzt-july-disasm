; $00A120..$00A177 | m68k
; Maintained assembly input; no extraction occurs during build.
; Shot-trace entries for source types $79 and $7B. A0 is the visible-map cell.
; Update render state, write the inverse-lookup result for $7A/$7C, commit the cell,
; then join the shared sound/cooldown tail at $A298. No actor is allocated.
        ifne *-$A120
        fail "ROM start moved"
        endif

ReplaceShotPanelType79:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00A120
        bsr.w        CountAndClearObjectiveCellRenderState                     ; $00A124
        cmpa.l       #$ffa5fa, a0                                  ; $00A128
        bcs.b        loc_00A138                                    ; $00A12E
        cmpa.l       #$ffe5fa, a0                                  ; $00A130
        bcs.b        loc_00A13E                                    ; $00A136

loc_00A138:
        movea.l      #$ffa9fa, a0                                  ; $00A138

loc_00A13E:
        move.b       rPanelType7ACellIndex(a6), (a0)                                ; $00A13E
        jsr          CommitMapCellAndSendLink.l                    ; $00A142
        bra.w        FinishDamageablePanelMutation                                    ; $00A148

ReplaceShotPanelType7B:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00A14C
        bsr.w        MarkCellRenderStateAfterHit                     ; $00A150
        cmpa.l       #$ffa5fa, a0                                  ; $00A154
        bcs.b        loc_00A164                                    ; $00A15A
        cmpa.l       #$ffe5fa, a0                                  ; $00A15C
        bcs.b        loc_00A16A                                    ; $00A162

loc_00A164:
        movea.l      #$ffa9fa, a0                                  ; $00A164

loc_00A16A:
        move.b       rPanelType7CCellIndex(a6), (a0)                                ; $00A16A
        jsr          CommitMapCellAndSendLink.l                    ; $00A16E
        bra.w        FinishDamageablePanelMutation                                    ; $00A174
        ifne *-$A178
        fail "ROM end moved"
        endif
