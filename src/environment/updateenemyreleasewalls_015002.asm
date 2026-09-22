; $015002..$01547F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Episode 0 only. Each active record advances a byte timer; every 8 calls replace raw cell by next group at $0149F0 and commit. Third change deactivates record and calls actor-pair spawn. Not radar.
        ifne *-$15002
        fail "ROM start moved"
        endif

UpdateEnemyReleaseWalls:
; Episode 0 only. Each active record advances a byte timer; every 8 calls replace raw cell by next group at $0149F0 and commit. Third change deactivates record and calls actor-pair spawn. Not radar.
        cmpi.w       #$0, rGeometryEpisode(a6)                     ; $015002
        beq.b        loc_01500C                                    ; $015008
        rts                                                        ; $01500A

loc_01500C:
        addq.b       #$1, rEnemyReleaseWallTicks(a6)               ; $01500C
        lea.l        rEpisode1CellRecords(a6), a0                  ; $015010
        clr.w        d7                                            ; $015014

loc_015016:
        cmpi.b       #$ff, WallStageTimer(a0)                      ; $015016
        beq.w        loc_015472                                    ; $01501C
        clr.w        d0                                            ; $015020
        addq.b       #$1, WallStageTimer(a0)                       ; $015022
        cmpi.b       #$8, WallStageTimer(a0)                       ; $015026
        bcs.w        loc_015472                                    ; $01502C
        move.b       #$0, WallStageTimer(a0)                       ; $015030
        movea.l      (a0), a1                                      ; $015036
        move.b       (a1), d0                                      ; $015038
        lea.l        DestructibleWallCellVariants(pc), a2          ; $01503A
        lea.l        Data_0149F8(pc), a3                           ; $01503E
        cmp.b        (a2), d0                                      ; $015042
        bne.b        loc_015056                                    ; $015044
        move.b       (a3), (a1)                                    ; $015046
        exg.l        a0, a1                                        ; $015048
        jsr          CommitMapCellAndSendLink.l                    ; $01504A
        exg.l        a0, a1                                        ; $015050
        bra.w        loc_015472                                    ; $015052

loc_015056:
        cmp.b        $4(a2), d0                                    ; $015056
        bne.b        loc_01506E                                    ; $01505A
        move.b       $4(a3), (a1)                                  ; $01505C
        exg.l        a0, a1                                        ; $015060
        jsr          CommitMapCellAndSendLink.l                    ; $015062
        exg.l        a0, a1                                        ; $015068
        bra.w        loc_015472                                    ; $01506A

loc_01506E:
        cmp.b        $1(a2), d0                                    ; $01506E
        bne.b        loc_015086                                    ; $015072
        move.b       $1(a3), (a1)                                  ; $015074
        exg.l        a0, a1                                        ; $015078
        jsr          CommitMapCellAndSendLink.l                    ; $01507A
        exg.l        a0, a1                                        ; $015080
        bra.w        loc_015472                                    ; $015082

loc_015086:
        cmp.b        $5(a2), d0                                    ; $015086
        bne.b        loc_01509E                                    ; $01508A
        move.b       $5(a3), (a1)                                  ; $01508C
        exg.l        a0, a1                                        ; $015090
        jsr          CommitMapCellAndSendLink.l                    ; $015092
        exg.l        a0, a1                                        ; $015098
        bra.w        loc_015472                                    ; $01509A

loc_01509E:
        cmp.b        $2(a2), d0                                    ; $01509E
        bne.b        loc_0150B6                                    ; $0150A2
        move.b       $2(a3), (a1)                                  ; $0150A4
        exg.l        a0, a1                                        ; $0150A8
        jsr          CommitMapCellAndSendLink.l                    ; $0150AA
        exg.l        a0, a1                                        ; $0150B0
        bra.w        loc_015472                                    ; $0150B2

loc_0150B6:
        cmp.b        $6(a2), d0                                    ; $0150B6
        bne.b        loc_0150CE                                    ; $0150BA
        move.b       $6(a3), (a1)                                  ; $0150BC
        exg.l        a0, a1                                        ; $0150C0
        jsr          CommitMapCellAndSendLink.l                    ; $0150C2
        exg.l        a0, a1                                        ; $0150C8
        bra.w        loc_015472                                    ; $0150CA

