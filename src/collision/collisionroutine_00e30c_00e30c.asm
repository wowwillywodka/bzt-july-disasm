; $00E30C..$00EBDF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Кадровый обработчик движения/поворота игрока: jsr 0x196f6; при паузе (-0x7210,A6) сбрасывает инерцию и угол; иначе по edge-детекту байтов пада (-0x7fd1/-0x7fd2 vs -0x7fcd/-0x7fce,A6) задаёт страйф/поворот (-0x714e), переключает авто-бег (-0x213c,A6) и инициирует шаги поворота
        ifne *-$E30C
        fail "ROM start moved"
        endif

CollisionRoutine_00E30C:
        jsr          ConsumeNearbySlowProjectile.l                 ; $00E30C
        tst.w        rPlayerDeathTicks(a6)                         ; $00E312
        beq.b        loc_00E334                                    ; $00E316
        clr.w        -$7152(a6)                                    ; $00E318
        clr.w        -$7156(a6)                                    ; $00E31C
        clr.w        -$714e(a6)                                    ; $00E320
        move.w       #$ffe4, -$71d6(a6)                            ; $00E324
        move.w       #$63, -$71ce(a6)                              ; $00E32A
        bra.w        loc_00E4E6                                    ; $00E330

loc_00E334:
        tst.w        -$213a(a6)                                    ; $00E334
        bne.b        loc_00E360                                    ; $00E338
        btst.b       #$3, -$7fd1(a6)                               ; $00E33A
        beq.b        loc_00E352                                    ; $00E340
        btst.b       #$3, -$7fcd(a6)                               ; $00E342
        bne.b        loc_00E3A2                                    ; $00E348
        move.w       #$1, -$213c(a6)                               ; $00E34A
        bra.b        loc_00E3A2                                    ; $00E350

loc_00E352:
        btst.b       #$3, -$7fcd(a6)                               ; $00E352
        beq.b        loc_00E360                                    ; $00E358
        move.w       #$0, -$213c(a6)                               ; $00E35A

loc_00E360:
        btst.b       #$6, rControllerState(a6)                     ; $00E360
        beq.b        loc_00E38E                                    ; $00E366
        btst.b       #$5, rControllerState(a6)                     ; $00E368
        beq.b        loc_00E38E                                    ; $00E36E
        btst.b       #$6, rPreviousControllerState(a6)             ; $00E370
        beq.b        loc_00E38E                                    ; $00E376
        btst.b       #$5, rPreviousControllerState(a6)             ; $00E378
        bne.b        loc_00E3A2                                    ; $00E37E
        move.w       #$1, -$213c(a6)                               ; $00E380
        move.w       #$1, -$213a(a6)                               ; $00E386
        bra.b        loc_00E3A2                                    ; $00E38C

loc_00E38E:
        btst.b       #$5, rPreviousControllerState(a6)             ; $00E38E
        beq.b        loc_00E3A2                                    ; $00E394
        move.w       #$0, -$213c(a6)                               ; $00E396
        move.w       #$0, -$213a(a6)                               ; $00E39C

loc_00E3A2:
        tst.w        -$213c(a6)                                    ; $00E3A2
        bne.w        loc_00E3BE                                    ; $00E3A6
        btst.b       #$5, rControllerState(a6)                     ; $00E3AA
        beq.b        loc_00E3BE                                    ; $00E3B0
        btst.b       #$5, rPreviousControllerState(a6)             ; $00E3B2
        bne.b        loc_00E3BE                                    ; $00E3B8
        bsr.w        loc_011F48                                    ; $00E3BA

loc_00E3BE:
        clr.w        -$7156(a6)                                    ; $00E3BE
        clr.w        -$7152(a6)                                    ; $00E3C2
        clr.w        -$714e(a6)                                    ; $00E3C6
        btst.b       #$2, -$7fd1(a6)                               ; $00E3CA
        beq.w        loc_00E3DA                                    ; $00E3D0
        addi.w       #$ffc4, -$714e(a6)                            ; $00E3D4

loc_00E3DA:
        btst.b       #$1, -$7fd1(a6)                               ; $00E3DA
        beq.w        loc_00E3EA                                    ; $00E3E0
        addi.w       #$3c, -$714e(a6)                              ; $00E3E4

loc_00E3EA:
        btst.b       #$0, -$7fd1(a6)                               ; $00E3EA
        beq.b        loc_00E3FE                                    ; $00E3F0
        move.w       #$fff0, -$71d6(a6)                            ; $00E3F2
        move.w       #$1e, -$71ce(a6)                              ; $00E3F8

loc_00E3FE:
        btst.b       #$6, rControllerState(a6)                     ; $00E3FE
        beq.w        loc_00E492                                    ; $00E404
        tst.w        -$71d8(a6)                                    ; $00E408
        bgt.w        loc_00E42C                                    ; $00E40C
        btst.b       #$2, rControllerState(a6)                     ; $00E410
        beq.b        loc_00E41E                                    ; $00E416
        move.w       #$ffc4, -$714e(a6)                            ; $00E418

loc_00E41E:
        btst.b       #$3, rControllerState(a6)                     ; $00E41E
        beq.b        loc_00E42C                                    ; $00E424
        move.w       #$3c, -$714e(a6)                              ; $00E426

loc_00E42C:
        btst.b       #$0, rControllerState(a6)                     ; $00E42C
        beq.b        loc_00E46C                                    ; $00E432
        tst.w        -$71d8(a6)                                    ; $00E434
        bgt.b        loc_00E46C                                    ; $00E438
        bmi.b        loc_00E468                                    ; $00E43A
        btst.b       #$6, rPreviousControllerState(a6)             ; $00E43C
        beq.b        loc_00E44C                                    ; $00E442
        btst.b       #$0, rPreviousControllerState(a6)             ; $00E444
        bne.b        loc_00E46C                                    ; $00E44A

