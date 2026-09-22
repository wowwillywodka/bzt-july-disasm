; $0013E0..$00179D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Gameplay iteration: train/background, legacy objective messages, VBlank/video, input/pause, player/link, actors, renderer, inventory/HUD, exit/death. Internal loop entry, not an independent ABI.
        ifne *-$13E0
        fail "ROM start moved"
        endif

RunGameplayIteration:
; Gameplay iteration: train/background, legacy objective messages, VBlank/video, input/pause, player/link, actors, renderer, inventory/HUD, exit/death. Internal loop entry, not an independent ABI.
        jsr          UpdateEpisodeTrain.l                          ; $0013E0
        cmpi.b       #$0, -$438f(a6)                               ; $0013E6
        beq.b        loc_001402                                    ; $0013EC
        move.l       #$40000010, VDP_CONTROL.l                     ; $0013EE
        move.w       #$ffe0, VDP_DATA.l                            ; $0013F8
        bra.b        loc_00144E                                    ; $001400

loc_001402:
        addq.w       #$1, -$42f8(a6)                               ; $001402
        cmpi.w       #$3, -$42f8(a6)                               ; $001406
        bne.w        loc_00144E                                    ; $00140C
        addq.w       #$1, -$42f2(a6)                               ; $001410
        clr.w        -$42f8(a6)                                    ; $001414
        move.l       #$40000010, VDP_CONTROL.l                     ; $001418
        movea.l      #VDP_DATA, a4                                 ; $001422
        move.w       -$42f4(a6), (a4)                              ; $001428
        move.w       -$42f4(a6), d0                                ; $00142C
        add.w        -$42f6(a6), d0                                ; $001430
        move.w       d0, -$42f4(a6)                                ; $001434
        cmpi.w       #$ffe2, -$42f4(a6)                            ; $001438
        beq.b        loc_00144A                                    ; $00143E
        cmpi.w       #$ffde, -$42f4(a6)                            ; $001440
        beq.b        loc_00144A                                    ; $001446
        bra.b        loc_00144E                                    ; $001448

loc_00144A:
        neg.w        -$42f6(a6)                                    ; $00144A

loc_00144E:
        tst.w        rFloorClearMessageTimer(a6)                   ; $00144E
        bne.b        loc_001464                                    ; $001452
        move.w       rGameTick(a6), d0                             ; $001454
        andi.w       #$3f, d0                                      ; $001458
        bne.b        loc_001464                                    ; $00145C
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $00145E

loc_001464:
        tst.w        -$559c(a6)                                    ; $001464
        bne.b        loc_001470                                    ; $001468
        jsr          loc_0021A0.l                                  ; $00146A

loc_001470:
        jsr          UpdateStatusMessages.l                        ; $001470
        move.w       #$2, -$7ffe(a6)                               ; $001476
        move.w       -$71ee(a6), d2                                ; $00147C
        movea.l      #VDP_DATA, a4                                 ; $001480
        neg.w        d2                                            ; $001486
        lsl.w        #$1, d2                                       ; $001488
        cmpi.w       #$0, rGeometryEpisode(a6)                     ; $00148A
        bne.b        loc_001496                                    ; $001490
        add.w        -$42f2(a6), d2                                ; $001492

loc_001496:
        andi.w       #$3ff, d2                                     ; $001496
        movea.l      #VDP_DATA, a4                                 ; $00149A
        cmp.w        -$71d0(a6), d2                                ; $0014A0
        beq.w        loc_001662                                    ; $0014A4
        move.w       -$71d0(a6), d1                                ; $0014A8
        move.w       d2, -$71d0(a6)                                ; $0014AC
        sub.w        d2, d1                                        ; $0014B0
        lsl.w        #$6, d1                                       ; $0014B2
        asr.w        #$6, d1                                       ; $0014B4
        bpl.b        loc_001516                                    ; $0014B6
        sub.w        d1, -$6f4c(a6)                                ; $0014B8
        sub.w        d1, -$6f4c(a6)                                ; $0014BC
        add.w        d1, -$7212(a6)                                ; $0014C0
        bpl.b        loc_0014D4                                    ; $0014C4
        addi.w       #$20, -$7212(a6)                              ; $0014C6
        subq.w       #$8, -$7214(a6)                               ; $0014CC
        clr.w        d3                                            ; $0014D0
        bra.b        loc_001538                                    ; $0014D2

