; $098240..$09826F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State 3: 23 texture rows, then state 4/timer $37. Departure row zero was already applied by the state-2 transition.
        ifne *-$98240
        fail "ROM start moved"
        endif

UpdateTrainDeparture:
; State 3: 23 texture rows, then state 4/timer $37. Departure row zero was already applied by the state-2 transition.
        move.b       TrainTimer(a0), d2                            ; $098240
        ext.w        d2                                            ; $098244
        lsl.w        #$3, d2                                       ; $098246
        lea.l        TrainDepartureTextureFrames(pc), a1           ; $098248
        adda.w       d2, a1                                        ; $09824C
        bsr.w        ApplyTrainTextureStrip                        ; $09824E
        addq.b       #$1, TrainTimer(a0)                           ; $098252
        cmpi.b       #$17, TrainTimer(a0)                          ; $098256
        bne.w        loc_098318                                    ; $09825C
        move.b       #$4, TrainState(a0)                           ; $098260
        move.b       #$37, TrainTimer(a0)                          ; $098266
        bra.w        loc_098318                                    ; $09826C
        ifne *-$98270
        fail "ROM end moved"
        endif
