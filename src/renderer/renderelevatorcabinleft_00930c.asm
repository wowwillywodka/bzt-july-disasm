; $00930C..$0093BF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x9290] [⇐June 90F0] профиль лифта/площадок ct 0x12-0x14/0x30-0x34/0x3C-0x5B (семейство)
        ifne *-$930C
        fail "ROM start moved"
        endif

RenderElevatorCabinLeft:
        tst.w        d0                                            ; $00930C
        ble.b        loc_009324                                    ; $00930E
        move.b       d0, d3                                        ; $009310
        lsl.w        #$8, d3                                       ; $009312
        move.b       d1, d3                                        ; $009314
        swap         d3                                            ; $009316
        move.b       d0, d3                                        ; $009318
        lsl.w        #$8, d3                                       ; $00931A
        move.b       d1, d3                                        ; $00931C
        addq.b       #$1, d3                                       ; $00931E
        bsr.w        RendererRoutine_0096D4                        ; $009320

loc_009324:
        clr.w        d3                                            ; $009324
        rts                                                        ; $009326

loc_009328:
        tst.w        d0                                            ; $009328
        ble.b        loc_009340                                    ; $00932A
        move.b       d0, d3                                        ; $00932C
        lsl.w        #$8, d3                                       ; $00932E
        move.b       d1, d3                                        ; $009330
        swap         d3                                            ; $009332
        move.b       d0, d3                                        ; $009334
        lsl.w        #$8, d3                                       ; $009336
        move.b       d1, d3                                        ; $009338
        addq.b       #$1, d3                                       ; $00933A
        bsr.w        EnemiesRoutine_0096CC                         ; $00933C

loc_009340:
        clr.w        d3                                            ; $009340
        rts                                                        ; $009342

loc_009344:
        tst.w        d0                                            ; $009344
        bpl.b        loc_009360                                    ; $009346
        move.b       d0, d3                                        ; $009348
        addq.b       #$1, d3                                       ; $00934A
        lsl.w        #$8, d3                                       ; $00934C
        move.b       d1, d3                                        ; $00934E
        addq.b       #$1, d3                                       ; $009350
        swap         d3                                            ; $009352
        move.b       d0, d3                                        ; $009354
        addq.b       #$1, d3                                       ; $009356
        lsl.w        #$8, d3                                       ; $009358
        move.b       d1, d3                                        ; $00935A
        bsr.w        RendererRoutine_0096D4                        ; $00935C

loc_009360:
        clr.w        d3                                            ; $009360
        rts                                                        ; $009362

loc_009364:
        tst.w        d0                                            ; $009364
        bpl.b        loc_009380                                    ; $009366
        move.b       d0, d3                                        ; $009368
        addq.b       #$1, d3                                       ; $00936A
        lsl.w        #$8, d3                                       ; $00936C
        move.b       d1, d3                                        ; $00936E
        addq.b       #$1, d3                                       ; $009370
        swap         d3                                            ; $009372
        move.b       d0, d3                                        ; $009374
        addq.b       #$1, d3                                       ; $009376
        lsl.w        #$8, d3                                       ; $009378
        move.b       d1, d3                                        ; $00937A
        bsr.w        EnemiesRoutine_0096CC                         ; $00937C

loc_009380:
        clr.w        d3                                            ; $009380
        rts                                                        ; $009382

loc_009384:
        tst.w        d0                                            ; $009384
        ble.b        loc_00939C                                    ; $009386
        move.b       d0, d3                                        ; $009388
        lsl.w        #$8, d3                                       ; $00938A
        move.b       d1, d3                                        ; $00938C
        swap         d3                                            ; $00938E
        move.b       d0, d3                                        ; $009390
        lsl.w        #$8, d3                                       ; $009392
        move.b       d1, d3                                        ; $009394
        addq.b       #$1, d3                                       ; $009396
        bsr.w        RendererRoutine_0096D4                        ; $009398

loc_00939C:
        clr.w        d3                                            ; $00939C
        rts                                                        ; $00939E

loc_0093A0:
        tst.w        d1                                            ; $0093A0
        bpl.b        loc_0093BC                                    ; $0093A2
        move.b       d0, d3                                        ; $0093A4
        lsl.w        #$8, d3                                       ; $0093A6
        move.b       d1, d3                                        ; $0093A8
        addq.b       #$1, d3                                       ; $0093AA
        swap         d3                                            ; $0093AC
        move.b       d0, d3                                        ; $0093AE
        addq.b       #$1, d3                                       ; $0093B0
        lsl.w        #$8, d3                                       ; $0093B2
        move.b       d1, d3                                        ; $0093B4
        addq.b       #$1, d3                                       ; $0093B6
        bsr.w        EnemiesRoutine_0096CC                         ; $0093B8

loc_0093BC:
        clr.w        d3                                            ; $0093BC
        rts                                                        ; $0093BE
        ifne *-$93C0
        fail "ROM end moved"
        endif