loc_0150CE:
        cmp.b        $3(a2), d0                                    ; $0150CE
        bne.b        loc_0150E6                                    ; $0150D2
        move.b       $3(a3), (a1)                                  ; $0150D4
        exg.l        a0, a1                                        ; $0150D8
        jsr          CommitMapCellAndSendLink.l                    ; $0150DA
        exg.l        a0, a1                                        ; $0150E0
        bra.w        loc_015472                                    ; $0150E2

loc_0150E6:
        cmp.b        $7(a2), d0                                    ; $0150E6
        bne.b        loc_0150FE                                    ; $0150EA
        move.b       $7(a3), (a1)                                  ; $0150EC
        exg.l        a0, a1                                        ; $0150F0
        jsr          CommitMapCellAndSendLink.l                    ; $0150F2
        exg.l        a0, a1                                        ; $0150F8
        bra.w        loc_015472                                    ; $0150FA

loc_0150FE:
        lea.l        Data_0149F8(pc), a2                           ; $0150FE
        lea.l        Data_014A00(pc), a3                           ; $015102
        cmp.b        (a2), d0                                      ; $015106
        bne.b        loc_01511A                                    ; $015108
        move.b       (a3), (a1)                                    ; $01510A
        exg.l        a0, a1                                        ; $01510C
        jsr          CommitMapCellAndSendLink.l                    ; $01510E
        exg.l        a0, a1                                        ; $015114
        bra.w        loc_015472                                    ; $015116

loc_01511A:
        cmp.b        $4(a2), d0                                    ; $01511A
        bne.b        loc_015132                                    ; $01511E
        move.b       $4(a3), (a1)                                  ; $015120
        exg.l        a0, a1                                        ; $015124
        jsr          CommitMapCellAndSendLink.l                    ; $015126
        exg.l        a0, a1                                        ; $01512C
        bra.w        loc_015472                                    ; $01512E

loc_015132:
        cmp.b        $1(a2), d0                                    ; $015132
        bne.b        loc_01514A                                    ; $015136
        move.b       $1(a3), (a1)                                  ; $015138
        exg.l        a0, a1                                        ; $01513C
        jsr          CommitMapCellAndSendLink.l                    ; $01513E
        exg.l        a0, a1                                        ; $015144
        bra.w        loc_015472                                    ; $015146

loc_01514A:
        cmp.b        $5(a2), d0                                    ; $01514A
        bne.b        loc_015162                                    ; $01514E
        move.b       $5(a3), (a1)                                  ; $015150
        exg.l        a0, a1                                        ; $015154
        jsr          CommitMapCellAndSendLink.l                    ; $015156
        exg.l        a0, a1                                        ; $01515C
        bra.w        loc_015472                                    ; $01515E

loc_015162:
        cmp.b        $2(a2), d0                                    ; $015162
        bne.b        loc_01517A                                    ; $015166
        move.b       $2(a3), (a1)                                  ; $015168
        exg.l        a0, a1                                        ; $01516C
        jsr          CommitMapCellAndSendLink.l                    ; $01516E
        exg.l        a0, a1                                        ; $015174
        bra.w        loc_015472                                    ; $015176

loc_01517A:
        cmp.b        $6(a2), d0                                    ; $01517A
        bne.b        loc_015192                                    ; $01517E
        move.b       $6(a3), (a1)                                  ; $015180
        exg.l        a0, a1                                        ; $015184
        jsr          CommitMapCellAndSendLink.l                    ; $015186
        exg.l        a0, a1                                        ; $01518C
        bra.w        loc_015472                                    ; $01518E

loc_015192:
        cmp.b        $3(a2), d0                                    ; $015192
        bne.b        loc_0151AA                                    ; $015196
        move.b       $3(a3), (a1)                                  ; $015198
        exg.l        a0, a1                                        ; $01519C
        jsr          CommitMapCellAndSendLink.l                    ; $01519E
        exg.l        a0, a1                                        ; $0151A4
        bra.w        loc_015472                                    ; $0151A6

