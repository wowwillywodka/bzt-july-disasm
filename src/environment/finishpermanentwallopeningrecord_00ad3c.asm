; $00AD3C..$00AD5F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shared tail: mode 2, current floor and coordinates; publish queue tail, optionally send link command $0A. Not sound or an actor render record.
        ifne *-$AD3C
        fail "ROM start moved"
        endif

FinishPermanentWallOpeningRecord:
; Shared tail: mode 2, current floor and coordinates; publish queue tail, optionally send link command $0A. Not sound or an actor render record.
        move.w       #$1, rWallChangeRefreshFlag(a6)                               ; $00AD3C
        move.w       d0, (a3)+                                     ; $00AD42
        move.w       d1, (a3)+                                     ; $00AD44
        move.b       #$2, (a3)+                                    ; $00AD46
        move.b       rCurrentFloorLow(a6), (a3)+                   ; $00AD4A
        move.l       a3, rTransientCellRecordsEnd(a6)              ; $00AD4E
        suba.w       #$e, a3                                       ; $00AD52
        tst.w        rLinkRole(a6)                                 ; $00AD56
        bne.w        SendTransientWallRecord                       ; $00AD5A
        rts                                                        ; $00AD5E
        ifne *-$AD60
        fail "ROM end moved"
        endif
