; $00AC9C..$00ACEB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=cell; D0/D1=record coordinates. Enqueue 14-byte mode-2 opening, amount $20, final byte 0; replace cell by inverse type $2D, commit and clear packed render nibble. Full 16-record queue returns without a success flag.
        ifne *-$AC9C
        fail "ROM start moved"
        endif

QueuePermanentWallOpeningType2D:
; A0=cell; D0/D1=record coordinates. Enqueue 14-byte mode-2 opening, amount $20, final byte 0; replace cell by inverse type $2D, commit and clear packed render nibble. Full 16-record queue returns without a success flag.
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00AC9C
        cmpa.l       #$ff0fd0, a3                                  ; $00ACA0
        beq.b        loc_00ACEA                                    ; $00ACA6
        move.l       a0, (a3)+                                     ; $00ACA8
        move.w       #$20, (a3)+                                   ; $00ACAA
        clr.w        (a3)+                                         ; $00ACAE
        cmpa.l       #$ffa5fa, a0                                  ; $00ACB0
        bcs.b        loc_00ACC0                                    ; $00ACB6
        cmpa.l       #$ffe5fa, a0                                  ; $00ACB8
        bcs.b        loc_00ACC6                                    ; $00ACBE

loc_00ACC0:
        movea.l      #$ffa9fa, a0                                  ; $00ACC0

loc_00ACC6:
        move.b       $c17(a6), (a0)                                ; $00ACC6
        jsr          CommitMapCellAndSendLink.l                    ; $00ACCA
        jsr          GetCellRenderStateAddress.l                   ; $00ACD0
        move.l       a0, d7                                        ; $00ACD6
        andi.w       #$1, d7                                       ; $00ACD8
        beq.b        loc_00ACE4                                    ; $00ACDC
        andi.b       #$f0, (a1)                                    ; $00ACDE
        bra.b        loc_00ACE8                                    ; $00ACE2

loc_00ACE4:
        andi.b       #$f, (a1)                                     ; $00ACE4

loc_00ACE8:
        bra.b        FinishPermanentWallOpeningRecord              ; $00ACE8

loc_00ACEA:
        rts                                                        ; $00ACEA
        ifne *-$ACEC
        fail "ROM end moved"
        endif
