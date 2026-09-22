; $014AE6..$015001 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ring of thirty 8-byte enemy-release wall records. Reusing a live slot may finalize its former cell before enqueueing the new one; no pointer deduplication. Not radar graphics.
        ifne *-$14AE6
        fail "ROM start moved"
        endif

QueueEnemyReleaseWall:
; Ring of thirty 8-byte enemy-release wall records. Reusing a live slot may finalize its former cell before enqueueing the new one; no pointer deduplication. Not radar graphics.
        lea.l        rEpisode1CellRecords(a6), a1                  ; $014AE6
        clr.w        d0                                            ; $014AEA
        move.b       rEnemyReleaseWallCursor(a6), d0               ; $014AEC
        lsl.w        #$3, d0                                       ; $014AF0
        lea.l        (a1, d0.w), a1                                ; $014AF2
        cmpi.b       #$ff, WallStageTimer(a1)                      ; $014AF6
        beq.w        loc_014FD4                                    ; $014AFC
        movea.l      (a1), a2                                      ; $014B00
        lea.l        Data_014A08(pc), a3                           ; $014B02
        cmpi.b       #$0, WallStageTimer(a1)                       ; $014B06
        bne.w        loc_014D72                                    ; $014B0C
        lea.l        Data_0149F8(pc), a4                           ; $014B10
        move.b       (a2), d0                                      ; $014B14
        cmp.b        (a4), d0                                      ; $014B16
        bne.w        loc_014B5E                                    ; $014B18
        move.b       (a3), (a2)                                    ; $014B1C
        exg.l        a0, a2                                        ; $014B1E
        jsr          CommitMapCellAndSendLink.l                    ; $014B20
        exg.l        a0, a2                                        ; $014B26
        move.b       WallStageCellX(a1), d0                        ; $014B28
        move.b       WallStageCellY(a1), d1                        ; $014B2C
        lsl.w        #$8, d0                                       ; $014B30
        lsl.w        #$8, d1                                       ; $014B32
        move.w       d0, d3                                        ; $014B34
        addi.w       #$40, d0                                      ; $014B36
        subi.w       #$10, d1                                      ; $014B3A
        addi.w       #$c4, d3                                      ; $014B3E
        move.w       d1, d4                                        ; $014B42
        clr.w        d2                                            ; $014B44
        move.b       Data_00A640.l, d2                             ; $014B46
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014B4C
        jsr          SpawnWallReleasedActorPair.l                  ; $014B54
        bra.w        loc_014FD4                                    ; $014B5A

loc_014B5E:
        cmp.b        $4(a4), d0                                    ; $014B5E
        bne.w        loc_014BAA                                    ; $014B62
        move.b       $4(a3), (a2)                                  ; $014B66
        exg.l        a0, a2                                        ; $014B6A
        jsr          CommitMapCellAndSendLink.l                    ; $014B6C
        exg.l        a0, a2                                        ; $014B72
        move.b       WallStageCellX(a1), d0                        ; $014B74
        move.b       WallStageCellY(a1), d1                        ; $014B78
        lsl.w        #$8, d0                                       ; $014B7C
        lsl.w        #$8, d1                                       ; $014B7E
        move.w       d0, d3                                        ; $014B80
        addi.w       #$40, d0                                      ; $014B82
        subi.w       #$10, d1                                      ; $014B86
        addi.w       #$c4, d3                                      ; $014B8A
        move.w       d1, d4                                        ; $014B8E
        clr.w        d2                                            ; $014B90
        move.b       Data_00A666.l, d2                             ; $014B92
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014B98
        jsr          SpawnWallReleasedActorPair.l                  ; $014BA0
        bra.w        loc_014FD4                                    ; $014BA6

