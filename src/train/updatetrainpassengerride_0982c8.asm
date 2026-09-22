; $0982C8..$098323 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State 7: shake each call; timer $90 sets a write-only arrival flag; timer $A5 writes docked cells and returns to state 2/$37. The player was transferred at boarding, not here.
        ifne *-$982C8
        fail "ROM start moved"
        endif

UpdateTrainPassengerRide:
; State 7: shake each call; timer $90 sets a write-only arrival flag; timer $A5 writes docked cells and returns to state 2/$37. The player was transferred at boarding, not here.
        bsr.w        ApplyTrainPassengerShake                      ; $0982C8
        addq.b       #$1, TrainTimer(a0)                           ; $0982CC
        cmpi.b       #$90, TrainTimer(a0)                          ; $0982D0
        bcs.b        loc_0982DE                                    ; $0982D6
        move.w       #$1, rTrainArrivalFlag(a6)                    ; $0982D8

loc_0982DE:
        cmpi.b       #$a5, TrainTimer(a0)                          ; $0982DE
        bne.w        loc_098318                                    ; $0982E4
        move.b       #$37, TrainTimer(a0)                          ; $0982E8
        move.b       #$2, TrainState(a0)                           ; $0982EE
        move.b       TrainOriginX(a0), d5                          ; $0982F4
        move.b       TrainOriginY(a0), d6                          ; $0982F8
        ext.w        d5                                            ; $0982FC
        ext.w        d6                                            ; $0982FE
        mulu.w       rCurrentFloorWidth(a6), d6                    ; $098300
        add.w        d5, d6                                        ; $098304
        lea.l        rEpisodeMapCells(a6), a1                      ; $098306
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $09830A
        adda.w       d6, a1                                        ; $09830E
        move.b       TrainOrientation(a0), d0                      ; $098310
        bsr.w        WriteTrainDockedCells                         ; $098314

loc_098318:
        movem.l      (a7)+, d7/a0                                  ; $098318
        addq.w       #$7, a0                                       ; $09831C
        dbra         d7, loc_098158                                ; $09831E

loc_098322:
        rts                                                        ; $098322
        ifne *-$98324
        fail "ROM end moved"
        endif