loc_0151AA:
        cmp.b        $7(a2), d0                                    ; $0151AA
        bne.b        loc_0151C2                                    ; $0151AE
        move.b       $7(a3), (a1)                                  ; $0151B0
        exg.l        a0, a1                                        ; $0151B4
        jsr          CommitMapCellAndSendLink.l                    ; $0151B6
        exg.l        a0, a1                                        ; $0151BC
        bra.w        loc_015472                                    ; $0151BE

loc_0151C2:
        lea.l        Data_014A00(pc), a2                           ; $0151C2
        lea.l        Data_014A08(pc), a3                           ; $0151C6
        cmp.b        (a2), d0                                      ; $0151CA
        bne.b        loc_01521C                                    ; $0151CC
        move.b       (a3), (a1)                                    ; $0151CE
        exg.l        a0, a1                                        ; $0151D0
        jsr          CommitMapCellAndSendLink.l                    ; $0151D2
        exg.l        a0, a1                                        ; $0151D8
; Final cell stays type 1 (solid) in episode 0. Mark record idle, then spawn Blood Body or Stanan from $00A628/$00A64E depending on wall family.
        move.b       #$ff, WallStageTimer(a0)                      ; $0151DA
        move.b       WallStageCellX(a0), d0                        ; $0151E0
        move.b       WallStageCellY(a0), d1                        ; $0151E4
        lsl.w        #$8, d0                                       ; $0151E8
        lsl.w        #$8, d1                                       ; $0151EA
        move.w       d0, d3                                        ; $0151EC
        addi.w       #$40, d0                                      ; $0151EE
        subi.w       #$10, d1                                      ; $0151F2
        addi.w       #$c4, d3                                      ; $0151F6
        move.w       d1, d4                                        ; $0151FA
        move.l       a0, -(a7)                                     ; $0151FC
        movea.l      a1, a0                                        ; $0151FE
        clr.w        d2                                            ; $015200
        move.b       Data_00A640.l, d2                             ; $015202
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $015208
        jsr          SpawnWallReleasedActorPair.l                  ; $015210
        movea.l      (a7)+, a0                                     ; $015216
        bra.w        loc_015472                                    ; $015218

loc_01521C:
        cmp.b        $4(a2), d0                                    ; $01521C
        bne.b        loc_015272                                    ; $015220
        move.b       $4(a3), (a1)                                  ; $015222
        exg.l        a0, a1                                        ; $015226
        jsr          CommitMapCellAndSendLink.l                    ; $015228
        exg.l        a0, a1                                        ; $01522E
        move.b       #$ff, WallStageTimer(a0)                      ; $015230
        move.b       WallStageCellX(a0), d0                        ; $015236
        move.b       WallStageCellY(a0), d1                        ; $01523A
        lsl.w        #$8, d0                                       ; $01523E
        lsl.w        #$8, d1                                       ; $015240
        move.w       d0, d3                                        ; $015242
        addi.w       #$40, d0                                      ; $015244
        subi.w       #$10, d1                                      ; $015248
        addi.w       #$c4, d3                                      ; $01524C
        move.w       d1, d4                                        ; $015250
        move.l       a0, -(a7)                                     ; $015252
        movea.l      a1, a0                                        ; $015254
        clr.w        d2                                            ; $015256
        move.b       Data_00A666.l, d2                             ; $015258
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $01525E
        jsr          SpawnWallReleasedActorPair.l                  ; $015266
        movea.l      (a7)+, a0                                     ; $01526C
        bra.w        loc_015472                                    ; $01526E