loc_00E44C:
        btst.b       #$2, rControllerState(a6)                     ; $00E44C
        bne.b        loc_00E46C                                    ; $00E452
        btst.b       #$3, rControllerState(a6)                     ; $00E454
        bne.b        loc_00E46C                                    ; $00E45A
        move.w       #$9, -$71d2(a6)                               ; $00E45C
        clr.w        -$71d8(a6)                                    ; $00E462
        bra.b        loc_00E46C                                    ; $00E466

loc_00E468:
        clr.w        -$71d6(a6)                                    ; $00E468

loc_00E46C:
        btst.b       #$1, rControllerState(a6)                     ; $00E46C
        beq.b        loc_00E490                                    ; $00E472
        btst.b       #$2, rControllerState(a6)                     ; $00E474
        bne.b        loc_00E490                                    ; $00E47A
        btst.b       #$3, rControllerState(a6)                     ; $00E47C
        bne.b        loc_00E490                                    ; $00E482
        move.w       #$fff0, -$71d6(a6)                            ; $00E484
        move.w       #$1e, -$71ce(a6)                              ; $00E48A

loc_00E490:
        bra.b        loc_00E4E6                                    ; $00E490

loc_00E492:
        btst.b       #$2, rControllerState(a6)                     ; $00E492
        beq.b        loc_00E4A0                                    ; $00E498
        move.w       #$ffd8, -$7156(a6)                            ; $00E49A

loc_00E4A0:
        btst.b       #$3, rControllerState(a6)                     ; $00E4A0
        beq.b        loc_00E4AE                                    ; $00E4A6
        move.w       #$28, -$7156(a6)                              ; $00E4A8

loc_00E4AE:
        btst.b       #$0, rControllerState(a6)                     ; $00E4AE
        beq.b        loc_00E4CA                                    ; $00E4B4
        move.w       #$28, -$7152(a6)                              ; $00E4B6
        cmpi.w       #$3, rSelectedCharacter(a6)                   ; $00E4BC
        bne.b        loc_00E4CA                                    ; $00E4C2
        move.w       #$2d, -$7152(a6)                              ; $00E4C4

loc_00E4CA:
        btst.b       #$1, rControllerState(a6)                     ; $00E4CA
        beq.b        loc_00E4E6                                    ; $00E4D0
        move.w       #$ffec, -$7152(a6)                            ; $00E4D2
        cmpi.w       #$3, rSelectedCharacter(a6)                   ; $00E4D8
        bne.b        loc_00E4E6                                    ; $00E4DE
        move.w       #$ffd3, -$7152(a6)                            ; $00E4E0

loc_00E4E6:
        cmpi.w       #$fff0, -$71d6(a6)                            ; $00E4E6
        bne.b        loc_00E4F8                                    ; $00E4EC
        subq.w       #$1, -$71ce(a6)                               ; $00E4EE
        bne.b        loc_00E4F8                                    ; $00E4F2
        clr.w        -$71d6(a6)                                    ; $00E4F4

loc_00E4F8:
        move.w       -$71d2(a6), d0                                ; $00E4F8
        bne.b        loc_00E504                                    ; $00E4FC
        tst.w        -$71d8(a6)                                    ; $00E4FE
        ble.b        loc_00E51A                                    ; $00E502

loc_00E504:
        subq.w       #$2, -$71d2(a6)                               ; $00E504
        add.w        d0, -$71d8(a6)                                ; $00E508
        bmi.b        loc_00E510                                    ; $00E50C
        bne.b        loc_00E53A                                    ; $00E50E

loc_00E510:
        clr.w        -$71d8(a6)                                    ; $00E510
        clr.w        -$71d2(a6)                                    ; $00E514
        bra.b        loc_00E53A                                    ; $00E518

loc_00E51A:
        move.w       -$71d8(a6), d0                                ; $00E51A
        bpl.b        loc_00E528                                    ; $00E51E
        asr.w        -$714e(a6)                                    ; $00E520
        asr.w        -$7152(a6)                                    ; $00E524

loc_00E528:
        cmp.w        -$71d6(a6), d0                                ; $00E528
        beq.b        loc_00E53A                                    ; $00E52C
        blt.b        loc_00E536                                    ; $00E52E
        subq.w       #$4, -$71d8(a6)                               ; $00E530
        bra.b        loc_00E53A                                    ; $00E534

loc_00E536:
        addq.w       #$4, -$71d8(a6)                               ; $00E536

loc_00E53A:
        tst.w        -$71d8(a6)                                    ; $00E53A
        bgt.w        loc_00E5BE                                    ; $00E53E
        move.w       -$7154(a6), d0                                ; $00E542
        beq.b        loc_00E54C                                    ; $00E546
        move.w       #$1, d0                                       ; $00E548

loc_00E54C:
        tst.w        -$7156(a6)                                    ; $00E54C
        beq.b        loc_00E598                                    ; $00E550
        bpl.b        loc_00E576                                    ; $00E552
        add.w        d0, -$7158(a6)                                ; $00E554
        subq.w       #$3, -$7158(a6)                               ; $00E558
        bmi.b        loc_00E566                                    ; $00E55C
        add.w        d0, -$7158(a6)                                ; $00E55E
        subq.w       #$6, -$7158(a6)                               ; $00E562

loc_00E566:
        cmpi.w       #$ffd8, -$7158(a6)                            ; $00E566
        bge.b        loc_00E5BE                                    ; $00E56C
        move.w       #$ffd8, -$7158(a6)                            ; $00E56E
        bra.b        loc_00E5BE                                    ; $00E574

