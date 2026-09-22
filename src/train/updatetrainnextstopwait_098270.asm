; $098270..$0982C7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State 4, or ANY state on a different floor: decrement signed byte timer; on underflow advance route and set state 1/timer 0. Off-floor state 1 can advance again on the very next call.
        ifne *-$98270
        fail "ROM start moved"
        endif

UpdateTrainNextStopWait:
; State 4, or ANY state on a different floor: decrement signed byte timer; on underflow advance route and set state 1/timer 0. Off-floor state 1 can advance again on the very next call.
        subq.b       #$1, TrainTimer(a0)                           ; $098270
        bpl.w        loc_098318                                    ; $098274
        move.l       a0, -(a7)                                     ; $098278
        bsr.w        AdvanceTrainRoute                             ; $09827A
        movea.l      (a7)+, a0                                     ; $09827E
        move.b       #$1, TrainState(a0)                           ; $098280
        move.b       #$0, TrainTimer(a0)                           ; $098286
        move.b       TrainFloor(a0), d5                            ; $09828C
        cmp.b        rCurrentFloorLow(a6), d5                      ; $098290
        bne.w        loc_098318                                    ; $098294
        move.b       TrainOriginX(a0), d5                          ; $098298
        move.b       TrainOriginY(a0), d6                          ; $09829C
        ext.w        d5                                            ; $0982A0
        ext.w        d6                                            ; $0982A2
        mulu.w       rCurrentFloorWidth(a6), d6                    ; $0982A4
        add.w        d5, d6                                        ; $0982A8
        lea.l        rEpisodeMapCells(a6), a1                      ; $0982AA
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $0982AE
        adda.w       d6, a1                                        ; $0982B2
        move.b       TrainOrientation(a0), d0                      ; $0982B4
        bsr.w        WriteTrainAnimatedCells                       ; $0982B8
        lea.l        TrainArrivalTextureFrames(pc), a1             ; $0982BC
        bsr.w        ApplyTrainTextureStrip                        ; $0982C0
        bra.w        loc_098318                                    ; $0982C4
        ifne *-$982C8
        fail "ROM end moved"
        endif
