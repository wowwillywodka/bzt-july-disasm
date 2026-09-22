; $00C3AA..$00C71B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Трассировка луча в одном из 8 октантов: по углу D0 (пороги 0x80/0x100/0x180) выбирает ветку обхода клеток сетки (шаг ±1 / ±0x20 = ряд), читает celltype через таблицу (0x24EA,A6), при встрече стены (тип>=6 или 0x8B50) формирует запись грани и переходит к отрисовщику (0xD016/0xCEA6/...)
        ifne *-$C3AA
        fail "ROM start moved"
        endif

RendererRoutine_00C3AA:
        clr.l        -$6e46(a6)                                    ; $00C3AA
        clr.l        -$6e42(a6)                                    ; $00C3AE
        clr.w        -$6e48(a6)                                    ; $00C3B2
        clr.w        -$715a(a6)                                    ; $00C3B6
        lea.l        rCellTypeByIndex(a6), a5                      ; $00C3BA
        clr.w        d3                                            ; $00C3BE
        cmpi.w       #$100, d0                                     ; $00C3C0
        bcs.b        loc_00C3DA                                    ; $00C3C4
        beq.w        loc_00C48C                                    ; $00C3C6
        cmpi.w       #$180, d0                                     ; $00C3CA
        bcs.w        loc_00CC64                                    ; $00C3CE
        bhi.w        loc_00CA60                                    ; $00C3D2
        bra.w        loc_00C5C0                                    ; $00C3D6

loc_00C3DA:
        cmpi.w       #$80, d0                                      ; $00C3DA
        bhi.w        loc_00C658                                    ; $00C3DE
        beq.w        loc_00C528                                    ; $00C3E2
        tst.w        d0                                            ; $00C3E6
        bne.w        loc_00C85C                                    ; $00C3E8
        bra.w        loc_00C3F0                                    ; $00C3EC

loc_00C3F0:
        clr.w        d0                                            ; $00C3F0
        clr.w        d1                                            ; $00C3F2
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C3F4
        move.b       (a0), d3                                      ; $00C3F8
        beq.b        loc_00C41A                                    ; $00C3FA
        move.b       (a5, d3.w), d3                                ; $00C3FC
        beq.b        loc_00C41A                                    ; $00C400

loc_00C402:
        cmpi.b       #$2, d3                                       ; $00C402
        beq.b        loc_00C43E                                    ; $00C406
        cmpi.b       #$5, d3                                       ; $00C408
        beq.b        loc_00C43E                                    ; $00C40C
        cmpi.b       #$6, d3                                       ; $00C40E
        bcs.b        loc_00C41A                                    ; $00C412
        bsr.w        DispatchVisibleCell                           ; $00C414
        bne.b        loc_00C402                                    ; $00C418

loc_00C41A:
        move.w       #$20, d2                                      ; $00C41A
        suba.w       d2, a0                                        ; $00C41E
        subq.w       #$1, d1                                       ; $00C420
        cmp.w        -$71a4(a6), d1                                ; $00C422
        blt.b        loc_00C48A                                    ; $00C426

loc_00C428:
        move.b       (a0), d3                                      ; $00C428
        beq.b        loc_00C480                                    ; $00C42A
        move.b       (a5, d3.w), d3                                ; $00C42C
        beq.b        loc_00C480                                    ; $00C430
        cmpi.b       #$6, d3                                       ; $00C432
        bcs.b        loc_00C43E                                    ; $00C436
        bsr.w        DispatchVisibleCell                           ; $00C438
        beq.b        loc_00C480                                    ; $00C43C