loc_00E576:
        sub.w        d0, -$7158(a6)                                ; $00E576
        addq.w       #$3, -$7158(a6)                               ; $00E57A
        bpl.b        loc_00E588                                    ; $00E57E
        sub.w        d0, -$7158(a6)                                ; $00E580
        addq.w       #$6, -$7158(a6)                               ; $00E584

loc_00E588:
        cmpi.w       #$28, -$7158(a6)                              ; $00E588
        ble.b        loc_00E5BE                                    ; $00E58E
        move.w       #$28, -$7158(a6)                              ; $00E590
        bra.b        loc_00E5BE                                    ; $00E596

loc_00E598:
        tst.w        -$7158(a6)                                    ; $00E598
        bpl.b        loc_00E5B0                                    ; $00E59C
        beq.b        loc_00E5BE                                    ; $00E59E
        addi.w       #$9, -$7158(a6)                               ; $00E5A0
        ble.b        loc_00E5BE                                    ; $00E5A6
        move.w       #$0, -$7158(a6)                               ; $00E5A8
        bra.b        loc_00E5BE                                    ; $00E5AE

loc_00E5B0:
        subi.w       #$9, -$7158(a6)                               ; $00E5B0
        bge.b        loc_00E5BE                                    ; $00E5B6
        move.w       #$0, -$7158(a6)                               ; $00E5B8

loc_00E5BE:
        move.w       -$7158(a6), d0                                ; $00E5BE
        beq.b        loc_00E5E4                                    ; $00E5C2
        add.w        d0, -$71ee(a6)                                ; $00E5C4
        andi.w       #$1ff, -$71ee(a6)                             ; $00E5C8
        lea.l        AngleVectorPairs(pc), a0                      ; $00E5CE
        move.w       -$71ee(a6), d0                                ; $00E5D2
        lsl.w        #$2, d0                                       ; $00E5D6
        adda.w       d0, a0                                        ; $00E5D8
        move.w       (a0), -$71f2(a6)                              ; $00E5DA
        move.w       $2(a0), -$71f0(a6)                            ; $00E5DE

loc_00E5E4:
        tst.w        -$71d8(a6)                                    ; $00E5E4
        bgt.b        loc_00E65A                                    ; $00E5E8
        move.w       -$7152(a6), d0                                ; $00E5EA
        beq.b        loc_00E60A                                    ; $00E5EE
        sub.w        -$7154(a6), d0                                ; $00E5F0
        beq.b        loc_00E622                                    ; $00E5F4
        bmi.b        loc_00E602                                    ; $00E5F6
        neg.w        d0                                            ; $00E5F8
        asr.w        #$4, d0                                       ; $00E5FA
        sub.w        d0, -$7154(a6)                                ; $00E5FC
        bra.b        loc_00E622                                    ; $00E600

loc_00E602:
        asr.w        #$4, d0                                       ; $00E602
        add.w        d0, -$7154(a6)                                ; $00E604
        bra.b        loc_00E622                                    ; $00E608

loc_00E60A:
        sub.w        -$7154(a6), d0                                ; $00E60A
        beq.b        loc_00E622                                    ; $00E60E
        bmi.b        loc_00E61C                                    ; $00E610
        neg.w        d0                                            ; $00E612
        asr.w        #$1, d0                                       ; $00E614
        sub.w        d0, -$7154(a6)                                ; $00E616
        bra.b        loc_00E622                                    ; $00E61A

loc_00E61C:
        asr.w        #$1, d0                                       ; $00E61C
        add.w        d0, -$7154(a6)                                ; $00E61E

loc_00E622:
        move.w       -$714e(a6), d0                                ; $00E622
        beq.b        loc_00E642                                    ; $00E626
        sub.w        -$7150(a6), d0                                ; $00E628
        beq.b        loc_00E65A                                    ; $00E62C
        bmi.b        loc_00E63A                                    ; $00E62E
        neg.w        d0                                            ; $00E630
        asr.w        #$4, d0                                       ; $00E632
        sub.w        d0, -$7150(a6)                                ; $00E634
        bra.b        loc_00E65A                                    ; $00E638

loc_00E63A:
        asr.w        #$4, d0                                       ; $00E63A
        add.w        d0, -$7150(a6)                                ; $00E63C
        bra.b        loc_00E65A                                    ; $00E640

loc_00E642:
        sub.w        -$7150(a6), d0                                ; $00E642
        beq.b        loc_00E65A                                    ; $00E646
        bmi.b        loc_00E654                                    ; $00E648
        neg.w        d0                                            ; $00E64A
        asr.w        #$1, d0                                       ; $00E64C
        sub.w        d0, -$7150(a6)                                ; $00E64E
        bra.b        loc_00E65A                                    ; $00E652

loc_00E654:
        asr.w        #$1, d0                                       ; $00E654
        add.w        d0, -$7150(a6)                                ; $00E656

loc_00E65A:
        lea.l        rCellTypeByIndex(a6), a5                      ; $00E65A
        movea.l      rVisibleMapBasePointer(a6), a1                ; $00E65E
        clr.w        d3                                            ; $00E662
        move.w       -$7154(a6), d0                                ; $00E664
        bne.b        loc_00E690                                    ; $00E668
        move.w       -$7202(a6), d0                                ; $00E66A
        or.w         -$7200(a6), d0                                ; $00E66E
        bne.b        loc_00E690                                    ; $00E672
        move.w       -$7150(a6), d0                                ; $00E674
        beq.w        loc_00EBD6                                    ; $00E678
        move.w       -$71f0(a6), d1                                ; $00E67C
        neg.w        d1                                            ; $00E680
        muls.w       d0, d1                                        ; $00E682
        asr.l        #$8, d1                                       ; $00E684
        move.w       -$71f2(a6), d2                                ; $00E686
        muls.w       d0, d2                                        ; $00E68A
        asr.l        #$8, d2                                       ; $00E68C
        bra.b        loc_00E6E8                                    ; $00E68E

