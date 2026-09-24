; $00B7EA..$00B827 | m68k
; Maintained assembly input; no extraction occurs during build.
; Cell interaction type $8D: queue a mode-0 opening using the type $91 cell index.
        ifne *-$B7EA
        fail "ROM start moved"
        endif

QueuePlayerWallOpeningType8D:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B7EA
        cmpa.l       #$ff0fd0, a3                                  ; $00B7EE
        beq.b        loc_00B826                                    ; $00B7F4
        move.l       a0, (a3)+                                     ; $00B7F6
        move.w       #$20, (a3)+                                   ; $00B7F8
        clr.w        d0                                            ; $00B7FC
        move.b       (a0), d0                                      ; $00B7FE
        move.w       d0, (a3)+                                     ; $00B800
        cmpa.l       #$ffa5fa, a0                                  ; $00B802
        bcs.b        loc_00B812                                    ; $00B808
        cmpa.l       #$ffe5fa, a0                                  ; $00B80A
        bcs.b        loc_00B818                                    ; $00B810

loc_00B812:
        movea.l      #$ffa9fa, a0                                  ; $00B812

loc_00B818:
        move.b       rOpeningWallType91CellIndex(a6), (a0)                                ; $00B818
        jsr          CommitMapCellAndSendLink.l                    ; $00B81C
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B822

loc_00B826:
        rts                                                        ; $00B826
        ifne *-$B828
        fail "ROM end moved"
        endif
