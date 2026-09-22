; $009400..$0094F3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Пакует координаты (D0+1,D1+1) в 4-байт запись D3 и bsr $96d4 — добавляет метку/точку в список отрисовки (очередь блипов/спрайтов карты)
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
        bsr.w        RendererRoutine_0096D4                        ; $009410

loc_009414:
        clr.w        d3                                            ; $009414
        rts                                                        ; $009416

loc_009418:
        tst.w        -$715a(a6)                                    ; $009418
        bne.w        BuildEmptyCellProfile                         ; $00941C
        move.l       #ActorDefinitions, rPendingActorDefinition(a6) ; $009420
        bra.w        SpawnActorFromVisibleProfile                  ; $009428

loc_00942C:
        tst.w        -$715a(a6)                                    ; $00942C
        bne.w        BuildEmptyCellProfile                         ; $009430
        move.l       #Data_00A64E, rPendingActorDefinition(a6)     ; $009434
        bra.w        SpawnActorFromVisibleProfile                  ; $00943C

loc_009440:
        tst.w        -$715a(a6)                                    ; $009440
        bne.w        BuildEmptyCellProfile                         ; $009444
        move.l       #Data_00A674, rPendingActorDefinition(a6)     ; $009448
        bra.w        SpawnActorFromVisibleProfile                  ; $009450

loc_009454:
        tst.w        -$715a(a6)                                    ; $009454
        bne.w        BuildEmptyCellProfile                         ; $009458
        move.l       #Data_00A6C0, rPendingActorDefinition(a6)     ; $00945C
        bra.w        SpawnActorFromVisibleProfile                  ; $009464

loc_009468:
        tst.w        -$715a(a6)                                    ; $009468
        bne.w        BuildEmptyCellProfile                         ; $00946C
        move.l       #Data_00A69A, rPendingActorDefinition(a6)     ; $009470
        bra.w        SpawnActorFromVisibleProfile                  ; $009478

loc_00947C:
        tst.w        -$715a(a6)                                    ; $00947C
        bne.w        BuildEmptyCellProfile                         ; $009480
        move.l       #Data_00A6E6, rPendingActorDefinition(a6)     ; $009484
        bra.w        SpawnActorFromVisibleProfile                  ; $00948C

loc_009490:
        tst.w        -$715a(a6)                                    ; $009490
        bne.w        BuildEmptyCellProfile                         ; $009494
        move.l       #Data_00A70C, rPendingActorDefinition(a6)     ; $009498
        bra.w        SpawnActorFromVisibleProfile                  ; $0094A0

loc_0094A4:
        tst.w        -$715a(a6)                                    ; $0094A4
        bne.w        BuildEmptyCellProfile                         ; $0094A8
        move.l       #Data_00A732, rPendingActorDefinition(a6)     ; $0094AC
        bra.w        SpawnActorFromVisibleProfile                  ; $0094B4

loc_0094B8:
        tst.w        -$715a(a6)                                    ; $0094B8
        bne.w        BuildEmptyCellProfile                         ; $0094BC
        move.l       #Data_00A758, rPendingActorDefinition(a6)     ; $0094C0
        bra.w        SpawnActorFromVisibleProfile                  ; $0094C8

loc_0094CC:
        tst.w        -$715a(a6)                                    ; $0094CC
        bne.w        BuildEmptyCellProfile                         ; $0094D0
        move.l       #Data_00A77E, rPendingActorDefinition(a6)     ; $0094D4
        bra.w        SpawnActorFromVisibleProfile                  ; $0094DC

loc_0094E0:
        tst.w        -$715a(a6)                                    ; $0094E0
        bne.w        BuildEmptyCellProfile                         ; $0094E4
        move.l       #Data_00A7A4, rPendingActorDefinition(a6)     ; $0094E8
        bra.w        SpawnActorFromVisibleProfile                  ; $0094F0
        ifne *-$94F4
        fail "ROM end moved"
        endif
