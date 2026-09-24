; $00ADFA..$00AE35 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Player interaction: remember old cell byte, replace by inverse type $2D; mode 0 later restores the old byte after occupancy clears.
        ifne *-$ADFA
        fail "ROM start moved"
        endif

QueuePlayerWallOpeningType2D:
; Player interaction: remember old cell byte, replace by inverse type $2D; mode 0 later restores the old byte after occupancy clears.
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00ADFA
        cmpa.l       #$ff0fd0, a3                                  ; $00ADFE
        beq.b        loc_00AE34                                    ; $00AE04
        move.l       a0, (a3)+                                     ; $00AE06
        move.w       #$20, (a3)+                                   ; $00AE08
        clr.w        d0                                            ; $00AE0C
        move.b       (a0), d0                                      ; $00AE0E
        move.w       d0, (a3)+                                     ; $00AE10
        cmpa.l       #$ffa5fa, a0                                  ; $00AE12
        bcs.b        loc_00AE22                                    ; $00AE18
        cmpa.l       #$ffe5fa, a0                                  ; $00AE1A
        bcs.b        loc_00AE28                                    ; $00AE20

loc_00AE22:
        movea.l      #$ffa9fa, a0                                  ; $00AE22

loc_00AE28:
        move.b       rCellIndexForType2D(a6), (a0)                                ; $00AE28
        jsr          CommitMapCellAndSendLink.l                    ; $00AE2C
        bra.b        FinishPlayerWallOpeningRecord                 ; $00AE32

loc_00AE34:
        rts                                                        ; $00AE34
        ifne *-$AE36
        fail "ROM end moved"
        endif
