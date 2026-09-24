; $098876..$098943 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Accepted cabin side: seal source face, set state 7 and flags, advance route, transform global player position/angle, select destination floor/window, seal destination face.
        ifne *-$98876
        fail "ROM start moved"
        endif

BoardTrainAndTransferPlayer:
; Accepted cabin side: seal source face, set state 7 and flags, advance route, transform global player position/angle, select destination floor/window, seal destination face.
        ext.w        d2                                            ; $098876
        ext.w        d3                                            ; $098878
        mulu.w       rCurrentFloorWidth(a6), d3                    ; $09887A
        add.w        d2, d3                                        ; $09887E
        lea.l        rEpisodeMapCells(a6), a1                      ; $098880
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $098884
; A1 derives from D2/D3 after subtracting 2 along the train axis. WriteTrainSealedCells adds its own +12 offset again: source write is displaced by +12 along the axis and +/-1 across. Preserve this actual origin contract.
        adda.w       d3, a1                                        ; $098888
        move.b       TrainOrientation(a0), d0                      ; $09888A
        movem.l      d7/a0, -(a7)                                  ; $09888E
        bsr.w        WriteTrainSealedCells                         ; $098892
        movem.l      (a7)+, d7/a0                                  ; $098896
        move.w       #$1, rTrainPassengerFlag(a6)                  ; $09889A
        move.b       #$7, TrainState(a0)                           ; $0988A0
        move.b       #$0, TrainTimer(a0)                           ; $0988A6
        move.w       #$0, rTrainArrivalFlag(a6)                    ; $0988AC
        move.b       rPlayerX(a6), d0                              ; $0988B2
        move.b       rPlayerY(a6), d1                              ; $0988B6
        add.b        rMapWindowOriginXLow(a6), d0                                ; $0988BA
        add.b        rMapWindowOriginYLow(a6), d1                                ; $0988BE
        sub.b        TrainOriginX(a0), d0                          ; $0988C2
        sub.b        TrainOriginY(a0), d1                          ; $0988C6
        lsl.w        #$8, d0                                       ; $0988CA
        lsl.w        #$8, d1                                       ; $0988CC
        move.b       rPlayerXLow(a6), d0                                ; $0988CE
        move.b       rPlayerYLow(a6), d1                                ; $0988D2
        move.b       TrainOrientation(a0), d2                      ; $0988D6
        movem.l      d0-d2/d7/a0, -(a7)                            ; $0988DA
        bsr.w        AdvanceTrainRoute                             ; $0988DE
        movem.l      (a7)+, d0-d2/d7/a0                            ; $0988E2
        move.b       rPlayerXLow(a6), d3                                ; $0988E6
        move.b       rPlayerYLow(a6), d4                                ; $0988EA
        move.b       TrainOrientation(a0), d5                      ; $0988EE
        jsr          TransformTrainPassengerPosition.l             ; $0988F2
        move.w       d3, rPlayerX(a6)                              ; $0988F8
        move.w       d4, rPlayerY(a6)                              ; $0988FC
        move.b       TrainFloor(a0), d0                            ; $098900
        ext.w        d0                                            ; $098904
        move.w       d0, rCurrentFloor(a6)                         ; $098906
        move.w       rPlayerX(a6), d2                              ; $09890A
        move.w       rPlayerY(a6), d3                              ; $09890E
        movem.l      d7/a0, -(a7)                                  ; $098912
; SetPlayerMapOrigin gets destination GLOBAL fixed-point XY. Existing rebase-input issue is described in EPISODE_GEOMETRY.md; this call does not run normal floor-transition inventory/actor/UI cleanup.
        jsr          SetPlayerMapOrigin(pc)                        ; $098916
        movem.l      (a7)+, d7/a0                                  ; $09891A
        move.b       TrainOriginX(a0), d5                          ; $09891E
        move.b       TrainOriginY(a0), d6                          ; $098922
        ext.w        d5                                            ; $098926
        ext.w        d6                                            ; $098928
        mulu.w       rCurrentFloorWidth(a6), d6                    ; $09892A
        add.w        d5, d6                                        ; $09892E
        lea.l        rEpisodeMapCells(a6), a1                      ; $098930
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $098934
        adda.w       d6, a1                                        ; $098938
        move.b       TrainOrientation(a0), d0                      ; $09893A
; Final face writer leaves A0 at the extracted-map source end. The enclosing state-2 check at $098206 reads +5 through that clobbered pointer; common loop tail later restores the train record.
        bsr.w        WriteTrainSealedCells                         ; $09893E
        rts                                                        ; $098942
        ifne *-$98944
        fail "ROM end moved"
        endif
