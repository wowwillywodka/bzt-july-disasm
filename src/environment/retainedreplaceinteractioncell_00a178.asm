; $00A178..$00A1CF | m68k
; Maintained assembly input; no extraction occurs during build.
; The $A178 entry has no established ordinary caller. The second entry at
; $A1A4 is reached from TraceShotToDamageablePanel for source type $7F.
        ifne *-$A178
        fail "ROM start moved"
        endif

RetainedReplaceInteractionCell:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00A178
        bsr.w        MarkCellRenderStateAfterHit                     ; $00A17C
        cmpa.l       #$ffa5fa, a0                                  ; $00A180
        bcs.b        loc_00A190                                    ; $00A186
        cmpa.l       #$ffe5fa, a0                                  ; $00A188
        bcs.b        loc_00A196                                    ; $00A18E

loc_00A190:
        movea.l      #$ffa9fa, a0                                  ; $00A190

loc_00A196:
        move.b       rPanelType7ECellIndex(a6), (a0)                                ; $00A196
        jsr          CommitMapCellAndSendLink.l                    ; $00A19A
        bra.w        FinishDamageablePanelMutation                                    ; $00A1A0

loc_00A1A4:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00A1A4
        bsr.w        MarkCellRenderStateAfterHit                     ; $00A1A8
        cmpa.l       #$ffa5fa, a0                                  ; $00A1AC
        bcs.b        loc_00A1BC                                    ; $00A1B2
        cmpa.l       #$ffe5fa, a0                                  ; $00A1B4
        bcs.b        loc_00A1C2                                    ; $00A1BA

loc_00A1BC:
        movea.l      #$ffa9fa, a0                                  ; $00A1BC

loc_00A1C2:
        move.b       rPanelType80CellIndex(a6), (a0)                                ; $00A1C2
        jsr          CommitMapCellAndSendLink.l                    ; $00A1C6
        bra.w        FinishDamageablePanelMutation                                    ; $00A1CC
        ifne *-$A1D0
        fail "ROM end moved"
        endif