loc_014BAA:
        cmp.b        $1(a4), d0                                    ; $014BAA
        bne.w        loc_014BF6                                    ; $014BAE
        move.b       $1(a3), (a2)                                  ; $014BB2
        exg.l        a0, a2                                        ; $014BB6
        jsr          CommitMapCellAndSendLink.l                    ; $014BB8
        exg.l        a0, a2                                        ; $014BBE
        move.b       WallStageCellX(a1), d0                        ; $014BC0
        move.b       WallStageCellY(a1), d1                        ; $014BC4
        lsl.w        #$8, d0                                       ; $014BC8
        lsl.w        #$8, d1                                       ; $014BCA
        move.w       d0, d3                                        ; $014BCC
        addi.w       #$40, d0                                      ; $014BCE
        addi.w       #$110, d1                                     ; $014BD2
        addi.w       #$c4, d3                                      ; $014BD6
        move.w       d1, d4                                        ; $014BDA
        clr.w        d2                                            ; $014BDC
        move.b       Data_00A640.l, d2                             ; $014BDE
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014BE4
        jsr          SpawnWallReleasedActorPair.l                  ; $014BEC
        bra.w        loc_014FD4                                    ; $014BF2

loc_014BF6:
        cmp.b        $5(a4), d0                                    ; $014BF6
        bne.w        loc_014C42                                    ; $014BFA
        move.b       $5(a3), (a2)                                  ; $014BFE
        exg.l        a0, a2                                        ; $014C02
        jsr          CommitMapCellAndSendLink.l                    ; $014C04
        exg.l        a0, a2                                        ; $014C0A
        move.b       WallStageCellX(a1), d0                        ; $014C0C
        move.b       WallStageCellY(a1), d1                        ; $014C10
        lsl.w        #$8, d0                                       ; $014C14
        lsl.w        #$8, d1                                       ; $014C16
        move.w       d0, d3                                        ; $014C18
        addi.w       #$40, d0                                      ; $014C1A
        addi.w       #$110, d1                                     ; $014C1E
        addi.w       #$c4, d3                                      ; $014C22
        move.w       d1, d4                                        ; $014C26
        clr.w        d2                                            ; $014C28
        move.b       Data_00A666.l, d2                             ; $014C2A
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014C30
        jsr          SpawnWallReleasedActorPair.l                  ; $014C38
        bra.w        loc_014FD4                                    ; $014C3E

loc_014C42:
        cmp.b        $2(a4), d0                                    ; $014C42
        bne.w        loc_014C8E                                    ; $014C46
        move.b       $2(a3), (a2)                                  ; $014C4A
        exg.l        a0, a2                                        ; $014C4E
        jsr          CommitMapCellAndSendLink.l                    ; $014C50
        exg.l        a0, a2                                        ; $014C56
        move.b       WallStageCellX(a1), d0                        ; $014C58
        move.b       WallStageCellY(a1), d1                        ; $014C5C
        lsl.w        #$8, d0                                       ; $014C60
        lsl.w        #$8, d1                                       ; $014C62
        move.w       d1, d4                                        ; $014C64
        addi.w       #$110, d0                                     ; $014C66
        addi.w       #$40, d1                                      ; $014C6A
        move.w       d0, d3                                        ; $014C6E
        addi.w       #$c4, d4                                      ; $014C70
        clr.w        d2                                            ; $014C74
        move.b       Data_00A640.l, d2                             ; $014C76
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014C7C
        jsr          SpawnWallReleasedActorPair.l                  ; $014C84
        bra.w        loc_014FD4                                    ; $014C8A

loc_014C8E:
        cmp.b        $6(a4), d0                                    ; $014C8E
        bne.w        loc_014CDA                                    ; $014C92
        move.b       $6(a3), (a2)                                  ; $014C96
        exg.l        a0, a2                                        ; $014C9A
        jsr          CommitMapCellAndSendLink.l                    ; $014C9C
        exg.l        a0, a2                                        ; $014CA2
        move.b       WallStageCellX(a1), d0                        ; $014CA4
        move.b       WallStageCellY(a1), d1                        ; $014CA8
        lsl.w        #$8, d0                                       ; $014CAC
        lsl.w        #$8, d1                                       ; $014CAE
        move.w       d1, d4                                        ; $014CB0
        addi.w       #$110, d0                                     ; $014CB2
        addi.w       #$40, d1                                      ; $014CB6
        move.w       d0, d3                                        ; $014CBA
        addi.w       #$c4, d4                                      ; $014CBC
        clr.w        d2                                            ; $014CC0
        move.b       Data_00A666.l, d2                             ; $014CC2
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014CC8
        jsr          SpawnWallReleasedActorPair.l                  ; $014CD0
        bra.w        loc_014FD4                                    ; $014CD6

