; $00D276..$00D4E3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Настройка растеризатора грани: перспективное деление камера-координат (divs.w по глубине>>6, 0x10000/z для обратной глубины), клип ребра по ближней плоскости, вычисление экранных краёв/наклонов; A5←адрес span-функции, jmp в d4e4
        ifne *-$D276
        fail "ROM start moved"
        endif

ProjectAndDrawWallFace:
        lea.l        DrawWallTextureSpan(pc), a5                   ; $00D276

loc_00D27A:
        lea.l        -$719a(a6), a2                                ; $00D27A
        lea.l        -$718a(a6), a3                                ; $00D27E
        move.l       $8(a2), d0                                    ; $00D282
        neg.l        d0                                            ; $00D286
        cmp.l        $4(a2), d0                                    ; $00D288
        bge.w        loc_00D39A                                    ; $00D28C
        move.l       $8(a3), d0                                    ; $00D290
        cmp.l        $4(a3), d0                                    ; $00D294
        bge.b        loc_00D306                                    ; $00D298
        tst.w        (a2)                                          ; $00D29A
        bne.b        loc_00D2CC                                    ; $00D29C
        move.l       $4(a2), d0                                    ; $00D29E
        move.l       $8(a2), d1                                    ; $00D2A2
        asr.l        #$6, d0                                       ; $00D2A6
        tst.w        d0                                            ; $00D2A8
        beq.w        loc_00D4E2                                    ; $00D2AA
        divs.w       d0, d1                                        ; $00D2AE
        bvs.w        loc_00D4E2                                    ; $00D2B0
        addi.w       #$40, d1                                      ; $00D2B4
        move.w       d1, $e(a2)                                    ; $00D2B8
        move.l       #$10000, d1                                   ; $00D2BC
        divs.w       d0, d1                                        ; $00D2C2
        bvs.w        loc_00D4E2                                    ; $00D2C4
        move.w       d1, $c(a2)                                    ; $00D2C8

loc_00D2CC:
        move.l       $4(a3), d0                                    ; $00D2CC
        move.l       $8(a3), d1                                    ; $00D2D0
        asr.l        #$6, d0                                       ; $00D2D4
        tst.w        d0                                            ; $00D2D6
        beq.w        loc_00D4E2                                    ; $00D2D8
        divs.w       d0, d1                                        ; $00D2DC
        bvs.w        loc_00D4E2                                    ; $00D2DE
        addi.w       #$40, d1                                      ; $00D2E2
        move.w       d1, $e(a3)                                    ; $00D2E6
        move.l       #$10000, d1                                   ; $00D2EA
        divs.w       d0, d1                                        ; $00D2F0
        bvs.w        loc_00D4E2                                    ; $00D2F2
        move.w       d1, $c(a3)                                    ; $00D2F6
        clr.w        -$717a(a6)                                    ; $00D2FA
        move.w       #$ff, -$7178(a6)                              ; $00D2FE
; A5 continuation selected at $D268/$D26E/$D276: draw marker, return, or draw face.
        jmp          (a5)                                          ; $00D304

loc_00D306:
        move.l       #$ffffffff, (a3)                              ; $00D306
        move.l       $4(a2), d0                                    ; $00D30C
        sub.l        $8(a2), d0                                    ; $00D310
        move.l       d0, d6                                        ; $00D314
        move.l       $4(a3), d1                                    ; $00D316
        sub.l        $8(a3), d1                                    ; $00D31A
        sub.l        d1, d0                                        ; $00D31E
        asr.l        #$8, d0                                       ; $00D320
        tst.w        d0                                            ; $00D322
        beq.w        loc_00D4E2                                    ; $00D324
        divs.w       d0, d6                                        ; $00D328
        bvs.w        loc_00D4E2                                    ; $00D32A
        tst.w        (a2)                                          ; $00D32E
        bne.b        loc_00D360                                    ; $00D330
        move.l       $4(a2), d0                                    ; $00D332
        move.l       $8(a2), d1                                    ; $00D336
        asr.l        #$6, d0                                       ; $00D33A
        tst.w        d0                                            ; $00D33C
        beq.w        loc_00D4E2                                    ; $00D33E
        divs.w       d0, d1                                        ; $00D342
        bvs.w        loc_00D4E2                                    ; $00D344
        addi.w       #$40, d1                                      ; $00D348
        move.w       d1, $e(a2)                                    ; $00D34C
        move.l       #$10000, d1                                   ; $00D350
        divs.w       d0, d1                                        ; $00D356
        bvs.w        loc_00D4E2                                    ; $00D358
        move.w       d1, $c(a2)                                    ; $00D35C

