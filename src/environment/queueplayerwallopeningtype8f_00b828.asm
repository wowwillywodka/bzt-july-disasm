; $00B828..$00B865 | m68k
; Maintained assembly input; no extraction occurs during build.
; Cell interaction type $8F: queue a mode-0 opening using the type $92 cell index.
        ifne *-$B828
        fail "ROM start moved"
        endif

QueuePlayerWallOpeningType8F:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00B828
        cmpa.l       #$ff0fd0, a3                                  ; $00B82C
        beq.b        loc_00B864                                    ; $00B832
        move.l       a0, (a3)+                                     ; $00B834
        move.w       #$20, (a3)+                                   ; $00B836
        clr.w        d0                                            ; $00B83A
        move.b       (a0), d0                                      ; $00B83C
        move.w       d0, (a3)+                                     ; $00B83E
        cmpa.l       #$ffa5fa, a0                                  ; $00B840
        bcs.b        loc_00B850                                    ; $00B846
        cmpa.l       #$ffe5fa, a0                                  ; $00B848
        bcs.b        loc_00B856                                    ; $00B84E

loc_00B850:
        movea.l      #$ffa9fa, a0                                  ; $00B850

loc_00B856:
        move.b       rOpeningWallType92CellIndex(a6), (a0)                                ; $00B856
        jsr          CommitMapCellAndSendLink.l                    ; $00B85A
        bra.w        FinishPlayerWallOpeningRecord                 ; $00B860

loc_00B864:
        rts                                                        ; $00B864
        ifne *-$B866
        fail "ROM end moved"
        endif
