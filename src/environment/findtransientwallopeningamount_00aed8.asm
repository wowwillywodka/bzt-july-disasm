; $00AED8..$00AEF9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=cell pointer. Scan 14-byte transient records, return word +4 in D3, else zero. Renderer consumes it as geometric opening amount.
        ifne *-$AED8
        fail "ROM start moved"
        endif

FindTransientWallOpeningAmount:
; A0=cell pointer. Scan 14-byte transient records, return word +4 in D3, else zero. Renderer consumes it as geometric opening amount.
        lea.l        rTransientCellRecords(a6), a3                 ; $00AED8
        cmpa.l       rTransientCellRecordsEnd(a6), a3              ; $00AEDC
        beq.b        loc_00AEF0                                    ; $00AEE0

loc_00AEE2:
        cmpa.l       (a3), a0                                      ; $00AEE2
        beq.b        loc_00AEF4                                    ; $00AEE4
        adda.w       #$e, a3                                       ; $00AEE6
        cmpa.l       rTransientCellRecordsEnd(a6), a3              ; $00AEEA
        bne.b        loc_00AEE2                                    ; $00AEEE

loc_00AEF0:
        clr.w        d3                                            ; $00AEF0
        rts                                                        ; $00AEF2

loc_00AEF4:
        move.w       WallRecordOpening(a3), d3                     ; $00AEF4
        rts                                                        ; $00AEF8
        ifne *-$AEFA
        fail "ROM end moved"
        endif
