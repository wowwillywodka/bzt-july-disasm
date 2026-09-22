; $00AE72..$00AEA9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Mode-0 shared tail: coordinates are player X/Y rounded down to a cell in fixed point; sound $5E and optional record packet.
        ifne *-$AE72
        fail "ROM start moved"
        endif

FinishPlayerWallOpeningRecord:
; Mode-0 shared tail: coordinates are player X/Y rounded down to a cell in fixed point; sound $5E and optional record packet.
        move.w       #$1, -$711e(a6)                               ; $00AE72
        move.w       rPlayerX(a6), d0                              ; $00AE78
        clr.b        d0                                            ; $00AE7C
        move.w       rPlayerY(a6), d1                              ; $00AE7E
        clr.b        d1                                            ; $00AE82
        move.w       d0, (a3)+                                     ; $00AE84
        move.w       d1, (a3)+                                     ; $00AE86
        move.b       #$0, (a3)+                                    ; $00AE88
        move.b       rCurrentFloorLow(a6), (a3)+                   ; $00AE8C
        move.w       #$5e, d0                                      ; $00AE90
        jsr          SoundRoutine_00DF84.l                         ; $00AE94
        move.l       a3, rTransientCellRecordsEnd(a6)              ; $00AE9A
        suba.w       #$e, a3                                       ; $00AE9E
        tst.w        rLinkRole(a6)                                 ; $00AEA2
        bne.b        SendTransientWallRecord                       ; $00AEA6
        rts                                                        ; $00AEA8
        ifne *-$AEAA
        fail "ROM end moved"
        endif
