; $0981EC..$09823F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State 2: signed byte countdown from $37 reaches -1 after 56 calls; check door obstruction/passenger before departure.
        ifne *-$981EC
        fail "ROM start moved"
        endif

UpdateTrainDockedWait:
; State 2: signed byte countdown from $37 reaches -1 after 56 calls; check door obstruction/passenger before departure.
        subq.b       #$1, TrainTimer(a0)                           ; $0981EC
        bpl.w        loc_098318                                    ; $0981F0
        move.b       #$3, TrainState(a0)                           ; $0981F4
        move.b       #$0, TrainTimer(a0)                           ; $0981FA
        jsr          CheckTrainBoarding.l                          ; $098200
        cmpi.b       #$3, TrainState(a0)                           ; $098206
        bne.w        loc_098318                                    ; $09820C
        move.b       TrainOriginX(a0), d5                          ; $098210
        move.b       TrainOriginY(a0), d6                          ; $098214
        ext.w        d5                                            ; $098218
        ext.w        d6                                            ; $09821A
        mulu.w       rCurrentFloorWidth(a6), d6                    ; $09821C
        add.w        d5, d6                                        ; $098220
        lea.l        rEpisodeMapCells(a6), a1                      ; $098222
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $098226
        adda.w       d6, a1                                        ; $09822A
        move.b       TrainOrientation(a0), d0                      ; $09822C
        bsr.w        WriteTrainAnimatedCells                       ; $098230
        lea.l        TrainDepartureTextureFrames(pc), a1           ; $098234
        bsr.w        ApplyTrainTextureStrip                        ; $098238
        bra.w        loc_098318                                    ; $09823C
        ifne *-$98240
        fail "ROM end moved"
        endif