loc_0014D4:
        move.w       rVBlankCounter(a6), d0                        ; $0014D4

loc_0014D8:
        cmp.w        rVBlankCounter(a6), d0                        ; $0014D8
        beq.b        loc_0014D8                                    ; $0014DC
        move.w       sr, -(a7)                                     ; $0014DE
        move.w       #$2700, sr                                    ; $0014E0
        move.l       #$7c000002, VDP_CONTROL.l                     ; $0014E4
        addi.w       #$10, d2                                      ; $0014EE
        move.w       d2, (a4)                                      ; $0014F2
        move.w       rCurrentFloor(a6), d2                         ; $0014F4
        lsl.w        #$2, d2                                       ; $0014F8
        move.w       -$6e4c(a6), d0                                ; $0014FA
        asr.w        #$5, d0                                       ; $0014FE
        add.w        d0, d2                                        ; $001500
        subi.w       #$20, d2                                      ; $001502
        move.l       #$40000010, VDP_CONTROL.l                     ; $001506
        move.w       (a7)+, sr                                     ; $001510
        bra.w        loc_001688                                    ; $001512

loc_001516:
        sub.w        d1, -$6f4c(a6)                                ; $001516
        sub.w        d1, -$6f4c(a6)                                ; $00151A
        add.w        d1, -$7212(a6)                                ; $00151E
        cmpi.w       #$20, -$7212(a6)                              ; $001522
        blt.b        loc_0014D4                                    ; $001528
        subi.w       #$20, -$7212(a6)                              ; $00152A
        addq.w       #$8, -$7214(a6)                               ; $001530
        move.w       #$48, d3                                      ; $001534

loc_001538:
        move.w       rVBlankCounter(a6), d0                        ; $001538

loc_00153C:
        cmp.w        rVBlankCounter(a6), d0                        ; $00153C
        beq.b        loc_00153C                                    ; $001540
        move.w       sr, -(a7)                                     ; $001542
        move.w       #$2700, sr                                    ; $001544
        move.l       #$7c000002, VDP_CONTROL.l                     ; $001548
        addi.w       #$10, d2                                      ; $001552
        move.w       d2, (a4)                                      ; $001556
        move.w       rCurrentFloor(a6), d2                         ; $001558
        lsl.w        #$2, d2                                       ; $00155C
        move.w       -$6e4c(a6), d0                                ; $00155E
        asr.w        #$5, d0                                       ; $001562
        add.w        d0, d2                                        ; $001564
        subi.w       #$20, d2                                      ; $001566
        move.l       #$40000010, VDP_CONTROL.l                     ; $00156A
        move.w       #$3, d7                                       ; $001574
        move.w       #$8f80, VDP_CONTROL.l                         ; $001578

