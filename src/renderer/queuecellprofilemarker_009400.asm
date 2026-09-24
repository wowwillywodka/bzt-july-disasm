; $009400..$0094F3 | m68k
; Maintained assembly input; no extraction occurs during build.
; $9400 queues a wall marker. $9418..$94F3 are eleven separate entries
; selected by VisibleCellHandlers; they choose a live actor definition.
; Each entry suppresses creation when cell side effects are disabled.
        ifne *-$9400
        fail "ROM start moved"
        endif

QueueCellProfileMarker:
        move.b       d1, d3                                        ; $009400
        addq.b       #$1, d3                                       ; $009402
        swap         d3                                            ; $009404
        move.b       d0, d3                                        ; $009406
        addq.b       #$1, d3                                       ; $009408
        lsl.w        #$8, d3                                       ; $00940A
        move.b       d1, d3                                        ; $00940C
        addq.b       #$1, d3                                       ; $00940E
        bsr.w        QueueUniqueWallMarker                        ; $009410

loc_009414:
        clr.w        d3                                            ; $009414
        rts                                                        ; $009416

; Visible cell type $29: Blood Body. The following entries have the same
; suppression gate and tail-branch into SpawnActorFromVisibleProfile.
TrySpawnVisibleBloodBodyCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $009418
        bne.w        BuildEmptyCellProfile                         ; $00941C
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $009420
        bra.w        SpawnActorFromVisibleProfile                  ; $009428

TrySpawnVisibleStananCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $00942C
        bne.w        BuildEmptyCellProfile                         ; $009430
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $009434
        bra.w        SpawnActorFromVisibleProfile                  ; $00943C

TrySpawnVisibleGunnerCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $009440
        bne.w        BuildEmptyCellProfile                         ; $009444
        move.l       #Data_00A674, rPendingActorDefinition(a6)     ; $009448
        bra.w        SpawnActorFromVisibleProfile                  ; $009450

TrySpawnVisibleGreenDummyCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $009454
        bne.w        BuildEmptyCellProfile                         ; $009458
        move.l       #Data_00A6C0, rPendingActorDefinition(a6)     ; $00945C
        bra.w        SpawnActorFromVisibleProfile                  ; $009464

TrySpawnVisibleGreyDummyCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $009468
        bne.w        BuildEmptyCellProfile                         ; $00946C
        move.l       #Data_00A69A, rPendingActorDefinition(a6)     ; $009470
        bra.w        SpawnActorFromVisibleProfile                  ; $009478

TrySpawnVisibleBeatressCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $00947C
        bne.w        BuildEmptyCellProfile                         ; $009480
        move.l       #Data_00A6E6, rPendingActorDefinition(a6)     ; $009484
        bra.w        SpawnActorFromVisibleProfile                  ; $00948C

TrySpawnVisibleWhiteDummyCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $009490
        bne.w        BuildEmptyCellProfile                         ; $009494
        move.l       #Data_00A70C, rPendingActorDefinition(a6)     ; $009498
        bra.w        SpawnActorFromVisibleProfile                  ; $0094A0

TrySpawnVisibleDenpyderCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $0094A4
        bne.w        BuildEmptyCellProfile                         ; $0094A8
        move.l       #Data_00A732, rPendingActorDefinition(a6)     ; $0094AC
        bra.w        SpawnActorFromVisibleProfile                  ; $0094B4

TrySpawnVisibleLarvaCreatureCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $0094B8
        bne.w        BuildEmptyCellProfile                         ; $0094BC
        move.l       #Data_00A758, rPendingActorDefinition(a6)     ; $0094C0
        bra.w        SpawnActorFromVisibleProfile                  ; $0094C8

TrySpawnVisibleBlueDummyCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $0094CC
        bne.w        BuildEmptyCellProfile                         ; $0094D0
        move.l       #Data_00A77E, rPendingActorDefinition(a6)     ; $0094D4
        bra.w        SpawnActorFromVisibleProfile                  ; $0094DC

TrySpawnVisibleDogCell:
        tst.w        rCellSideEffectsSuppressed(a6)                                    ; $0094E0
        bne.w        BuildEmptyCellProfile                         ; $0094E4
        move.l       #Data_00A7A4, rPendingActorDefinition(a6)     ; $0094E8
        bra.w        SpawnActorFromVisibleProfile                  ; $0094F0
        ifne *-$94F4
        fail "ROM end moved"
        endif