loc_00E690:
        move.w       -$7202(a6), d1                                ; $00E690
        bpl.b        loc_00E69A                                    ; $00E694
        asr.w        #$2, d1                                       ; $00E696
        bra.b        loc_00E6A0                                    ; $00E698

loc_00E69A:
        neg.w        d1                                            ; $00E69A
        asr.w        #$2, d1                                       ; $00E69C
        neg.w        d1                                            ; $00E69E

loc_00E6A0:
        sub.w        d1, -$7202(a6)                                ; $00E6A0
        move.w       -$7200(a6), d1                                ; $00E6A4
        bpl.b        loc_00E6AE                                    ; $00E6A8
        asr.w        #$2, d1                                       ; $00E6AA
        bra.b        loc_00E6B4                                    ; $00E6AC

loc_00E6AE:
        neg.w        d1                                            ; $00E6AE
        asr.w        #$2, d1                                       ; $00E6B0
        neg.w        d1                                            ; $00E6B2

loc_00E6B4:
        sub.w        d1, -$7200(a6)                                ; $00E6B4
        move.w       -$71f2(a6), d1                                ; $00E6B8
        muls.w       d0, d1                                        ; $00E6BC
        asr.l        #$8, d1                                       ; $00E6BE
        move.w       -$71f0(a6), d2                                ; $00E6C0
        muls.w       d0, d2                                        ; $00E6C4
        asr.l        #$8, d2                                       ; $00E6C6
        move.w       -$7150(a6), d0                                ; $00E6C8
        beq.b        loc_00E6E8                                    ; $00E6CC
        move.l       d1, -(a7)                                     ; $00E6CE
        move.l       d2, -(a7)                                     ; $00E6D0
        move.w       -$71f0(a6), d1                                ; $00E6D2
        neg.w        d1                                            ; $00E6D6
        muls.w       d0, d1                                        ; $00E6D8
        asr.l        #$8, d1                                       ; $00E6DA
        move.w       -$71f2(a6), d2                                ; $00E6DC
        muls.w       d0, d2                                        ; $00E6E0
        asr.l        #$8, d2                                       ; $00E6E2
        add.l        (a7)+, d2                                     ; $00E6E4
        add.l        (a7)+, d1                                     ; $00E6E6

loc_00E6E8:
        add.w        -$7202(a6), d1                                ; $00E6E8
        add.w        -$7200(a6), d2                                ; $00E6EC
        movem.w      d0-d2, -(a7)                                  ; $00E6F0
        movem.l      a0/a3, -(a7)                                  ; $00E6F4
        clr.w        d0                                            ; $00E6F8
        clr.w        d1                                            ; $00E6FA
        move.b       rPlayerX(a6), d0                              ; $00E6FC
        move.b       rPlayerY(a6), d1                              ; $00E700
        lsl.w        #$5, d1                                       ; $00E704
        add.w        d0, d1                                        ; $00E706
        lea.l        rVisibleMapWindow(a6), a0                     ; $00E708
        adda.w       d1, a0                                        ; $00E70C
        move.w       -$71ee(a6), d0                                ; $00E70E
        cmpi.w       #$1c0, d0                                     ; $00E712
        bhi.b        loc_00E72A                                    ; $00E716
        cmpi.w       #$140, d0                                     ; $00E718
        bhi.b        loc_00E738                                    ; $00E71C
        cmpi.w       #$c0, d0                                      ; $00E71E
        bhi.b        loc_00E744                                    ; $00E722
        cmpi.w       #$40, d0                                      ; $00E724
        bhi.b        loc_00E752                                    ; $00E728

loc_00E72A:
        cmpi.b       #$20, -$7203(a6)                              ; $00E72A
        bhi.b        loc_00E77C                                    ; $00E730
        suba.w       #$20, a0                                      ; $00E732
        bra.b        loc_00E75C                                    ; $00E736

loc_00E738:
        cmpi.b       #$20, -$7205(a6)                              ; $00E738
        bhi.b        loc_00E77C                                    ; $00E73E
        subq.w       #$1, a0                                       ; $00E740
        bra.b        loc_00E75C                                    ; $00E742

loc_00E744:
        cmpi.b       #$d0, -$7203(a6)                              ; $00E744
        bcs.b        loc_00E77C                                    ; $00E74A
        adda.w       #$20, a0                                      ; $00E74C
        bra.b        loc_00E75C                                    ; $00E750

loc_00E752:
        cmpi.b       #$d0, -$7205(a6)                              ; $00E752
        bcs.b        loc_00E77C                                    ; $00E758
        addq.w       #$1, a0                                       ; $00E75A

loc_00E75C:
        move.b       (a0), d0                                      ; $00E75C
        andi.w       #$ff, d0                                      ; $00E75E
        lea.l        rCellTypeByIndex(a6), a3                      ; $00E762
        move.b       (a3, d0.w), d2                                ; $00E766
        cmpi.b       #$86, d2                                      ; $00E76A
        beq.b        loc_00E776                                    ; $00E76E
        cmpi.b       #$87, d2                                      ; $00E770
        bne.b        loc_00E77C                                    ; $00E774

loc_00E776:
        jsr          TryOpenWallWithPermit.l                       ; $00E776

loc_00E77C:
        movem.l      (a7)+, a0/a3                                  ; $00E77C
        movem.w      (a7)+, d0-d2                                  ; $00E780
        move.w       rPlayerX(a6), d0                              ; $00E784
        add.w        d1, d0                                        ; $00E788
        move.w       rPlayerY(a6), d4                              ; $00E78A
        add.w        d2, d4                                        ; $00E78E
        bsr.w        TestPlayerCollision                           ; $00E790
        cmpi.b       #$1, d3                                       ; $00E794
        beq.w        loc_00E81E                                    ; $00E798
        tst.b        d3                                            ; $00E79C
        bne.b        loc_00E7BA                                    ; $00E79E
