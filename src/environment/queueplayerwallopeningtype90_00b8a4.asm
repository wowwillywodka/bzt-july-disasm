; $00B8A4..$00B8E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; Cell interaction type $90: queue a mode-0 opening using the type $94 cell index.
        ifne *-$B8A4
        fail "ROM start moved"
        endif

QueuePlayerWallOpeningType90:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B8A4
        cmpa.l       #$ff0fd0, a3                                  ; $00B8A8
        beq.b        loc_00B8E0                                    ; $00B8AE
        move.l       a0, (a3)+                                     ; $00B8B0
        move.w       #$20, (a3)+                                   ; $00B8B2
        clr.w        d0                                            ; $00B8B6
        move.b       (a0), d0                                      ; $00B8B8
        move.w       d0, (a3)+                                     ; $00B8BA
        cmpa.l       #$ffa5fa, a0                                  ; $00B8BC
        bcs.b        loc_00B8CC                                    ; $00B8C2
        cmpa.l       #$ffe5fa, a0                                  ; $00B8C4
        bcs.b        loc_00B8D2                                    ; $00B8CA

loc_00B8CC:
        movea.l      #$ffa9fa, a0                                  ; $00B8CC

loc_00B8D2:
        move.b       rOpeningWallType94CellIndex(a6), (a0)                                ; $00B8D2
        jsr          CommitMapCellAndSendLink.l                    ; $00B8D6
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B8DC

loc_00B8E0:
        rts                                                        ; $00B8E0
        ifne *-$B8E2
        fail "ROM end moved"
        endif