loc_014CDA:
        cmp.b        $3(a4), d0                                    ; $014CDA
        bne.w        loc_014D26                                    ; $014CDE
        move.b       $3(a3), (a2)                                  ; $014CE2
        exg.l        a0, a2                                        ; $014CE6
        jsr          CommitMapCellAndSendLink.l                    ; $014CE8
        exg.l        a0, a2                                        ; $014CEE
        move.b       WallStageCellX(a1), d0                        ; $014CF0
        move.b       WallStageCellY(a1), d1                        ; $014CF4
        lsl.w        #$8, d0                                       ; $014CF8
        lsl.w        #$8, d1                                       ; $014CFA
        move.w       d1, d4                                        ; $014CFC
        subi.w       #$10, d0                                      ; $014CFE
        addi.w       #$40, d1                                      ; $014D02
        move.w       d0, d3                                        ; $014D06
        addi.w       #$c4, d4                                      ; $014D08
        clr.w        d2                                            ; $014D0C
        move.b       Data_00A640.l, d2                             ; $014D0E
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014D14
        jsr          SpawnWallReleasedActorPair.l                  ; $014D1C
        bra.w        loc_014FD4                                    ; $014D22

loc_014D26:
        cmp.b        $7(a4), d0                                    ; $014D26
        bne.w        loc_014FD4                                    ; $014D2A
        move.b       $7(a3), (a2)                                  ; $014D2E
        exg.l        a0, a2                                        ; $014D32
        jsr          CommitMapCellAndSendLink.l                    ; $014D34
        exg.l        a0, a2                                        ; $014D3A
        move.b       WallStageCellX(a1), d0                        ; $014D3C
        move.b       WallStageCellY(a1), d1                        ; $014D40
        lsl.w        #$8, d0                                       ; $014D44
        lsl.w        #$8, d1                                       ; $014D46
        move.w       d1, d4                                        ; $014D48
        subi.w       #$10, d0                                      ; $014D4A
        addi.w       #$40, d1                                      ; $014D4E
        move.w       d0, d3                                        ; $014D52
        addi.w       #$c4, d4                                      ; $014D54
        clr.w        d2                                            ; $014D58
        move.b       Data_00A666.l, d2                             ; $014D5A
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014D60
        jsr          SpawnWallReleasedActorPair.l                  ; $014D68
        bra.w        loc_014FD4                                    ; $014D6E

loc_014D72:
        lea.l        Data_014A00(pc), a4                           ; $014D72
        move.b       (a2), d0                                      ; $014D76
        cmp.b        (a4), d0                                      ; $014D78
        bne.w        loc_014DC0                                    ; $014D7A
        move.b       (a3), (a2)                                    ; $014D7E
        exg.l        a0, a2                                        ; $014D80
        jsr          CommitMapCellAndSendLink.l                    ; $014D82
        exg.l        a0, a2                                        ; $014D88
        move.b       WallStageCellX(a1), d0                        ; $014D8A
        move.b       WallStageCellY(a1), d1                        ; $014D8E
        lsl.w        #$8, d0                                       ; $014D92
        lsl.w        #$8, d1                                       ; $014D94
        move.w       d0, d3                                        ; $014D96
        addi.w       #$40, d0                                      ; $014D98
        subi.w       #$10, d1                                      ; $014D9C
        addi.w       #$c4, d3                                      ; $014DA0
        move.w       d1, d4                                        ; $014DA4
        clr.w        d2                                            ; $014DA6
        move.b       Data_00A640.l, d2                             ; $014DA8
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014DAE
        jsr          SpawnWallReleasedActorPair.l                  ; $014DB6
        bra.w        loc_014FD4                                    ; $014DBC

loc_014DC0:
        cmp.b        $4(a4), d0                                    ; $014DC0
        bne.w        loc_014E0C                                    ; $014DC4
        move.b       $4(a3), (a2)                                  ; $014DC8
        exg.l        a0, a2                                        ; $014DCC
        jsr          CommitMapCellAndSendLink.l                    ; $014DCE
        exg.l        a0, a2                                        ; $014DD4
        move.b       WallStageCellX(a1), d0                        ; $014DD6
        move.b       WallStageCellY(a1), d1                        ; $014DDA
        lsl.w        #$8, d0                                       ; $014DDE
        lsl.w        #$8, d1                                       ; $014DE0
        move.w       d0, d3                                        ; $014DE2
        addi.w       #$40, d0                                      ; $014DE4
        subi.w       #$10, d1                                      ; $014DE8
        addi.w       #$c4, d3                                      ; $014DEC
        move.w       d1, d4                                        ; $014DF0
        clr.w        d2                                            ; $014DF2
        move.b       Data_00A666.l, d2                             ; $014DF4
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014DFA
        jsr          SpawnWallReleasedActorPair.l                  ; $014E02
        bra.w        loc_014FD4                                    ; $014E08