; When PlayerMovementSlowCounter nonzero, decrement once and ASR3 both accepted movement components. Other slide/axis branches apply same gate.
        tst.b        rPlayerMovementSlowCounter(a6)                ; $00E7A0
        beq.b        loc_00E7AE                                    ; $00E7A4
        subq.b       #$1, rPlayerMovementSlowCounter(a6)           ; $00E7A6
        asr.w        #$3, d1                                       ; $00E7AA
        asr.w        #$3, d2                                       ; $00E7AC

loc_00E7AE:
        add.w        d1, rPlayerX(a6)                              ; $00E7AE
        add.w        d2, rPlayerY(a6)                              ; $00E7B2
        bra.w        loc_00E866                                    ; $00E7B6

loc_00E7BA:
        move.w       d2, d6                                        ; $00E7BA
        sub.w        d1, d6                                        ; $00E7BC
        asr.w        #$1, d6                                       ; $00E7BE
        move.w       d6, d5                                        ; $00E7C0
        neg.w        d5                                            ; $00E7C2
        move.w       rPlayerX(a6), d0                              ; $00E7C4
        add.w        d5, d0                                        ; $00E7C8
        move.w       rPlayerY(a6), d4                              ; $00E7CA
        add.w        d6, d4                                        ; $00E7CE
        bsr.w        TestPlayerCollision                           ; $00E7D0
        bne.b        loc_00E7EE                                    ; $00E7D4
        tst.b        rPlayerMovementSlowCounter(a6)                ; $00E7D6
        beq.b        loc_00E7E4                                    ; $00E7DA
        subq.b       #$1, rPlayerMovementSlowCounter(a6)           ; $00E7DC
        asr.w        #$3, d5                                       ; $00E7E0
        asr.w        #$3, d6                                       ; $00E7E2

loc_00E7E4:
        add.w        d5, rPlayerX(a6)                              ; $00E7E4
        add.w        d6, rPlayerY(a6)                              ; $00E7E8
        bra.b        loc_00E866                                    ; $00E7EC

loc_00E7EE:
        sub.w        d5, d1                                        ; $00E7EE
        sub.w        d6, d2                                        ; $00E7F0
        move.w       rPlayerX(a6), d0                              ; $00E7F2
        add.w        d1, d0                                        ; $00E7F6
        move.w       rPlayerY(a6), d4                              ; $00E7F8
        add.w        d2, d4                                        ; $00E7FC
        bsr.w        TestPlayerCollision                           ; $00E7FE
        bne.w        loc_00EBD6                                    ; $00E802
        tst.b        rPlayerMovementSlowCounter(a6)                ; $00E806
        beq.b        loc_00E814                                    ; $00E80A
        subq.b       #$1, rPlayerMovementSlowCounter(a6)           ; $00E80C
        asr.w        #$3, d1                                       ; $00E810
        asr.w        #$3, d2                                       ; $00E812

loc_00E814:
        add.w        d1, rPlayerX(a6)                              ; $00E814
        add.w        d2, rPlayerY(a6)                              ; $00E818
        bra.b        loc_00E866                                    ; $00E81C

loc_00E81E:
        move.w       rPlayerX(a6), d0                              ; $00E81E
        add.w        d1, d0                                        ; $00E822
        move.w       rPlayerY(a6), d4                              ; $00E824
        bsr.w        TestPlayerCollision                           ; $00E828
        bne.b        loc_00E842                                    ; $00E82C
        tst.b        rPlayerMovementSlowCounter(a6)                ; $00E82E
        beq.b        loc_00E83C                                    ; $00E832
        subq.b       #$1, rPlayerMovementSlowCounter(a6)           ; $00E834
        asr.w        #$3, d1                                       ; $00E838
        asr.w        #$3, d2                                       ; $00E83A

loc_00E83C:
        add.w        d1, rPlayerX(a6)                              ; $00E83C
        bra.b        loc_00E866                                    ; $00E840

loc_00E842:
        move.w       rPlayerX(a6), d0                              ; $00E842
        move.w       rPlayerY(a6), d4                              ; $00E846
        add.w        d2, d4                                        ; $00E84A
        bsr.w        TestPlayerCollision                           ; $00E84C
        bne.w        loc_00EBD6                                    ; $00E850
        tst.b        rPlayerMovementSlowCounter(a6)                ; $00E854
        beq.b        loc_00E862                                    ; $00E858
        subq.b       #$1, rPlayerMovementSlowCounter(a6)           ; $00E85A
        asr.w        #$3, d1                                       ; $00E85E
        asr.w        #$3, d2                                       ; $00E860

loc_00E862:
        add.w        d2, rPlayerY(a6)                              ; $00E862

loc_00E866:
        move.w       rPlayerX(a6), d0                              ; $00E866
        move.w       d0, d1                                        ; $00E86A
        asr.w        #$8, d0                                       ; $00E86C
        move.w       rPlayerY(a6), d4                              ; $00E86E
        move.w       d4, d2                                        ; $00E872
        clr.b        d4                                            ; $00E874
        asr.w        #$3, d4                                       ; $00E876
        add.w        d4, d0                                        ; $00E878
        adda.w       d0, a1                                        ; $00E87A
        clr.w        d3                                            ; $00E87C
        tst.b        d1                                            ; $00E87E
        bmi.b        loc_00E88C                                    ; $00E880
        tst.b        d2                                            ; $00E882
        bpl.w        loc_00EB02                                    ; $00E884
        bra.w        loc_00EA32                                    ; $00E888

