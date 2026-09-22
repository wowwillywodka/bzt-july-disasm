; $00A4E8..$00A527 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: isolated RTS then 1024-cell remap loop with table A528; no ordinary entry established
        ifne *-$A4E8
        fail "ROM start moved"
        endif

RetainedRewriteEpisodeCellTypes:
        rts                                                        ; $00A4E8
        lea.l        rVisibleMapWindow(a6), a0                     ; $00A4EA
        lsl.w        #$8, d0                                       ; $00A4EE
        lsl.w        #$2, d0                                       ; $00A4F0
        adda.w       d0, a0                                        ; $00A4F2
        move.w       #$3ff, d7                                     ; $00A4F4
        lea.l        rCellTypeByIndex(a6), a5                      ; $00A4F8
        lea.l        rCellIndexByType(a6), a2                      ; $00A4FC
        clr.w        d0                                            ; $00A500
        lea.l        RetainedEpisodeCellRemap(pc), a1              ; $00A502

loc_00A506:
        move.b       (a0), d0                                      ; $00A506
        move.b       (a5, d0.w), d0                                ; $00A508
        move.b       (a1, d0.w), d0                                ; $00A50C
        cmpi.b       #$ff, d0                                      ; $00A510
        beq.b        loc_00A520                                    ; $00A514
        move.b       (a2, d0.w), (a0)+                             ; $00A516
        dbra         d7, loc_00A506                                ; $00A51A
        rts                                                        ; $00A51E

loc_00A520:
        addq.w       #$1, a0                                       ; $00A520
        dbra         d7, loc_00A506                                ; $00A522
        rts                                                        ; $00A526
        ifne *-$A528
        fail "ROM end moved"
        endif