loc_001580:
        move.w       d3, d4                                        ; $001580
        add.w        -$7214(a6), d4                                ; $001582
        movea.l      -$5598(a6), a0                                ; $001586
        andi.w       #$ff, d4                                      ; $00158A
        adda.w       d4, a0                                        ; $00158E
        andi.w       #$7f, d4                                      ; $001590
        addi.w       #$e000, d4                                    ; $001594
        move.w       d4, d0                                        ; $001598
        move.w       d0, d1                                        ; $00159A
        andi.w       #$3fff, d1                                    ; $00159C
        ori.w        #$4000, d1                                    ; $0015A0
        swap         d1                                            ; $0015A4
        lsr.w        #$8, d0                                       ; $0015A6
        lsr.w        #$6, d0                                       ; $0015A8
        move.w       d0, d1                                        ; $0015AA
        move.l       d1, VDP_CONTROL.l                             ; $0015AC
        move.w       (a0), d4                                      ; $0015B2
        addi.w       #$4141, d4                                    ; $0015B4
        move.w       d4, (a4)                                      ; $0015B8
        move.w       $100(a0), d4                                  ; $0015BA
        addi.w       #$4141, d4                                    ; $0015BE
        move.w       d4, (a4)                                      ; $0015C2
        move.w       $200(a0), d4                                  ; $0015C4
        addi.w       #$4141, d4                                    ; $0015C8
        move.w       d4, (a4)                                      ; $0015CC
        move.w       $300(a0), d4                                  ; $0015CE
        addi.w       #$4141, d4                                    ; $0015D2
        move.w       d4, (a4)                                      ; $0015D6
        move.w       $400(a0), d4                                  ; $0015D8
        addi.w       #$4141, d4                                    ; $0015DC
        move.w       d4, (a4)                                      ; $0015E0
        move.w       $500(a0), d4                                  ; $0015E2
        addi.w       #$4141, d4                                    ; $0015E6
        move.w       d4, (a4)                                      ; $0015EA
        move.w       $600(a0), d4                                  ; $0015EC
        addi.w       #$4141, d4                                    ; $0015F0
        move.w       d4, (a4)                                      ; $0015F4
        move.w       $700(a0), d4                                  ; $0015F6
        addi.w       #$4141, d4                                    ; $0015FA
        move.w       d4, (a4)                                      ; $0015FE
        move.w       $800(a0), d4                                  ; $001600
        addi.w       #$4141, d4                                    ; $001604
        move.w       d4, (a4)                                      ; $001608
        move.w       $900(a0), d4                                  ; $00160A
        addi.w       #$4141, d4                                    ; $00160E
        move.w       d4, (a4)                                      ; $001612
        move.w       $a00(a0), d4                                  ; $001614
        addi.w       #$4141, d4                                    ; $001618
        move.w       d4, (a4)                                      ; $00161C
        move.w       $b00(a0), d4                                  ; $00161E
        addi.w       #$4141, d4                                    ; $001622
        move.w       d4, (a4)                                      ; $001626
        move.w       $c00(a0), d4                                  ; $001628
        addi.w       #$4141, d4                                    ; $00162C
        move.w       d4, (a4)                                      ; $001630
        move.w       $d00(a0), d4                                  ; $001632
        addi.w       #$4141, d4                                    ; $001636
        move.w       d4, (a4)                                      ; $00163A
        move.w       $e00(a0), d4                                  ; $00163C
        addi.w       #$4141, d4                                    ; $001640
        move.w       d4, (a4)                                      ; $001644
        move.w       $f00(a0), d4                                  ; $001646
        addi.w       #$4141, d4                                    ; $00164A
        move.w       d4, (a4)                                      ; $00164E
        addq.w       #$2, d3                                       ; $001650
        dbra         d7, loc_001580                                ; $001652
        move.w       #$8f02, VDP_CONTROL.l                         ; $001656
        move.w       (a7)+, sr                                     ; $00165E
        bra.b        loc_001688                                    ; $001660

loc_001662:
        move.w       rVBlankCounter(a6), d0                        ; $001662

loc_001666:
        cmp.w        rVBlankCounter(a6), d0                        ; $001666
        beq.b        loc_001666                                    ; $00166A
        move.w       sr, -(a7)                                     ; $00166C
        move.w       #$2700, sr                                    ; $00166E
        move.w       rCurrentFloor(a6), d2                         ; $001672
        lsl.w        #$2, d2                                       ; $001676
        move.w       -$6e4c(a6), d0                                ; $001678
        asr.w        #$5, d0                                       ; $00167C
        add.w        d0, d2                                        ; $00167E
        subi.w       #$20, d2                                      ; $001680
        move.w       d2, (a4)                                      ; $001684
        move.w       (a7)+, sr                                     ; $001686

loc_001688:
        tst.w        -$792c(a6)                                    ; $001688
        beq.b        loc_00169C                                    ; $00168C
        subq.w       #$1, -$792c(a6)                               ; $00168E
        bne.b        loc_00169C                                    ; $001692
        move.w       #$8164, VDP_CONTROL.l                         ; $001694