loc_00E88C:
        tst.b        d2                                            ; $00E88C
        bpl.w        loc_00E962                                    ; $00E88E
        move.b       $1(a1), d3                                    ; $00E892
        move.b       (a5, d3.w), d4                                ; $00E896
        move.b       $20(a1), d3                                   ; $00E89A
        move.b       (a5, d3.w), d5                                ; $00E89E
        move.b       (a1), d3                                      ; $00E8A2
        move.b       (a5, d3.w), d6                                ; $00E8A4
        move.b       $21(a1), d3                                   ; $00E8A8
        move.b       (a5, d3.w), d3                                ; $00E8AC
        bsr.w        RemapFourCellTypes                            ; $00E8B0
        cmpi.b       #$e0, d1                                      ; $00E8B4
        bcs.b        loc_00E8D0                                    ; $00E8B8
        cmpi.b       #$1, d4                                       ; $00E8BA
        beq.b        loc_00E8CC                                    ; $00E8BE
        cmpi.b       #$4, d4                                       ; $00E8C0
        beq.b        loc_00E8CC                                    ; $00E8C4
        cmpi.b       #$5, d4                                       ; $00E8C6
        bne.b        loc_00E8D0                                    ; $00E8CA

loc_00E8CC:
        move.b       #$df, d1                                      ; $00E8CC

loc_00E8D0:
        cmpi.b       #$e0, d2                                      ; $00E8D0
        bcs.b        loc_00E8EC                                    ; $00E8D4
        cmpi.b       #$1, d5                                       ; $00E8D6
        beq.b        loc_00E8E8                                    ; $00E8DA
        cmpi.b       #$2, d5                                       ; $00E8DC
        beq.b        loc_00E8E8                                    ; $00E8E0
        cmpi.b       #$5, d5                                       ; $00E8E2
        bne.b        loc_00E8EC                                    ; $00E8E6

loc_00E8E8:
        move.b       #$df, d2                                      ; $00E8E8

loc_00E8EC:
        cmpi.b       #$e0, d1                                      ; $00E8EC
        bcs.b        loc_00E918                                    ; $00E8F0
        cmpi.b       #$e0, d2                                      ; $00E8F2
        bcs.b        loc_00E918                                    ; $00E8F6
        cmpi.b       #$1, d3                                       ; $00E8F8
        beq.b        loc_00E910                                    ; $00E8FC
        cmpi.b       #$2, d3                                       ; $00E8FE
        beq.b        loc_00E910                                    ; $00E902
        cmpi.b       #$4, d3                                       ; $00E904
        beq.b        loc_00E910                                    ; $00E908
        cmpi.b       #$5, d3                                       ; $00E90A
        bne.b        loc_00E918                                    ; $00E90E

loc_00E910:
        move.b       #$df, d1                                      ; $00E910
        move.b       #$df, d2                                      ; $00E914

loc_00E918:
        cmpi.b       #$2, d6                                       ; $00E918
        bne.b        loc_00E930                                    ; $00E91C
        move.b       d2, d3                                        ; $00E91E
        subi.b       #$2d, d3                                      ; $00E920
        cmp.b        d3, d1                                        ; $00E924
        bls.w        loc_00EBCE                                    ; $00E926
        move.b       d3, d1                                        ; $00E92A
        bra.w        loc_00EBCE                                    ; $00E92C

loc_00E930:
        cmpi.b       #$4, d6                                       ; $00E930
        bne.b        loc_00E948                                    ; $00E934
        move.b       d1, d3                                        ; $00E936
        subi.b       #$2d, d3                                      ; $00E938
        cmp.b        d3, d2                                        ; $00E93C
        bls.w        loc_00EBCE                                    ; $00E93E
        move.b       d3, d2                                        ; $00E942
        bra.w        loc_00EBCE                                    ; $00E944

loc_00E948:
        cmpi.b       #$5, d6                                       ; $00E948
        bne.w        loc_00EBCE                                    ; $00E94C
        move.b       #$2d, d3                                      ; $00E950
        sub.b        d2, d3                                        ; $00E954
        cmp.b        d3, d1                                        ; $00E956
        bcc.w        loc_00EBCE                                    ; $00E958
        move.b       d3, d1                                        ; $00E95C
        bra.w        loc_00EBCE                                    ; $00E95E

loc_00E962:
        move.b       $1(a1), d3                                    ; $00E962
        move.b       (a5, d3.w), d4                                ; $00E966
        move.b       -$20(a1), d3                                  ; $00E96A
        move.b       (a5, d3.w), d5                                ; $00E96E
        move.b       (a1), d3                                      ; $00E972
        move.b       (a5, d3.w), d6                                ; $00E974
        move.b       -$1f(a1), d3                                  ; $00E978
        move.b       (a5, d3.w), d3                                ; $00E97C
        bsr.w        RemapFourCellTypes                            ; $00E980
        cmpi.b       #$e0, d1                                      ; $00E984
        bcs.b        loc_00E9A0                                    ; $00E988
        cmpi.b       #$1, d4                                       ; $00E98A
        beq.b        loc_00E99C                                    ; $00E98E
        cmpi.b       #$4, d4                                       ; $00E990
        beq.b        loc_00E99C                                    ; $00E994
        cmpi.b       #$5, d4                                       ; $00E996
        bne.b        loc_00E9A0                                    ; $00E99A

loc_00E99C:
        move.b       #$df, d1                                      ; $00E99C

loc_00E9A0:
        cmpi.b       #$1f, d2                                      ; $00E9A0
        bhi.b        loc_00E9BC                                    ; $00E9A4
        cmpi.b       #$1, d5                                       ; $00E9A6
        beq.b        loc_00E9B8                                    ; $00E9AA
        cmpi.b       #$3, d5                                       ; $00E9AC
        beq.b        loc_00E9B8                                    ; $00E9B0
        cmpi.b       #$4, d5                                       ; $00E9B2
        bne.b        loc_00E9BC                                    ; $00E9B6

