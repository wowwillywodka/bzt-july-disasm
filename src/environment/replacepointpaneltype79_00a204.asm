; $00A204..$00A2B1 | m68k
; Maintained assembly input; no extraction occurs during build.
; Point-hit entries for source types $79/$7B/$7D/$7F. A0 is the visible-map cell.
; Write inverse-lookup results for $7A/$7C/$7E/$80 and commit each change.
; These paths do not allocate actors; all join the same sound/cooldown tail.
        ifne *-$A204
        fail "ROM start moved"
        endif

ReplacePointPanelType79:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00A204
        bsr.w        CountAndClearObjectiveCellRenderState                     ; $00A208
        cmpa.l       #$ffa5fa, a0                                  ; $00A20C
        bcs.b        loc_00A21C                                    ; $00A212
        cmpa.l       #$ffe5fa, a0                                  ; $00A214
        bcs.b        loc_00A222                                    ; $00A21A

loc_00A21C:
        movea.l      #$ffa9fa, a0                                  ; $00A21C

loc_00A222:
        move.b       rPanelType7ACellIndex(a6), (a0)                                ; $00A222
        jsr          CommitMapCellAndSendLink.l                    ; $00A226
        bra.w        FinishDamageablePanelMutation                                    ; $00A22C

ReplacePointPanelType7B:
        cmpa.l       #$ffa5fa, a0                                  ; $00A230
        bcs.b        loc_00A240                                    ; $00A236
        cmpa.l       #$ffe5fa, a0                                  ; $00A238
        bcs.b        loc_00A246                                    ; $00A23E

loc_00A240:
        movea.l      #$ffa9fa, a0                                  ; $00A240

loc_00A246:
        move.b       rPanelType7CCellIndex(a6), (a0)                                ; $00A246
        jsr          CommitMapCellAndSendLink.l                    ; $00A24A
        bra.w        FinishDamageablePanelMutation                                    ; $00A250

ReplacePointPanelType7D:
        cmpa.l       #$ffa5fa, a0                                  ; $00A254
        bcs.b        loc_00A264                                    ; $00A25A
        cmpa.l       #$ffe5fa, a0                                  ; $00A25C
        bcs.b        loc_00A26A                                    ; $00A262

loc_00A264:
        movea.l      #$ffa9fa, a0                                  ; $00A264

loc_00A26A:
        move.b       rPanelType7ECellIndex(a6), (a0)                                ; $00A26A
        jsr          CommitMapCellAndSendLink.l                    ; $00A26E
        bra.w        FinishDamageablePanelMutation                                    ; $00A274

ReplacePointPanelType7F:
        cmpa.l       #$ffa5fa, a0                                  ; $00A278
        bcs.b        loc_00A288                                    ; $00A27E
        cmpa.l       #$ffe5fa, a0                                  ; $00A280
        bcs.b        loc_00A28E                                    ; $00A286

loc_00A288:
        movea.l      #$ffa9fa, a0                                  ; $00A288

loc_00A28E:
        move.b       rPanelType80CellIndex(a6), (a0)                                ; $00A28E
        jsr          CommitMapCellAndSendLink.l                    ; $00A292

FinishDamageablePanelMutation:
        clr.w        rStatusSoundScriptActive(a6)                                    ; $00A298
        clr.w        rSoundEffectCooldown(a6)                                    ; $00A29C
        move.w       #$2a, d0                                      ; $00A2A0
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $00A2A4
        move.w       #$14, rSoundEffectCooldown(a6)                              ; $00A2AA
        rts                                                        ; $00A2B0
        ifne *-$A2B2
        fail "ROM end moved"
        endif