loc_00C43E:
        cmpa.l       -$715e(a6), a0                                ; $00C43E
        beq.b        loc_00C48A                                    ; $00C442
        move.l       a0, -$715e(a6)                                ; $00C444
        add.w        rPlayerCellX(a6), d0                          ; $00C448
        lsl.w        #$8, d0                                       ; $00C44C
        add.w        rPlayerCellY(a6), d1                          ; $00C44E
        lsl.w        #$8, d1                                       ; $00C452
        clr.w        d4                                            ; $00C454
        move.b       (a0), d4                                      ; $00C456
        lsl.w        #$3, d4                                       ; $00C458
        lea.l        rTextureOrder(a6), a2                         ; $00C45A
        adda.w       d4, a2                                        ; $00C45E
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C460
        move.l       a0, -$42a2(a6)                                ; $00C464
        cmpi.b       #$2, d3                                       ; $00C468
        bne.b        loc_00C472                                    ; $00C46C
        bra.w        RendererRoutine_00D016                        ; $00C46E

loc_00C472:
        cmpi.b       #$5, d3                                       ; $00C472
        bne.b        loc_00C47C                                    ; $00C476
        bra.w        RendererRoutine_00D082                        ; $00C478

loc_00C47C:
        bra.w        RendererRoutine_00CEA6                        ; $00C47C

loc_00C480:
        suba.w       d2, a0                                        ; $00C480
        subq.w       #$1, d1                                       ; $00C482
        cmp.w        -$71a4(a6), d1                                ; $00C484
        bge.b        loc_00C428                                    ; $00C488

loc_00C48A:
        rts                                                        ; $00C48A

loc_00C48C:
        clr.w        d0                                            ; $00C48C
        clr.w        d1                                            ; $00C48E
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C490
        move.b       (a0), d3                                      ; $00C494
        beq.b        loc_00C4B6                                    ; $00C496
        move.b       (a5, d3.w), d3                                ; $00C498
        beq.b        loc_00C4B6                                    ; $00C49C

loc_00C49E:
        cmpi.b       #$3, d3                                       ; $00C49E
        beq.b        loc_00C4DA                                    ; $00C4A2
        cmpi.b       #$4, d3                                       ; $00C4A4
        beq.b        loc_00C4DA                                    ; $00C4A8
        cmpi.b       #$6, d3                                       ; $00C4AA
        bcs.b        loc_00C4B6                                    ; $00C4AE
        bsr.w        DispatchVisibleCell                           ; $00C4B0
        bne.b        loc_00C49E                                    ; $00C4B4

loc_00C4B6:
        move.w       #$20, d2                                      ; $00C4B6
        adda.w       d2, a0                                        ; $00C4BA
        addq.w       #$1, d1                                       ; $00C4BC
        cmp.w        -$71a2(a6), d1                                ; $00C4BE
        bgt.b        loc_00C526                                    ; $00C4C2

loc_00C4C4:
        move.b       (a0), d3                                      ; $00C4C4
        beq.b        loc_00C51C                                    ; $00C4C6
        move.b       (a5, d3.w), d3                                ; $00C4C8
        beq.b        loc_00C51C                                    ; $00C4CC
        cmpi.b       #$6, d3                                       ; $00C4CE
        bcs.b        loc_00C4DA                                    ; $00C4D2
        bsr.w        DispatchVisibleCell                           ; $00C4D4
        beq.b        loc_00C51C                                    ; $00C4D8

loc_00C4DA:
        cmpa.l       -$715e(a6), a0                                ; $00C4DA
        beq.b        loc_00C526                                    ; $00C4DE
        move.l       a0, -$715e(a6)                                ; $00C4E0
        add.w        rPlayerCellX(a6), d0                          ; $00C4E4
        lsl.w        #$8, d0                                       ; $00C4E8
        add.w        rPlayerCellY(a6), d1                          ; $00C4EA
        lsl.w        #$8, d1                                       ; $00C4EE
        clr.w        d4                                            ; $00C4F0
        move.b       (a0), d4                                      ; $00C4F2
        lsl.w        #$3, d4                                       ; $00C4F4
        lea.l        rTextureOrder(a6), a2                         ; $00C4F6
        adda.w       d4, a2                                        ; $00C4FA
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C4FC
        move.l       a0, -$42a2(a6)                                ; $00C500
        cmpi.b       #$3, d3                                       ; $00C504
        bne.b        loc_00C50E                                    ; $00C508
        bra.w        RendererRoutine_00D0F2                        ; $00C50A

