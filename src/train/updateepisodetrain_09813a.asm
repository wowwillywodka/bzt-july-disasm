; $09813A..$098197 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Train loop once per gameplay iteration. Off-floor records bypass state dispatch and count down directly to next stop. No per-train actor or continuous world-space train movement.
        ifne *-$9813A
        fail "ROM start moved"
        endif

UpdateEpisodeTrain:
; Train loop once per gameplay iteration. Off-floor records bypass state dispatch and count down directly to next stop. No per-train actor or continuous world-space train movement.
        cmpi.w       #$3, rGeometryEpisode(a6)                     ; $09813A
        bne.w        loc_098322                                    ; $098140
        cmpi.w       #$ffff, rTrainLastSlotIndex(a6)               ; $098144
        beq.w        loc_098322                                    ; $09814A
        lea.l        rTrainRecords(a6), a0                         ; $09814E
        move.b       (a0), d0                                      ; $098152
        move.w       rTrainLastSlotIndex(a6), d7                   ; $098154

loc_098158:
        movem.l      d7/a0, -(a7)                                  ; $098158
        move.b       TrainFloor(a0), d3                            ; $09815C
        cmp.b        rCurrentFloorLow(a6), d3                      ; $098160
        bne.w        UpdateTrainNextStopWait                       ; $098164
        move.b       TrainState(a0), d1                            ; $098168
        cmpi.b       #$1, d1                                       ; $09816C
        beq.w        UpdateTrainArrival                            ; $098170
        cmpi.b       #$2, d1                                       ; $098174
        beq.w        UpdateTrainDockedWait                         ; $098178
        cmpi.b       #$3, d1                                       ; $09817C
        beq.w        UpdateTrainDeparture                          ; $098180
        cmpi.b       #$4, d1                                       ; $098184
        beq.w        UpdateTrainNextStopWait                       ; $098188
        cmpi.b       #$7, d1                                       ; $09818C
        beq.w        UpdateTrainPassengerRide                      ; $098190
; Unsupported same-floor state: original DBRA loops without restoring MOVEM or advancing A0, then falls through to arrival. Valid producers use states 1,2,3,4,7.
        dbra         d7, loc_098158                                ; $098194
        ifne *-$98198
        fail "ROM end moved"
        endif