loc_00D360:
        move.w       #$7f, $e(a3)                                  ; $00D360
        move.l       $4(a3), d0                                    ; $00D366
        sub.l        $4(a2), d0                                    ; $00D36A
        asr.l        #$3, d0                                       ; $00D36E
        muls.w       d6, d0                                        ; $00D370
        asr.l        #$5, d0                                       ; $00D372
        add.l        $4(a2), d0                                    ; $00D374
        asr.l        #$6, d0                                       ; $00D378
        move.l       #$10000, d1                                   ; $00D37A
        tst.w        d0                                            ; $00D380
        beq.w        loc_00D4E2                                    ; $00D382
        divs.w       d0, d1                                        ; $00D386
        bvs.w        loc_00D4E2                                    ; $00D388
        move.w       d1, $c(a3)                                    ; $00D38C
        clr.w        -$717a(a6)                                    ; $00D390
        move.w       d6, -$7178(a6)                                ; $00D394
        jmp          (a5)                                          ; $00D398

loc_00D39A:
        move.l       $8(a3), d0                                    ; $00D39A
        cmp.l        $4(a3), d0                                    ; $00D39E
        bge.w        loc_00D430                                    ; $00D3A2
        move.l       $4(a2), d0                                    ; $00D3A6
        add.l        $8(a2), d0                                    ; $00D3AA
        move.l       d0, d6                                        ; $00D3AE
        move.l       $4(a3), d1                                    ; $00D3B0
        add.l        $8(a3), d1                                    ; $00D3B4
        sub.l        d1, d0                                        ; $00D3B8
        asr.l        #$8, d0                                       ; $00D3BA
        tst.w        d0                                            ; $00D3BC
        beq.w        loc_00D4E2                                    ; $00D3BE
        divs.w       d0, d6                                        ; $00D3C2
        bvs.w        loc_00D4E2                                    ; $00D3C4
        clr.w        $e(a2)                                        ; $00D3C8
        move.l       $4(a3), d0                                    ; $00D3CC
        sub.l        $4(a2), d0                                    ; $00D3D0
        asr.l        #$3, d0                                       ; $00D3D4
        muls.w       d6, d0                                        ; $00D3D6
        asr.l        #$5, d0                                       ; $00D3D8
        add.l        $4(a2), d0                                    ; $00D3DA
        asr.l        #$6, d0                                       ; $00D3DE
        move.l       #$10000, d1                                   ; $00D3E0
        tst.w        d0                                            ; $00D3E6
        beq.w        loc_00D4E2                                    ; $00D3E8
        divs.w       d0, d1                                        ; $00D3EC
        bvs.w        loc_00D4E2                                    ; $00D3EE
        move.w       d1, $c(a2)                                    ; $00D3F2
        move.l       $4(a3), d0                                    ; $00D3F6
        move.l       $8(a3), d1                                    ; $00D3FA
        asr.l        #$6, d0                                       ; $00D3FE
        tst.w        d0                                            ; $00D400
        beq.w        loc_00D4E2                                    ; $00D402
        divs.w       d0, d1                                        ; $00D406
        bvs.w        loc_00D4E2                                    ; $00D408
        addi.w       #$40, d1                                      ; $00D40C
        move.w       d1, $e(a3)                                    ; $00D410
        move.l       #$10000, d1                                   ; $00D414
        divs.w       d0, d1                                        ; $00D41A
        bvs.w        loc_00D4E2                                    ; $00D41C
        move.w       d1, $c(a3)                                    ; $00D420
        move.w       #$ff, -$7178(a6)                              ; $00D424
        move.w       d6, -$717a(a6)                                ; $00D42A
        jmp          (a5)                                          ; $00D42E

