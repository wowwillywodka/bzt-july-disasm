; $098198..$0981EB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State 1: 23 eight-texture rows, then docked cells and state 2/timer $37. Texture IDs overwrite all four faces of cells $DA..$E1.
        ifne *-$98198
        fail "ROM start moved"
        endif

UpdateTrainArrival:
; State 1: 23 eight-texture rows, then docked cells and state 2/timer $37. Texture IDs overwrite all four faces of cells $DA..$E1.
        move.b       TrainTimer(a0), d2                            ; $098198
        ext.w        d2                                            ; $09819C
        lsl.w        #$3, d2                                       ; $09819E
        lea.l        TrainArrivalTextureFrames(pc), a1             ; $0981A0
        adda.w       d2, a1                                        ; $0981A4
        bsr.w        ApplyTrainTextureStrip                        ; $0981A6
        addq.b       #$1, TrainTimer(a0)                           ; $0981AA
        cmpi.b       #$17, TrainTimer(a0)                          ; $0981AE
        bne.w        loc_098318                                    ; $0981B4
        move.b       #$37, TrainTimer(a0)                          ; $0981B8
        move.b       #$2, TrainState(a0)                           ; $0981BE
        move.b       TrainOriginX(a0), d5                          ; $0981C4
        move.b       TrainOriginY(a0), d6                          ; $0981C8
        ext.w        d5                                            ; $0981CC
        ext.w        d6                                            ; $0981CE
        mulu.w       rCurrentFloorWidth(a6), d6                    ; $0981D0
        add.w        d5, d6                                        ; $0981D4
        lea.l        rEpisodeMapCells(a6), a1                      ; $0981D6
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $0981DA
        adda.w       d6, a1                                        ; $0981DE
        move.b       TrainOrientation(a0), d0                      ; $0981E0
        bsr.w        WriteTrainDockedCells                         ; $0981E4
        bra.w        loc_098318                                    ; $0981E8
        ifne *-$981EC
        fail "ROM end moved"
        endif
