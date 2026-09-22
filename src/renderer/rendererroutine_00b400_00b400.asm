; $00B400..$00B5BF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка пары граней стены/двери: bsr d232/d26e/d4e4 (проекция мира→экран через sin/cos -0x71f2/-0x71f0), задаёт указатели текстур $FF8EBA/$FF8EC2, asr делителями глубины (-0x717a/-0x7178)
        ifne *-$B400
        fail "ROM start moved"
        endif

RendererRoutine_00B400:
        addi.w       #$80, d1                                      ; $00B400
        bsr.w        RendererRoutine_00D232                        ; $00B404
        movem.w      d0-d1, -(a7)                                  ; $00B408
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B40C
        bsr.w        ProjectWallFaceOnly                           ; $00B414
        asr.w        -$717a(a6)                                    ; $00B418
        asr.w        -$7178(a6)                                    ; $00B41C
        bsr.w        DrawWallTextureSpan                           ; $00B420
        movem.w      (a7)+, d0-d1                                  ; $00B424
        move.w       (a7)+, d3                                     ; $00B428
        add.w        d3, d1                                        ; $00B42A
        add.w        d3, d1                                        ; $00B42C
        bsr.w        RendererRoutine_00D1D6                        ; $00B42E
        addi.w       #$80, d1                                      ; $00B432
        bsr.w        RendererRoutine_00D232                        ; $00B436
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B43A
        bsr.w        ProjectWallFaceOnly                           ; $00B442
        asr.w        -$717a(a6)                                    ; $00B446
        asr.w        -$7178(a6)                                    ; $00B44A
        bsr.w        DrawWallTextureSpan                           ; $00B44E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B452
        clr.w        d3                                            ; $00B456
        rts                                                        ; $00B458

loc_00B45A:
        lea.l        -$7008(a6), a3                                ; $00B45A
        cmpa.l       -$7118(a6), a3                                ; $00B45E
        beq.b        loc_00B470                                    ; $00B462

loc_00B464:
        cmpa.l       (a3)+, a0                                     ; $00B464
        beq.w        loc_00B514                                    ; $00B466
        cmpa.l       -$7118(a6), a3                                ; $00B46A
        bne.b        loc_00B464                                    ; $00B46E

loc_00B470:
        move.l       a0, (a3)+                                     ; $00B470
        move.l       a3, -$7118(a6)                                ; $00B472
        bsr.w        FindTransientWallOpeningAmount                ; $00B476
        cmpi.w       #$80, d3                                      ; $00B47A
        bne.b        loc_00B484                                    ; $00B47E
        clr.w        d3                                            ; $00B480
        rts                                                        ; $00B482

loc_00B484:
        clr.l        -$6e46(a6)                                    ; $00B484
        clr.l        -$6e42(a6)                                    ; $00B488
        clr.w        -$6e48(a6)                                    ; $00B48C
        movem.l      d0-d2/d4-d7/a0-a1/a4-a5, -(a7)                ; $00B490
        tst.w        d0                                            ; $00B494
        bmi.b        loc_00B4A6                                    ; $00B496
        bne.w        loc_00B518                                    ; $00B498
        cmpi.w       #$80, -$71e4(a6)                              ; $00B49C
        bcs.w        loc_00B518                                    ; $00B4A2

loc_00B4A6:
        add.w        rPlayerCellX(a6), d0                          ; $00B4A6
        lsl.w        #$8, d0                                       ; $00B4AA
        add.w        rPlayerCellY(a6), d1                          ; $00B4AC
        lsl.w        #$8, d1                                       ; $00B4B0
        sub.w        d3, d1                                        ; $00B4B2
        addi.w       #$80, d0                                      ; $00B4B4
        move.w       d3, -(a7)                                     ; $00B4B8
        bsr.w        RendererRoutine_00D232                        ; $00B4BA
        addi.w       #$80, d1                                      ; $00B4BE
        bsr.w        RendererRoutine_00D1D6                        ; $00B4C2
        movem.w      d0-d1, -(a7)                                  ; $00B4C6
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B4CA
        bsr.w        ProjectWallFaceOnly                           ; $00B4D2
        asr.w        -$717a(a6)                                    ; $00B4D6
        asr.w        -$7178(a6)                                    ; $00B4DA
        bsr.w        DrawWallTextureSpan                           ; $00B4DE
        movem.w      (a7)+, d0-d1                                  ; $00B4E2
        move.w       (a7)+, d3                                     ; $00B4E6
        add.w        d3, d1                                        ; $00B4E8
        add.w        d3, d1                                        ; $00B4EA
        bsr.w        RendererRoutine_00D232                        ; $00B4EC
        addi.w       #$80, d1                                      ; $00B4F0
        bsr.w        RendererRoutine_00D1D6                        ; $00B4F4
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B4F8
        bsr.w        ProjectWallFaceOnly                           ; $00B500
        asr.w        -$717a(a6)                                    ; $00B504
        asr.w        -$7178(a6)                                    ; $00B508
        bsr.w        DrawWallTextureSpan                           ; $00B50C
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B510

