; $00B866..$00B8A3 | m68k
; Maintained assembly input; no extraction occurs during build.
; Cell interaction type $8E: queue a mode-0 opening using the type $93 cell index.
        ifne *-$B866
        fail "ROM start moved"
        endif

QueuePlayerWallOpeningType8E:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B866
        cmpa.l       #$ff0fd0, a3                                  ; $00B86A
        beq.b        loc_00B8A2                                    ; $00B870
        move.l       a0, (a3)+                                     ; $00B872
        move.w       #$20, (a3)+                                   ; $00B874
        clr.w        d0                                            ; $00B878
        move.b       (a0), d0                                      ; $00B87A
        move.w       d0, (a3)+                                     ; $00B87C
        cmpa.l       #$ffa5fa, a0                                  ; $00B87E
        bcs.b        loc_00B88E                                    ; $00B884
        cmpa.l       #$ffe5fa, a0                                  ; $00B886
        bcs.b        loc_00B894                                    ; $00B88C

loc_00B88E:
        movea.l      #$ffa9fa, a0                                  ; $00B88E

loc_00B894:
        move.b       rOpeningWallType93CellIndex(a6), (a0)                                ; $00B894
        jsr          CommitMapCellAndSendLink.l                    ; $00B898
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B89E

loc_00B8A2:
        rts                                                        ; $00B8A2
        ifne *-$B8A4
        fail "ROM end moved"
        endif
