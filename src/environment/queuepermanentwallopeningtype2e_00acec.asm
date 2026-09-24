; $00ACEC..$00AD3B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; As QueuePermanentWallOpeningType2D, but inverse type $2E. A0/A1 are changed by the packed-render-state helper; D0/D1 survive it.
        ifne *-$ACEC
        fail "ROM start moved"
        endif

QueuePermanentWallOpeningType2E:
; As QueuePermanentWallOpeningType2D, but inverse type $2E. A0/A1 are changed by the packed-render-state helper; D0/D1 survive it.
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00ACEC
        cmpa.l       #$ff0fd0, a3                                  ; $00ACF0
        beq.b        loc_00AD3A                                    ; $00ACF6
        move.l       a0, (a3)+                                     ; $00ACF8
        move.w       #$20, (a3)+                                   ; $00ACFA
        clr.w        (a3)+                                         ; $00ACFE
        cmpa.l       #$ffa5fa, a0                                  ; $00AD00
        bcs.b        loc_00AD10                                    ; $00AD06
        cmpa.l       #$ffe5fa, a0                                  ; $00AD08
        bcs.b        loc_00AD16                                    ; $00AD0E

loc_00AD10:
        movea.l      #$ffa9fa, a0                                  ; $00AD10

loc_00AD16:
        move.b       rCellIndexForType2E(a6), (a0)                                ; $00AD16
        jsr          CommitMapCellAndSendLink.l                    ; $00AD1A
        jsr          GetCellRenderStateAddress.l                   ; $00AD20
        move.l       a0, d7                                        ; $00AD26
        andi.w       #$1, d7                                       ; $00AD28
        beq.b        loc_00AD34                                    ; $00AD2C
        andi.b       #$f0, (a1)                                    ; $00AD2E
        bra.b        loc_00AD38                                    ; $00AD32

loc_00AD34:
        andi.b       #$f, (a1)                                     ; $00AD34

loc_00AD38:
        bra.b        FinishPermanentWallOpeningRecord              ; $00AD38

loc_00AD3A:
        rts                                                        ; $00AD3A
        ifne *-$AD3C
        fail "ROM end moved"
        endif