loc_00E9B8:
        move.b       #$20, d2                                      ; $00E9B8

loc_00E9BC:
        cmpi.b       #$e0, d1                                      ; $00E9BC
        bcs.b        loc_00E9E8                                    ; $00E9C0
        cmpi.b       #$1f, d2                                      ; $00E9C2
        bhi.b        loc_00E9E8                                    ; $00E9C6
        cmpi.b       #$1, d3                                       ; $00E9C8
        beq.b        loc_00E9E0                                    ; $00E9CC
        cmpi.b       #$3, d3                                       ; $00E9CE
        beq.b        loc_00E9E0                                    ; $00E9D2
        cmpi.b       #$4, d3                                       ; $00E9D4
        beq.b        loc_00E9E0                                    ; $00E9D8
        cmpi.b       #$5, d3                                       ; $00E9DA
        bne.b        loc_00E9E8                                    ; $00E9DE

loc_00E9E0:
        move.b       #$df, d1                                      ; $00E9E0
        move.b       #$20, d2                                      ; $00E9E4

loc_00E9E8:
        cmpi.b       #$3, d6                                       ; $00E9E8
        bne.b        loc_00EA00                                    ; $00E9EC
        move.b       #$d3, d3                                      ; $00E9EE
        sub.b        d2, d3                                        ; $00E9F2
        cmp.b        d3, d1                                        ; $00E9F4
        bls.w        loc_00EBCE                                    ; $00E9F6
        move.b       d3, d1                                        ; $00E9FA
        bra.w        loc_00EBCE                                    ; $00E9FC

loc_00EA00:
        cmpi.b       #$5, d6                                       ; $00EA00
        bne.b        loc_00EA18                                    ; $00EA04
        move.b       #$2d, d3                                      ; $00EA06
        sub.b        d1, d3                                        ; $00EA0A
        cmp.b        d3, d2                                        ; $00EA0C
        bcc.w        loc_00EBCE                                    ; $00EA0E
        move.b       d3, d2                                        ; $00EA12
        bra.w        loc_00EBCE                                    ; $00EA14

loc_00EA18:
        cmpi.b       #$4, d6                                       ; $00EA18
        bne.w        loc_00EBCE                                    ; $00EA1C
        move.b       #$2d, d3                                      ; $00EA20
        add.b        d2, d3                                        ; $00EA24
        cmp.b        d3, d1                                        ; $00EA26
        bcc.w        loc_00EBCE                                    ; $00EA28
        move.b       d3, d1                                        ; $00EA2C
        bra.w        loc_00EBCE                                    ; $00EA2E

loc_00EA32:
        move.b       -$1(a1), d3                                   ; $00EA32
        move.b       (a5, d3.w), d4                                ; $00EA36
        move.b       $20(a1), d3                                   ; $00EA3A
        move.b       (a5, d3.w), d5                                ; $00EA3E
        move.b       (a1), d3                                      ; $00EA42
        move.b       (a5, d3.w), d6                                ; $00EA44
        move.b       $1f(a1), d3                                   ; $00EA48
        move.b       (a5, d3.w), d3                                ; $00EA4C
        bsr.w        RemapFourCellTypes                            ; $00EA50
        cmpi.b       #$1f, d1                                      ; $00EA54
        bhi.b        loc_00EA70                                    ; $00EA58
        cmpi.b       #$1, d4                                       ; $00EA5A
        beq.b        loc_00EA6C                                    ; $00EA5E
        cmpi.b       #$2, d4                                       ; $00EA60
        beq.b        loc_00EA6C                                    ; $00EA64
        cmpi.b       #$3, d4                                       ; $00EA66
        bne.b        loc_00EA70                                    ; $00EA6A

loc_00EA6C:
        move.b       #$20, d1                                      ; $00EA6C

loc_00EA70:
        cmpi.b       #$e0, d2                                      ; $00EA70
        bcs.b        loc_00EA8C                                    ; $00EA74
        cmpi.b       #$1, d5                                       ; $00EA76
        beq.b        loc_00EA88                                    ; $00EA7A
        cmpi.b       #$2, d5                                       ; $00EA7C
        beq.b        loc_00EA88                                    ; $00EA80
        cmpi.b       #$5, d5                                       ; $00EA82
        bne.b        loc_00EA8C                                    ; $00EA86

loc_00EA88:
        move.b       #$df, d2                                      ; $00EA88

loc_00EA8C:
        cmpi.b       #$1f, d1                                      ; $00EA8C
        bhi.b        loc_00EAB8                                    ; $00EA90
        cmpi.b       #$e0, d2                                      ; $00EA92
        bcs.b        loc_00EAB8                                    ; $00EA96
        cmpi.b       #$1, d3                                       ; $00EA98
        beq.b        loc_00EAB0                                    ; $00EA9C
        cmpi.b       #$2, d3                                       ; $00EA9E
        beq.b        loc_00EAB0                                    ; $00EAA2
        cmpi.b       #$3, d3                                       ; $00EAA4
        beq.b        loc_00EAB0                                    ; $00EAA8
        cmpi.b       #$5, d3                                       ; $00EAAA
        bne.b        loc_00EAB8                                    ; $00EAAE

loc_00EAB0:
        move.b       #$20, d1                                      ; $00EAB0
        move.b       #$df, d2                                      ; $00EAB4

loc_00EAB8:
        cmpi.b       #$3, d6                                       ; $00EAB8
        bne.b        loc_00EAD0                                    ; $00EABC
        move.b       #$d3, d3                                      ; $00EABE
        sub.b        d1, d3                                        ; $00EAC2
        cmp.b        d3, d2                                        ; $00EAC4
        bls.w        loc_00EBCE                                    ; $00EAC6
        move.b       d3, d2                                        ; $00EACA
        bra.w        loc_00EBCE                                    ; $00EACC