loc_014E0C:
        cmp.b        $1(a4), d0                                    ; $014E0C
        bne.w        loc_014E58                                    ; $014E10
        move.b       $1(a3), (a2)                                  ; $014E14
        exg.l        a0, a2                                        ; $014E18
        jsr          CommitMapCellAndSendLink.l                    ; $014E1A
        exg.l        a0, a2                                        ; $014E20
        move.b       WallStageCellX(a1), d0                        ; $014E22
        move.b       WallStageCellY(a1), d1                        ; $014E26
        lsl.w        #$8, d0                                       ; $014E2A
        lsl.w        #$8, d1                                       ; $014E2C
        move.w       d0, d3                                        ; $014E2E
        addi.w       #$40, d0                                      ; $014E30
        addi.w       #$110, d1                                     ; $014E34
        addi.w       #$c4, d3                                      ; $014E38
        move.w       d1, d4                                        ; $014E3C
        clr.w        d2                                            ; $014E3E
        move.b       Data_00A640.l, d2                             ; $014E40
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014E46
        jsr          SpawnWallReleasedActorPair.l                  ; $014E4E
        bra.w        loc_014FD4                                    ; $014E54

loc_014E58:
        cmp.b        $5(a4), d0                                    ; $014E58
        bne.w        loc_014EA4                                    ; $014E5C
        move.b       $5(a3), (a2)                                  ; $014E60
        exg.l        a0, a2                                        ; $014E64
        jsr          CommitMapCellAndSendLink.l                    ; $014E66
        exg.l        a0, a2                                        ; $014E6C
        move.b       WallStageCellX(a1), d0                        ; $014E6E
        move.b       WallStageCellY(a1), d1                        ; $014E72
        lsl.w        #$8, d0                                       ; $014E76
        lsl.w        #$8, d1                                       ; $014E78
        move.w       d0, d3                                        ; $014E7A
        addi.w       #$40, d0                                      ; $014E7C
        addi.w       #$110, d1                                     ; $014E80
        addi.w       #$c4, d3                                      ; $014E84
        move.w       d1, d4                                        ; $014E88
        clr.w        d2                                            ; $014E8A
        move.b       Data_00A666.l, d2                             ; $014E8C
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014E92
        jsr          SpawnWallReleasedActorPair.l                  ; $014E9A
        bra.w        loc_014FD4                                    ; $014EA0

loc_014EA4:
        cmp.b        $2(a4), d0                                    ; $014EA4
        bne.w        loc_014EF0                                    ; $014EA8
        move.b       $2(a3), (a2)                                  ; $014EAC
        exg.l        a0, a2                                        ; $014EB0
        jsr          CommitMapCellAndSendLink.l                    ; $014EB2
        exg.l        a0, a2                                        ; $014EB8
        move.b       WallStageCellX(a1), d0                        ; $014EBA
        move.b       WallStageCellY(a1), d1                        ; $014EBE
        lsl.w        #$8, d0                                       ; $014EC2
        lsl.w        #$8, d1                                       ; $014EC4
        move.w       d1, d4                                        ; $014EC6
        addi.w       #$110, d0                                     ; $014EC8
        addi.w       #$40, d1                                      ; $014ECC
        move.w       d0, d3                                        ; $014ED0
        addi.w       #$c4, d4                                      ; $014ED2
        clr.w        d2                                            ; $014ED6
        move.b       Data_00A640.l, d2                             ; $014ED8
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014EDE
        jsr          SpawnWallReleasedActorPair.l                  ; $014EE6
        bra.w        loc_014FD4                                    ; $014EEC