loc_00C50E:
        cmpi.b       #$4, d3                                       ; $00C50E
        bne.b        loc_00C518                                    ; $00C512
        bra.w        RendererRoutine_00CFAC                        ; $00C514

loc_00C518:
        bra.w        RendererRoutine_00CE68                        ; $00C518

loc_00C51C:
        adda.w       d2, a0                                        ; $00C51C
        addq.w       #$1, d1                                       ; $00C51E
        cmp.w        -$71a2(a6), d1                                ; $00C520
        ble.b        loc_00C4C4                                    ; $00C524

loc_00C526:
        rts                                                        ; $00C526

loc_00C528:
        clr.w        d0                                            ; $00C528
        clr.w        d1                                            ; $00C52A
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C52C
        move.b       (a0), d3                                      ; $00C530
        beq.b        loc_00C552                                    ; $00C532
        move.b       (a5, d3.w), d3                                ; $00C534
        beq.b        loc_00C552                                    ; $00C538

loc_00C53A:
        cmpi.b       #$2, d3                                       ; $00C53A
        beq.b        loc_00C572                                    ; $00C53E
        cmpi.b       #$3, d3                                       ; $00C540
        beq.b        loc_00C572                                    ; $00C544
        cmpi.b       #$6, d3                                       ; $00C546
        bcs.b        loc_00C552                                    ; $00C54A
        bsr.w        DispatchVisibleCell                           ; $00C54C
        bne.b        loc_00C53A                                    ; $00C550

loc_00C552:
        addq.w       #$1, a0                                       ; $00C552
        addq.w       #$1, d0                                       ; $00C554
        cmp.w        -$71a0(a6), d0                                ; $00C556
        bgt.b        loc_00C5BE                                    ; $00C55A

loc_00C55C:
        move.b       (a0), d3                                      ; $00C55C
        beq.b        loc_00C5B4                                    ; $00C55E
        move.b       (a5, d3.w), d3                                ; $00C560
        beq.b        loc_00C5B4                                    ; $00C564
        cmpi.b       #$6, d3                                       ; $00C566
        bcs.b        loc_00C572                                    ; $00C56A
        bsr.w        DispatchVisibleCell                           ; $00C56C
        beq.b        loc_00C5B4                                    ; $00C570

loc_00C572:
        cmpa.l       -$715e(a6), a0                                ; $00C572
        beq.b        loc_00C5BE                                    ; $00C576
        move.l       a0, -$715e(a6)                                ; $00C578
        add.w        rPlayerCellX(a6), d0                          ; $00C57C
        lsl.w        #$8, d0                                       ; $00C580
        add.w        rPlayerCellY(a6), d1                          ; $00C582
        lsl.w        #$8, d1                                       ; $00C586
        clr.w        d4                                            ; $00C588
        move.b       (a0), d4                                      ; $00C58A
        lsl.w        #$3, d4                                       ; $00C58C
        lea.l        rTextureOrder(a6), a2                         ; $00C58E
        adda.w       d4, a2                                        ; $00C592
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C594
        move.l       a0, -$42a2(a6)                                ; $00C598
        cmpi.b       #$2, d3                                       ; $00C59C
        bne.b        loc_00C5A6                                    ; $00C5A0
        bra.w        RendererRoutine_00D016                        ; $00C5A2

loc_00C5A6:
        cmpi.b       #$3, d3                                       ; $00C5A6
        bne.b        loc_00C5B0                                    ; $00C5AA
        bra.w        RendererRoutine_00D0F2                        ; $00C5AC

loc_00C5B0:
        bra.w        RendererRoutine_00CEEA                        ; $00C5B0

loc_00C5B4:
        addq.w       #$1, a0                                       ; $00C5B4
        addq.w       #$1, d0                                       ; $00C5B6
        cmp.w        -$71a0(a6), d0                                ; $00C5B8
        ble.b        loc_00C55C                                    ; $00C5BC

loc_00C5BE:
        rts                                                        ; $00C5BE