loc_015272:
        cmp.b        $1(a2), d0                                    ; $015272
        bne.b        loc_0152C8                                    ; $015276
        move.b       $1(a3), (a1)                                  ; $015278
        exg.l        a0, a1                                        ; $01527C
        jsr          CommitMapCellAndSendLink.l                    ; $01527E
        exg.l        a0, a1                                        ; $015284
        move.b       #$ff, WallStageTimer(a0)                      ; $015286
        move.b       WallStageCellX(a0), d0                        ; $01528C
        move.b       WallStageCellY(a0), d1                        ; $015290
        lsl.w        #$8, d0                                       ; $015294
        lsl.w        #$8, d1                                       ; $015296
        move.w       d0, d3                                        ; $015298
        addi.w       #$40, d0                                      ; $01529A
        addi.w       #$110, d1                                     ; $01529E
        addi.w       #$c4, d3                                      ; $0152A2
        move.w       d1, d4                                        ; $0152A6
        move.l       a0, -(a7)                                     ; $0152A8
        movea.l      a1, a0                                        ; $0152AA
        clr.w        d2                                            ; $0152AC
        move.b       Data_00A640.l, d2                             ; $0152AE
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $0152B4
        jsr          SpawnWallReleasedActorPair.l                  ; $0152BC
        movea.l      (a7)+, a0                                     ; $0152C2
        bra.w        loc_015472                                    ; $0152C4

loc_0152C8:
        cmp.b        $5(a2), d0                                    ; $0152C8
        bne.b        loc_01531E                                    ; $0152CC
        move.b       $5(a3), (a1)                                  ; $0152CE
        exg.l        a0, a1                                        ; $0152D2
        jsr          CommitMapCellAndSendLink.l                    ; $0152D4
        exg.l        a0, a1                                        ; $0152DA
        move.b       #$ff, WallStageTimer(a0)                      ; $0152DC
        move.b       WallStageCellX(a0), d0                        ; $0152E2
        move.b       WallStageCellY(a0), d1                        ; $0152E6
        lsl.w        #$8, d0                                       ; $0152EA
        lsl.w        #$8, d1                                       ; $0152EC
        move.w       d0, d3                                        ; $0152EE
        addi.w       #$40, d0                                      ; $0152F0
        addi.w       #$110, d1                                     ; $0152F4
        addi.w       #$c4, d3                                      ; $0152F8
        move.w       d1, d4                                        ; $0152FC
        move.l       a0, -(a7)                                     ; $0152FE
        movea.l      a1, a0                                        ; $015300
        clr.w        d2                                            ; $015302
        move.b       Data_00A666.l, d2                             ; $015304
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $01530A
        jsr          SpawnWallReleasedActorPair.l                  ; $015312
        movea.l      (a7)+, a0                                     ; $015318
        bra.w        loc_015472                                    ; $01531A

loc_01531E:
        cmp.b        $2(a2), d0                                    ; $01531E
        bne.b        loc_015374                                    ; $015322
        move.b       $2(a3), (a1)                                  ; $015324
        exg.l        a0, a1                                        ; $015328
        jsr          CommitMapCellAndSendLink.l                    ; $01532A
        exg.l        a0, a1                                        ; $015330
        move.b       #$ff, WallStageTimer(a0)                      ; $015332
        move.b       WallStageCellX(a0), d0                        ; $015338
        move.b       WallStageCellY(a0), d1                        ; $01533C
        lsl.w        #$8, d0                                       ; $015340
        lsl.w        #$8, d1                                       ; $015342
        move.w       d1, d4                                        ; $015344
        addi.w       #$110, d0                                     ; $015346
        addi.w       #$40, d1                                      ; $01534A
        move.w       d0, d3                                        ; $01534E
        addi.w       #$c4, d4                                      ; $015350
        move.l       a0, -(a7)                                     ; $015354
        movea.l      a1, a0                                        ; $015356
        clr.w        d2                                            ; $015358
        move.b       Data_00A640.l, d2                             ; $01535A
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $015360
        jsr          SpawnWallReleasedActorPair.l                  ; $015368
        movea.l      (a7)+, a0                                     ; $01536E
        bra.w        loc_015472                                    ; $015370

