; $00F1D2..$00F215 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Cell-interaction table entry; advances transit direction and clears height offset.
        ifne *-$F1D2
        fail "ROM start moved"
        endif

FinishCellTransitMotion:
        cmpi.w       #$42, rCurrentSoundSequenceId(a6)                              ; $00F1D2
        bne.b        loc_00F1F6                                    ; $00F1D8
        movem.l      d0-d7/a0-a5, -(a7)                            ; $00F1DA
        jsr          PlayPendingSequence.l                         ; $00F1DE
        move.w       rLegacyEpisodeSelection(a6), d0               ; $00F1E4
        addi.w       #$45, d0                                      ; $00F1E8
        jsr          StoreCurrentSoundSequenceAndPlayEvent.l                                  ; $00F1EC
        movem.l      (a7)+, d0-d7/a0-a5                            ; $00F1F2

loc_00F1F6:
        tst.w        rTransitDirectionState(a6)                                    ; $00F1F6
        beq.b        loc_00F204                                    ; $00F1FA
        bmi.b        loc_00F20A                                    ; $00F1FC
        move.w       #$2, rTransitDirectionState(a6)                               ; $00F1FE

loc_00F204:
        clr.w        rTransitHeightOffset(a6)                                    ; $00F204
        rts                                                        ; $00F208

loc_00F20A:
        move.w       #$fffe, rTransitDirectionState(a6)                            ; $00F20A
        clr.w        rTransitHeightOffset(a6)                                    ; $00F210
        rts                                                        ; $00F214
        ifne *-$F216
        fail "ROM end moved"
        endif