loc_00C5C0:
        clr.w        d0                                            ; $00C5C0
        clr.w        d1                                            ; $00C5C2
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C5C4
        move.b       (a0), d3                                      ; $00C5C8
        beq.b        loc_00C5EA                                    ; $00C5CA
        move.b       (a5, d3.w), d3                                ; $00C5CC
        beq.b        loc_00C5EA                                    ; $00C5D0

loc_00C5D2:
        cmpi.b       #$4, d3                                       ; $00C5D2
        beq.b        loc_00C60A                                    ; $00C5D6
        cmpi.b       #$5, d3                                       ; $00C5D8
        beq.b        loc_00C60A                                    ; $00C5DC
        cmpi.b       #$6, d3                                       ; $00C5DE
        bcs.b        loc_00C5EA                                    ; $00C5E2
        bsr.w        DispatchVisibleCell                           ; $00C5E4
        bne.b        loc_00C5D2                                    ; $00C5E8

loc_00C5EA:
        subq.w       #$1, a0                                       ; $00C5EA
        subq.w       #$1, d0                                       ; $00C5EC
        cmp.w        -$719e(a6), d0                                ; $00C5EE
        blt.b        loc_00C656                                    ; $00C5F2

loc_00C5F4:
        move.b       (a0), d3                                      ; $00C5F4
        beq.b        loc_00C64C                                    ; $00C5F6
        move.b       (a5, d3.w), d3                                ; $00C5F8
        beq.b        loc_00C64C                                    ; $00C5FC
        cmpi.b       #$6, d3                                       ; $00C5FE
        bcs.b        loc_00C60A                                    ; $00C602
        bsr.w        DispatchVisibleCell                           ; $00C604
        beq.b        loc_00C64C                                    ; $00C608

loc_00C60A:
        cmpa.l       -$715e(a6), a0                                ; $00C60A
        beq.b        loc_00C656                                    ; $00C60E
        move.l       a0, -$715e(a6)                                ; $00C610
        add.w        rPlayerCellX(a6), d0                          ; $00C614
        lsl.w        #$8, d0                                       ; $00C618
        add.w        rPlayerCellY(a6), d1                          ; $00C61A
        lsl.w        #$8, d1                                       ; $00C61E
        clr.w        d4                                            ; $00C620
        move.b       (a0), d4                                      ; $00C622
        lsl.w        #$3, d4                                       ; $00C624
        lea.l        rTextureOrder(a6), a2                         ; $00C626
        adda.w       d4, a2                                        ; $00C62A
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00C62C
        move.l       a0, -$42a2(a6)                                ; $00C630
        cmpi.b       #$4, d3                                       ; $00C634
        bne.b        loc_00C63E                                    ; $00C638
        bra.w        RendererRoutine_00CFAC                        ; $00C63A

loc_00C63E:
        cmpi.b       #$5, d3                                       ; $00C63E
        bne.b        loc_00C648                                    ; $00C642
        bra.w        RendererRoutine_00D082                        ; $00C644

loc_00C648:
        bra.w        RendererRoutine_00CF2A                        ; $00C648

loc_00C64C:
        subq.w       #$1, a0                                       ; $00C64C
        subq.w       #$1, d0                                       ; $00C64E
        cmp.w        -$719e(a6), d0                                ; $00C650
        bge.b        loc_00C5F4                                    ; $00C654

loc_00C656:
        rts                                                        ; $00C656

loc_00C658:
        lea.l        RaySlopePairs(pc), a4                         ; $00C658
        lsl.w        #$2, d0                                       ; $00C65C
        adda.w       d0, a4                                        ; $00C65E
        move.w       #$ff, d7                                      ; $00C660
        clr.w        d0                                            ; $00C664
        clr.w        d1                                            ; $00C666
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C668
        clr.w        d3                                            ; $00C66C
        move.b       (a0), d3                                      ; $00C66E
        move.b       (a5, d3.w), d3                                ; $00C670
        cmpi.b       #$3, d3                                       ; $00C674
        beq.w        loc_00D0B4                                    ; $00C678
        move.w       -$71e8(a6), d2                                ; $00C67C
        mulu.w       (a4), d2                                      ; $00C680
        lsr.l        #$8, d2                                       ; $00C682
        add.w        -$71e2(a6), d2                                ; $00C684
        cmp.w        d7, d2                                        ; $00C688
        bhi.b        loc_00C694                                    ; $00C68A
        cmpi.b       #$2, d3                                       ; $00C68C
        beq.w        loc_00CFD8                                    ; $00C690