loc_00D430:
        move.l       #$ffffffff, (a3)                              ; $00D430
        move.l       $4(a2), d0                                    ; $00D436
        add.l        $8(a2), d0                                    ; $00D43A
        move.l       d0, d6                                        ; $00D43E
        move.l       $4(a3), d1                                    ; $00D440
        add.l        $8(a3), d1                                    ; $00D444
        sub.l        d1, d0                                        ; $00D448
        asr.l        #$8, d0                                       ; $00D44A
        tst.w        d0                                            ; $00D44C
        beq.w        loc_00D4E2                                    ; $00D44E
        divs.w       d0, d6                                        ; $00D452
        bvs.w        loc_00D4E2                                    ; $00D454
        move.l       $4(a2), d0                                    ; $00D458
        sub.l        $8(a2), d0                                    ; $00D45C
        move.l       d0, d5                                        ; $00D460
        move.l       $4(a3), d1                                    ; $00D462
        sub.l        $8(a3), d1                                    ; $00D466
        sub.l        d1, d0                                        ; $00D46A
        asr.l        #$8, d0                                       ; $00D46C
        tst.w        d0                                            ; $00D46E
        beq.w        loc_00D4E2                                    ; $00D470
        divs.w       d0, d5                                        ; $00D474
        bvs.w        loc_00D4E2                                    ; $00D476
        clr.w        $e(a2)                                        ; $00D47A
        move.l       $4(a3), d0                                    ; $00D47E
        sub.l        $4(a2), d0                                    ; $00D482
        asr.l        #$3, d0                                       ; $00D486
        muls.w       d6, d0                                        ; $00D488
        asr.l        #$5, d0                                       ; $00D48A
        add.l        $4(a2), d0                                    ; $00D48C
        asr.l        #$6, d0                                       ; $00D490
        move.l       #$10000, d1                                   ; $00D492
        tst.w        d0                                            ; $00D498
        beq.w        loc_00D4E2                                    ; $00D49A
        divs.w       d0, d1                                        ; $00D49E
        bvs.w        loc_00D4E2                                    ; $00D4A0
        move.w       d1, $c(a2)                                    ; $00D4A4
        move.w       #$7f, $e(a3)                                  ; $00D4A8
        move.l       $4(a3), d0                                    ; $00D4AE
        sub.l        $4(a2), d0                                    ; $00D4B2
        asr.l        #$3, d0                                       ; $00D4B6
        muls.w       d5, d0                                        ; $00D4B8
        asr.l        #$5, d0                                       ; $00D4BA
        add.l        $4(a2), d0                                    ; $00D4BC
        asr.l        #$6, d0                                       ; $00D4C0
        move.l       #$10000, d1                                   ; $00D4C2
        tst.w        d0                                            ; $00D4C8
        beq.w        loc_00D4E2                                    ; $00D4CA
        divs.w       d0, d1                                        ; $00D4CE
        bvs.w        loc_00D4E2                                    ; $00D4D0
        move.w       d1, $c(a3)                                    ; $00D4D4
        move.w       d6, -$717a(a6)                                ; $00D4D8
        move.w       d5, -$7178(a6)                                ; $00D4DC
        jmp          (a5)                                          ; $00D4E0

loc_00D4E2:
        rts                                                        ; $00D4E2
        ifne *-$D4E4
        fail "ROM end moved"
        endif