loc_00169C:
        bsr.w        FlushDmaQueue                                 ; $00169C
        bsr.w        UpdateDemoInput                               ; $0016A0
        move.w       #$1, -$7fbe(a6)                               ; $0016A4
        lea.l        -$7fbc(a6), a0                                ; $0016AA
        move.l       a0, -$7fc2(a6)                                ; $0016AE
        jsr          AnimateWorldTextures.l                        ; $0016B2
        btst.b       #$7, rControllerState(a6)                     ; $0016B8
        beq.b        loc_0016E2                                    ; $0016BE
        btst.b       #$7, rPreviousControllerState(a6)             ; $0016C0
        bne.b        loc_0016E2                                    ; $0016C6
        bset.b       #$0, rPauseFlags(a6)                          ; $0016C8
        tst.w        rLinkRole(a6)                                 ; $0016CE
        beq.b        loc_0016E2                                    ; $0016D2
        lea.l        -$6fdc(a6), a0                                ; $0016D4
        move.b       #$14, (a0)                                    ; $0016D8
        jsr          QueueLinkCommand.l                            ; $0016DC

loc_0016E2:
        tst.w        rPauseFlags(a6)                               ; $0016E2
        beq.b        loc_0016F0                                    ; $0016E6
        bsr.w        RunPauseMapLoop                               ; $0016E8
        clr.w        -$53a0(a6)                                    ; $0016EC

loc_0016F0:
        jsr          CollisionRoutine_00E30C.l                     ; $0016F0
        tst.w        rLinkRole(a6)                                 ; $0016F6
        beq.b        loc_001720                                    ; $0016FA
        cmpi.w       #$b4, -$53a0(a6)                              ; $0016FC
        bcs.b        loc_00170C                                    ; $001702
        jsr          ActorsRoutine_01C1A0.l                        ; $001704
        bra.b        loc_001720                                    ; $00170A

loc_00170C:
        cmpi.w       #$1, rLinkRole(a6)                            ; $00170C
        bne.b        loc_00171A                                    ; $001712
        jsr          TransmitLinkCommands.l                        ; $001714

loc_00171A:
        jsr          ExecuteLinkCommands.l                         ; $00171A

loc_001720:
        jsr          UpdateActors.l                                ; $001720
        tst.w        rLinkRole(a6)                                 ; $001726
        beq.b        loc_001732                                    ; $00172A
        jsr          InputRoutine_0203A2.l                         ; $00172C

loc_001732:
        jsr          RendererRoutine_00F772.l                      ; $001732
        jsr          RendererRoutine_00DCBE.l                      ; $001738
        jsr          SelectSceneRefreshMode.l                      ; $00173E
        jsr          loc_00C08C.l                                  ; $001744
        jsr          loc_00F216.l                                  ; $00174A
        jsr          UiRoutine_00F838.l                            ; $001750
        jsr          loc_00F816.l                                  ; $001756
        jsr          UpdateTransientWallRecords.l                  ; $00175C
        jsr          UiRoutine_01498A.l                            ; $001762
        movea.l      -$7fc2(a6), a0                                ; $001768
        cmpa.l       #$ff0044, a0                                  ; $00176C
        beq.b        loc_00177A                                    ; $001772
        clr.b        -$5(a0)                                       ; $001774
        bra.b        loc_00177E                                    ; $001778

loc_00177A:
        clr.l        (a0)+                                         ; $00177A
        clr.l        (a0)+                                         ; $00177C

loc_00177E:
        move.l       a0, d6                                        ; $00177E
        move.l       #$ff0044, d4                                  ; $001780
        sub.l        d4, d6                                        ; $001786
        lsr.w        #$1, d6                                       ; $001788
        move.l       #$b800, d5                                    ; $00178A
        bsr.w        QueueVramDma                                  ; $001790
        movea.l      rDmaQueueTail(a6), a0                         ; $001794
        move.l       #$ffffffff, (a0)                              ; $001798
        ifne *-$179E
        fail "ROM end moved"
        endif