loc_00C694:
        move.w       -$71e6(a6), d6                                ; $00C694
        mulu.w       $2(a4), d6                                    ; $00C698
        lsr.l        #$8, d6                                       ; $00C69C
        add.w        -$71e4(a6), d6                                ; $00C69E
        cmp.w        d7, d6                                        ; $00C6A2
        bhi.b        loc_00C6AE                                    ; $00C6A4
        cmpi.b       #$4, d3                                       ; $00C6A6
        beq.w        loc_00CF6E                                    ; $00C6AA

loc_00C6AE:
        move.w       d0, d4                                        ; $00C6AE
        move.w       d1, d5                                        ; $00C6B0
        movea.l      a0, a1                                        ; $00C6B2
        addq.w       #$1, a0                                       ; $00C6B4
        addq.w       #$1, d0                                       ; $00C6B6
        adda.w       #$20, a1                                      ; $00C6B8
        addq.w       #$1, d5                                       ; $00C6BC
        cmp.w        d7, d2                                        ; $00C6BE
        bls.b        loc_00C6CE                                    ; $00C6C0
        move.w       d2, d3                                        ; $00C6C2
        and.w        d7, d2                                        ; $00C6C4
        lsr.w        #$8, d3                                       ; $00C6C6
        add.w        d3, d1                                        ; $00C6C8
        lsl.w        #$5, d3                                       ; $00C6CA
        adda.w       d3, a0                                        ; $00C6CC

loc_00C6CE:
        cmp.w        d7, d6                                        ; $00C6CE
        bls.b        loc_00C6DC                                    ; $00C6D0
        move.w       d6, d3                                        ; $00C6D2
        and.w        d7, d6                                        ; $00C6D4
        lsr.w        #$8, d3                                       ; $00C6D6
        add.w        d3, d4                                        ; $00C6D8
        adda.w       d3, a1                                        ; $00C6DA

loc_00C6DC:
        cmp.w        d4, d0                                        ; $00C6DC
        blt.b        loc_00C6E6                                    ; $00C6DE
        bgt.b        loc_00C700                                    ; $00C6E0
        cmp.w        d5, d1                                        ; $00C6E2
        bge.b        loc_00C700                                    ; $00C6E4

loc_00C6E6:
        cmp.w        -$71a0(a6), d0                                ; $00C6E6
        bgt.b        loc_00C71A                                    ; $00C6EA
        cmp.w        -$71a2(a6), d1                                ; $00C6EC
        bgt.b        loc_00C71A                                    ; $00C6F0
        move.b       (a0), d3                                      ; $00C6F2
        beq.b        loc_00C6FC                                    ; $00C6F4
        bsr.b        RendererRoutine_00C74E                        ; $00C6F6
        bne.w        loc_00C7C2                                    ; $00C6F8

loc_00C6FC:
        bsr.b        RayStepPositiveX                              ; $00C6FC
        bra.b        loc_00C6DC                                    ; $00C6FE

loc_00C700:
        cmp.w        -$71a0(a6), d4                                ; $00C700
        bgt.b        loc_00C71A                                    ; $00C704
        cmp.w        -$71a2(a6), d5                                ; $00C706
        bgt.b        loc_00C71A                                    ; $00C70A
        move.b       (a1), d3                                      ; $00C70C
        beq.b        loc_00C716                                    ; $00C70E
        bsr.b        RendererRoutine_00C77E                        ; $00C710
        bne.w        loc_00C7F2                                    ; $00C712

loc_00C716:
        bsr.b        RayStepPositiveY                              ; $00C716
        bra.b        loc_00C6DC                                    ; $00C718

loc_00C71A:
        rts                                                        ; $00C71A
        ifne *-$C71C
        fail "ROM end moved"
        endif