loc_014EF0:
        cmp.b        $6(a4), d0                                    ; $014EF0
        bne.w        loc_014F3C                                    ; $014EF4
        move.b       $6(a3), (a2)                                  ; $014EF8
        exg.l        a0, a2                                        ; $014EFC
        jsr          CommitMapCellAndSendLink.l                    ; $014EFE
        exg.l        a0, a2                                        ; $014F04
        move.b       WallStageCellX(a1), d0                        ; $014F06
        move.b       WallStageCellY(a1), d1                        ; $014F0A
        lsl.w        #$8, d0                                       ; $014F0E
        lsl.w        #$8, d1                                       ; $014F10
        move.w       d1, d4                                        ; $014F12
        addi.w       #$110, d0                                     ; $014F14
        addi.w       #$40, d1                                      ; $014F18
        move.w       d0, d3                                        ; $014F1C
        addi.w       #$c4, d4                                      ; $014F1E
        clr.w        d2                                            ; $014F22
        move.b       Data_00A666.l, d2                             ; $014F24
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014F2A
        jsr          SpawnWallReleasedActorPair.l                  ; $014F32
        bra.w        loc_014FD4                                    ; $014F38

loc_014F3C:
        cmp.b        $3(a4), d0                                    ; $014F3C
        bne.w        loc_014F88                                    ; $014F40
        move.b       $3(a3), (a2)                                  ; $014F44
        exg.l        a0, a2                                        ; $014F48
        jsr          CommitMapCellAndSendLink.l                    ; $014F4A
        exg.l        a0, a2                                        ; $014F50
        move.b       WallStageCellX(a1), d0                        ; $014F52
        move.b       WallStageCellY(a1), d1                        ; $014F56
        lsl.w        #$8, d0                                       ; $014F5A
        lsl.w        #$8, d1                                       ; $014F5C
        move.w       d1, d4                                        ; $014F5E
        subi.w       #$10, d0                                      ; $014F60
        addi.w       #$40, d1                                      ; $014F64
        move.w       d0, d3                                        ; $014F68
        addi.w       #$c4, d4                                      ; $014F6A
        clr.w        d2                                            ; $014F6E
        move.b       Data_00A640.l, d2                             ; $014F70
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $014F76
        jsr          SpawnWallReleasedActorPair.l                  ; $014F7E
        bra.w        loc_014FD4                                    ; $014F84

loc_014F88:
        cmp.b        $7(a4), d0                                    ; $014F88
        bne.w        loc_014FD4                                    ; $014F8C
        move.b       $7(a3), (a2)                                  ; $014F90
        exg.l        a0, a2                                        ; $014F94
        jsr          CommitMapCellAndSendLink.l                    ; $014F96
        exg.l        a0, a2                                        ; $014F9C
        move.b       WallStageCellX(a1), d0                        ; $014F9E
        move.b       WallStageCellY(a1), d1                        ; $014FA2
        lsl.w        #$8, d0                                       ; $014FA6
        lsl.w        #$8, d1                                       ; $014FA8
        move.w       d1, d4                                        ; $014FAA
        subi.w       #$10, d0                                      ; $014FAC
        addi.w       #$40, d1                                      ; $014FB0
        move.w       d0, d3                                        ; $014FB4
        addi.w       #$c4, d4                                      ; $014FB6
        clr.w        d2                                            ; $014FBA
        move.b       Data_00A666.l, d2                             ; $014FBC
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $014FC2
        jsr          SpawnWallReleasedActorPair.l                  ; $014FCA
        bra.w        loc_014FD4                                    ; $014FD0

loc_014FD4:
        move.l       a0, (a1)                                      ; $014FD4
        move.b       #$0, WallStageTimer(a1)                       ; $014FD6
        move.b       #$0, WallStageReserved(a1)                    ; $014FDC
        lsr.w        #$8, d3                                       ; $014FE2
        lsr.w        #$8, d4                                       ; $014FE4
        move.b       d3, WallStageCellX(a1)                        ; $014FE6
        move.b       d4, WallStageCellY(a1)                        ; $014FEA
        addq.b       #$1, rEnemyReleaseWallCursor(a6)              ; $014FEE
        cmpi.b       #$1e, rEnemyReleaseWallCursor(a6)             ; $014FF2
        bcs.b        loc_015000                                    ; $014FF8
        move.b       #$0, rEnemyReleaseWallCursor(a6)              ; $014FFA

loc_015000:
        rts                                                        ; $015000
        ifne *-$15002
        fail "ROM end moved"
        endif
