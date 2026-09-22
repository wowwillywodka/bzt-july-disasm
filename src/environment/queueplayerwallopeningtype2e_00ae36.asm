; $00AE36..$00AE71 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Player interaction: remember old cell byte, replace by inverse type $2E; mode 0 is reversible opening, unlike mode 2.
        ifne *-$AE36
        fail "ROM start moved"
        endif

QueuePlayerWallOpeningType2E:
; Player interaction: remember old cell byte, replace by inverse type $2E; mode 0 is reversible opening, unlike mode 2.
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00AE36
        cmpa.l       #$ff0fd0, a3                                  ; $00AE3A
        beq.b        loc_00AE70                                    ; $00AE40
        move.l       a0, (a3)+                                     ; $00AE42
        move.w       #$20, (a3)+                                   ; $00AE44
        clr.w        d0                                            ; $00AE48
        move.b       (a0), d0                                      ; $00AE4A
        move.w       d0, (a3)+                                     ; $00AE4C
        cmpa.l       #$ffa5fa, a0                                  ; $00AE4E
        bcs.b        loc_00AE5E                                    ; $00AE54
        cmpa.l       #$ffe5fa, a0                                  ; $00AE56
        bcs.b        loc_00AE64                                    ; $00AE5C

loc_00AE5E:
        movea.l      #$ffa9fa, a0                                  ; $00AE5E

loc_00AE64:
        move.b       $c18(a6), (a0)                                ; $00AE64
        jsr          CommitMapCellAndSendLink.l                    ; $00AE68
        bra.b        FinishPlayerWallOpeningRecord                 ; $00AE6E

loc_00AE70:
        rts                                                        ; $00AE70
        ifne *-$AE72
        fail "ROM end moved"
        endif