loc_015374:
        cmp.b        $6(a2), d0                                    ; $015374
        bne.b        loc_0153CA                                    ; $015378
        move.b       $6(a3), (a1)                                  ; $01537A
        exg.l        a0, a1                                        ; $01537E
        jsr          CommitMapCellAndSendLink.l                    ; $015380
        exg.l        a0, a1                                        ; $015386
        move.b       #$ff, WallStageTimer(a0)                      ; $015388
        move.b       WallStageCellX(a0), d0                        ; $01538E
        move.b       WallStageCellY(a0), d1                        ; $015392
        lsl.w        #$8, d0                                       ; $015396
        lsl.w        #$8, d1                                       ; $015398
        move.w       d1, d4                                        ; $01539A
        addi.w       #$110, d0                                     ; $01539C
        addi.w       #$40, d1                                      ; $0153A0
        move.w       d0, d3                                        ; $0153A4
        addi.w       #$c4, d4                                      ; $0153A6
        move.l       a0, -(a7)                                     ; $0153AA
        movea.l      a1, a0                                        ; $0153AC
        clr.w        d2                                            ; $0153AE
        move.b       Data_00A666.l, d2                             ; $0153B0
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $0153B6
        jsr          SpawnWallReleasedActorPair.l                  ; $0153BE
        movea.l      (a7)+, a0                                     ; $0153C4
        bra.w        loc_015472                                    ; $0153C6

loc_0153CA:
        cmp.b        $3(a2), d0                                    ; $0153CA
        bne.b        loc_015420                                    ; $0153CE
        move.b       $3(a3), (a1)                                  ; $0153D0
        exg.l        a0, a1                                        ; $0153D4
        jsr          CommitMapCellAndSendLink.l                    ; $0153D6
        exg.l        a0, a1                                        ; $0153DC
        move.b       #$ff, WallStageTimer(a0)                      ; $0153DE
        move.b       WallStageCellX(a0), d0                        ; $0153E4
        move.b       WallStageCellY(a0), d1                        ; $0153E8
        lsl.w        #$8, d0                                       ; $0153EC
        lsl.w        #$8, d1                                       ; $0153EE
        move.w       d1, d4                                        ; $0153F0
        subi.w       #$10, d0                                      ; $0153F2
        addi.w       #$40, d1                                      ; $0153F6
        move.w       d0, d3                                        ; $0153FA
        addi.w       #$c4, d4                                      ; $0153FC
        move.l       a0, -(a7)                                     ; $015400
        movea.l      a1, a0                                        ; $015402
        clr.w        d2                                            ; $015404
        move.b       Data_00A640.l, d2                             ; $015406
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $01540C
        jsr          SpawnWallReleasedActorPair.l                  ; $015414
        movea.l      (a7)+, a0                                     ; $01541A
        bra.w        loc_015472                                    ; $01541C

loc_015420:
        cmp.b        $7(a2), d0                                    ; $015420
        bne.b        loc_015472                                    ; $015424
        move.b       $7(a3), (a1)                                  ; $015426
        exg.l        a0, a1                                        ; $01542A
        jsr          CommitMapCellAndSendLink.l                    ; $01542C
        exg.l        a0, a1                                        ; $015432
        move.b       #$ff, WallStageTimer(a0)                      ; $015434
        move.b       WallStageCellX(a0), d0                        ; $01543A
        move.b       WallStageCellY(a0), d1                        ; $01543E
        lsl.w        #$8, d0                                       ; $015442
        lsl.w        #$8, d1                                       ; $015444
        move.w       d1, d4                                        ; $015446
        subi.w       #$10, d0                                      ; $015448
        addi.w       #$40, d1                                      ; $01544C
        move.w       d0, d3                                        ; $015450
        addi.w       #$c4, d4                                      ; $015452
        move.l       a0, -(a7)                                     ; $015456
        movea.l      a1, a0                                        ; $015458
        clr.w        d2                                            ; $01545A
        move.b       Data_00A666.l, d2                             ; $01545C
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $015462
        jsr          SpawnWallReleasedActorPair.l                  ; $01546A
        movea.l      (a7)+, a0                                     ; $015470

loc_015472:
        addq.l       #$8, a0                                       ; $015472
        addq.w       #$1, d7                                       ; $015474
        cmpi.w       #$1e, d7                                      ; $015476
        bne.w        loc_015016                                    ; $01547A
        rts                                                        ; $01547E
        ifne *-$15480
        fail "ROM end moved"
        endif
