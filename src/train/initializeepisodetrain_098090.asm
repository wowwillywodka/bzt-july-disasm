; $098090..$098139 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; July episode index 3 only. Build seven-byte records from contiguous train-ID groups, not one train per stop. TrainLastSlotIndex is count minus one. See docs/TRAIN.md.
        ifne *-$98090
        fail "ROM start moved"
        endif

InitializeEpisodeTrain:
; July episode index 3 only. Build seven-byte records from contiguous train-ID groups, not one train per stop. TrainLastSlotIndex is count minus one. See docs/TRAIN.md.
        cmpi.w       #$3, rGeometryEpisode(a6)                     ; $098090
        bne.w        loc_098138                                    ; $098096
        movea.l      rEpisodeGeometryRom(a6), a0                   ; $09809A
        adda.w       rTrainRouteRomOffset(a6), a0                  ; $09809E
        move.l       a0, rTrainRouteTable(a6)                      ; $0980A2
        lea.l        rTrainRecords(a6), a1                         ; $0980A6
        move.w       (a0)+, d0                                     ; $0980AA
        subq.w       #$1, d0                                       ; $0980AC
        move.w       #$ffff, rTrainLastSlotIndex(a6)               ; $0980AE
        move.b       #$ff, d1                                      ; $0980B4

loc_0980B8:
; Only adjacent equal IDs are coalesced. Zero route count has no guard before the first read. Active July table contains two groups and seven stops.
        move.b       (a0)+, d2                                     ; $0980B8
        cmp.b        d1, d2                                        ; $0980BA
        beq.b        loc_0980E4                                    ; $0980BC
        cmpi.b       #$ff, d2                                      ; $0980BE
        beq.b        loc_0980EA                                    ; $0980C2
        move.b       d2, d1                                        ; $0980C4
        move.b       d2, (a1)+                                     ; $0980C6
        move.b       (a0)+, (a1)+                                  ; $0980C8
        move.b       (a0)+, (a1)+                                  ; $0980CA
        move.b       (a0)+, (a1)+                                  ; $0980CC
        move.b       (a0)+, (a1)+                                  ; $0980CE
        move.b       #$1, (a1)+                                    ; $0980D0
        move.b       #$0, (a1)+                                    ; $0980D4
        addq.w       #$1, rTrainLastSlotIndex(a6)                  ; $0980D8
        dbra         d0, loc_0980B8                                ; $0980DC
        bra.w        loc_0980EA                                    ; $0980E0

loc_0980E4:
        addq.w       #$4, a0                                       ; $0980E4
        dbra         d0, loc_0980B8                                ; $0980E6

loc_0980EA:
        lea.l        rTrainRecords(a6), a0                         ; $0980EA
        move.w       rTrainLastSlotIndex(a6), d0                   ; $0980EE
        bmi.b        loc_098138                                    ; $0980F2

loc_0980F4:
        move.b       rCurrentFloorLow(a6), d1                      ; $0980F4
        cmp.b        TrainFloor(a0), d1                            ; $0980F8
        bne.b        loc_098132                                    ; $0980FC
        move.b       #$37, TrainTimer(a0)                          ; $0980FE
        move.b       #$2, TrainState(a0)                           ; $098104
        move.b       TrainOriginX(a0), d5                          ; $09810A
        move.b       TrainOriginY(a0), d6                          ; $09810E
        ext.w        d5                                            ; $098112
        ext.w        d6                                            ; $098114
        mulu.w       rCurrentFloorWidth(a6), d6                    ; $098116
        add.w        d5, d6                                        ; $09811A
        lea.l        rEpisodeMapCells(a6), a1                      ; $09811C
        adda.w       rCurrentFloorMapOffset(a6), a1                ; $098120
        adda.w       d6, a1                                        ; $098124
        move.w       d0, -(a7)                                     ; $098126
        move.b       TrainOrientation(a0), d0                      ; $098128
        bsr.w        WriteTrainDockedCells                         ; $09812C
        move.w       (a7)+, d0                                     ; $098130

loc_098132:
; WriteTrainDockedCells calls ExtractVisibleMapWindow, which clobbers A0. This initializer does not restore the train-record pointer before its next iteration; preserved original defect.
        addq.w       #$7, a0                                       ; $098132
        dbra         d0, loc_0980F4                                ; $098134

loc_098138:
        rts                                                        ; $098138
        ifne *-$9813A
        fail "ROM end moved"
        endif