loc_00B514:
        clr.w        d3                                            ; $00B514
        rts                                                        ; $00B516

loc_00B518:
        add.w        rPlayerCellX(a6), d0                          ; $00B518
        lsl.w        #$8, d0                                       ; $00B51C
        add.w        rPlayerCellY(a6), d1                          ; $00B51E
        lsl.w        #$8, d1                                       ; $00B522
        sub.w        d3, d1                                        ; $00B524
        addi.w       #$80, d0                                      ; $00B526
        move.w       d3, -(a7)                                     ; $00B52A
        bsr.w        RendererRoutine_00D1D6                        ; $00B52C
        addi.w       #$80, d1                                      ; $00B530
        bsr.w        RendererRoutine_00D232                        ; $00B534
        movem.w      d0-d1, -(a7)                                  ; $00B538
        move.l       #$ff8f2a, rCurrentWallTilePair(a6)            ; $00B53C
        bsr.w        ProjectWallFaceOnly                           ; $00B544
        asr.w        -$717a(a6)                                    ; $00B548
        asr.w        -$7178(a6)                                    ; $00B54C
        bsr.w        DrawWallTextureSpan                           ; $00B550
        movem.w      (a7)+, d0-d1                                  ; $00B554
        move.w       (a7)+, d3                                     ; $00B558
        add.w        d3, d1                                        ; $00B55A
        add.w        d3, d1                                        ; $00B55C
        bsr.w        RendererRoutine_00D1D6                        ; $00B55E
        addi.w       #$80, d1                                      ; $00B562
        bsr.w        RendererRoutine_00D232                        ; $00B566
        move.l       #$ff8f32, rCurrentWallTilePair(a6)            ; $00B56A
        bsr.w        ProjectWallFaceOnly                           ; $00B572
        asr.w        -$717a(a6)                                    ; $00B576
        asr.w        -$7178(a6)                                    ; $00B57A
        bsr.w        DrawWallTextureSpan                           ; $00B57E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B582
        clr.w        d3                                            ; $00B586
        rts                                                        ; $00B588

loc_00B58A:
        lea.l        -$7030(a6), a3                                ; $00B58A
        cmpa.l       -$711c(a6), a3                                ; $00B58E
        beq.b        loc_00B5A0                                    ; $00B592

loc_00B594:
        cmpa.l       (a3)+, a0                                     ; $00B594
        beq.w        loc_00B644                                    ; $00B596
        cmpa.l       -$711c(a6), a3                                ; $00B59A
        bne.b        loc_00B594                                    ; $00B59E

loc_00B5A0:
        move.l       a0, (a3)+                                     ; $00B5A0
        move.l       a3, -$711c(a6)                                ; $00B5A2
        clr.l        -$6e46(a6)                                    ; $00B5A6
        clr.l        -$6e42(a6)                                    ; $00B5AA
        clr.w        -$6e48(a6)                                    ; $00B5AE
        bsr.w        FindTransientWallOpeningAmount                ; $00B5B2
        cmpi.w       #$80, d3                                      ; $00B5B6
        bne.b        RendererRoutine_00B5C0                        ; $00B5BA
        clr.w        d3                                            ; $00B5BC
        rts                                                        ; $00B5BE
        ifne *-$B5C0
        fail "ROM end moved"
        endif