loc_00EAD0:
        cmpi.b       #$5, d6                                       ; $00EAD0
        bne.b        loc_00EAE8                                    ; $00EAD4
        move.b       #$2d, d3                                      ; $00EAD6
        sub.b        d2, d3                                        ; $00EADA
        cmp.b        d3, d1                                        ; $00EADC
        bcc.w        loc_00EBCE                                    ; $00EADE
        move.b       d3, d1                                        ; $00EAE2
        bra.w        loc_00EBCE                                    ; $00EAE4

loc_00EAE8:
        cmpi.b       #$2, d6                                       ; $00EAE8
        bne.w        loc_00EBCE                                    ; $00EAEC
        move.b       d2, d3                                        ; $00EAF0
        subi.w       #$2d, d3                                      ; $00EAF2
        cmp.b        d3, d1                                        ; $00EAF6
        bls.w        loc_00EBCE                                    ; $00EAF8
        move.b       d3, d1                                        ; $00EAFC
        bra.w        loc_00EBCE                                    ; $00EAFE

loc_00EB02:
        move.b       -$1(a1), d3                                   ; $00EB02
        move.b       (a5, d3.w), d4                                ; $00EB06
        move.b       -$20(a1), d3                                  ; $00EB0A
        move.b       (a5, d3.w), d5                                ; $00EB0E
        move.b       (a1), d3                                      ; $00EB12
        move.b       (a5, d3.w), d6                                ; $00EB14
        move.b       -$21(a1), d3                                  ; $00EB18
        move.b       (a5, d3.w), d3                                ; $00EB1C
        bsr.w        RemapFourCellTypes                            ; $00EB20
        cmpi.b       #$1f, d1                                      ; $00EB24
        bhi.b        loc_00EB40                                    ; $00EB28
        cmpi.b       #$1, d4                                       ; $00EB2A
        beq.b        loc_00EB3C                                    ; $00EB2E
        cmpi.b       #$2, d4                                       ; $00EB30
        beq.b        loc_00EB3C                                    ; $00EB34
        cmpi.b       #$3, d4                                       ; $00EB36
        bne.b        loc_00EB40                                    ; $00EB3A

loc_00EB3C:
        move.b       #$20, d1                                      ; $00EB3C

loc_00EB40:
        cmpi.b       #$1f, d2                                      ; $00EB40
        bhi.b        loc_00EB5C                                    ; $00EB44
        cmpi.b       #$1, d5                                       ; $00EB46
        beq.b        loc_00EB58                                    ; $00EB4A
        cmpi.b       #$3, d5                                       ; $00EB4C
        beq.b        loc_00EB58                                    ; $00EB50
        cmpi.b       #$4, d5                                       ; $00EB52
        bne.b        loc_00EB5C                                    ; $00EB56

loc_00EB58:
        move.b       #$20, d2                                      ; $00EB58

loc_00EB5C:
        cmpi.b       #$1f, d1                                      ; $00EB5C
        bhi.b        loc_00EB88                                    ; $00EB60
        cmpi.b       #$1f, d2                                      ; $00EB62
        bhi.b        loc_00EB88                                    ; $00EB66
        cmpi.b       #$1, d3                                       ; $00EB68
        beq.b        loc_00EB80                                    ; $00EB6C
        cmpi.b       #$2, d3                                       ; $00EB6E
        beq.b        loc_00EB80                                    ; $00EB72
        cmpi.b       #$3, d3                                       ; $00EB74
        beq.b        loc_00EB80                                    ; $00EB78
        cmpi.b       #$4, d3                                       ; $00EB7A
        bne.b        loc_00EB88                                    ; $00EB7E

loc_00EB80:
        move.b       #$20, d1                                      ; $00EB80
        move.b       #$20, d2                                      ; $00EB84

loc_00EB88:
        cmpi.b       #$2, d6                                       ; $00EB88
        bne.b        loc_00EBA0                                    ; $00EB8C
        move.b       d1, d3                                        ; $00EB8E
        addi.b       #$2d, d3                                      ; $00EB90
        cmp.b        d3, d2                                        ; $00EB94
        bcc.w        loc_00EBCE                                    ; $00EB96
        move.b       d3, d2                                        ; $00EB9A
        bra.w        loc_00EBCE                                    ; $00EB9C

loc_00EBA0:
        cmpi.b       #$4, d6                                       ; $00EBA0
        bne.b        loc_00EBB8                                    ; $00EBA4
        move.b       d2, d3                                        ; $00EBA6
        addi.b       #$2d, d3                                      ; $00EBA8
        cmp.b        d3, d1                                        ; $00EBAC
        bcc.w        loc_00EBCE                                    ; $00EBAE
        move.b       d3, d1                                        ; $00EBB2
        bra.w        loc_00EBCE                                    ; $00EBB4

loc_00EBB8:
        cmpi.b       #$3, d6                                       ; $00EBB8
        bne.w        loc_00EBCE                                    ; $00EBBC
        move.b       #$d3, d3                                      ; $00EBC0
        sub.b        d1, d3                                        ; $00EBC4
        cmp.b        d3, d2                                        ; $00EBC6
        bls.w        loc_00EBCE                                    ; $00EBC8
        move.b       d3, d2                                        ; $00EBCC

loc_00EBCE:
        move.b       d1, -$7205(a6)                                ; $00EBCE
        move.b       d2, -$7203(a6)                                ; $00EBD2

loc_00EBD6:
        jsr          UpdateMapWindowOrigin.l                       ; $00EBD6
        bra.w        DispatchPlayerCellAction                      ; $00EBDC
        ifne *-$EBE0
        fail "ROM end moved"
        endif
