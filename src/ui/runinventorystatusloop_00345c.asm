; $00345C..$0038B1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Inventory/status modal, also called during episode exit. It encodes a progress snapshot at $003488; D0 is not preserved as an episode argument.
        ifne *-$345C
        fail "ROM start moved"
        endif

RunInventoryStatusLoop:
; Inventory/status modal, also called during episode exit. It encodes a progress snapshot at $003488; D0 is not preserved as an episode argument.
        clr.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00345C
        bsr.w        WaitForVBlank                                 ; $003460
        move.w       #$8124, VDP_CONTROL.l                         ; $003464
        bsr.w        ResetVerticalScroll                           ; $00346C
        move.l       #$c07e0000, VDP_CONTROL.l                     ; $003470
        move.w       #$0, VDP_DATA.l                               ; $00347A
        jsr          PauseGemsSequences.l                          ; $003482
        jsr          EncodeCurrentProgressSnapshot.l               ; $003488
        bsr.w        ClearVramLongs                                ; $00348E
        bsr.w        ClearVideoMemory                              ; $003492
        lea.l        InventoryIconPalettes.l, a0                   ; $003496
        move.w       #$0, d0                                       ; $00349C
        jsr          LoadPaletteLine.l                             ; $0034A0
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $0034A6
        move.w       #$287, d0                                     ; $0034AC
        jsr          DecompressBytePairToVramLong.l                ; $0034B0
        move.l       #$63a00001, VDP_CONTROL.l                     ; $0034B6
        lea.l        InventoryStatusTiles.l, a0                             ; $0034C0
        move.w       #$11f, d7                                     ; $0034C6

loc_0034CA:
        move.l       (a0)+, VDP_DATA.l                             ; $0034CA
        dbra         d7, loc_0034CA                                ; $0034D0
        move.l       #$40000010, VDP_CONTROL.l                     ; $0034D4
        move.w       #$0, (a4)                                     ; $0034DE
        move.w       #$0, (a4)                                     ; $0034E2
        move.l       #$c0400000, VDP_CONTROL.l                     ; $0034E6
        movea.l      #InterfacePalettes, a0                        ; $0034F0
        move.l       (a0)+, (a4)                                   ; $0034F6
        move.l       (a0)+, (a4)                                   ; $0034F8
        move.l       (a0)+, (a4)                                   ; $0034FA
        move.l       (a0)+, (a4)                                   ; $0034FC
        move.l       (a0)+, (a4)                                   ; $0034FE
        move.l       (a0)+, (a4)                                   ; $003500
        move.l       (a0)+, (a4)                                   ; $003502
        move.l       (a0)+, (a4)                                   ; $003504
        movea.l      #InterfacePalettes, a0                        ; $003506
        move.l       (a0)+, (a4)                                   ; $00350C
        move.l       (a0)+, (a4)                                   ; $00350E
        move.l       (a0)+, (a4)                                   ; $003510
        move.l       (a0)+, (a4)                                   ; $003512
        move.l       (a0)+, (a4)                                   ; $003514
        move.l       (a0)+, (a4)                                   ; $003516
        move.l       (a0)+, (a4)                                   ; $003518
        move.l       (a0)+, (a4)                                   ; $00351A
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $00351C
        move.l       #$ffffffff, (a0)                              ; $003520
        move.l       a0, rDmaQueueTail(a6)                         ; $003526
        move.w       #$1, rSpriteAttributeNextLink(a6)                               ; $00352A
        move.l       #ramSpriteAttributeTable, rSpriteAttributeTableWritePointer(a6)                          ; $003530
        clr.w        rUiRepeatRightTicks(a6)                                    ; $003538
        lea.l        Data_003978(pc), a0                           ; $00353C
        move.w       #$c204, d0                                    ; $003540
        jsr          PrintCenteredAlternateFont.l                  ; $003544
        move.l       rAmmoUsageFixedCounter(a6), d0                ; $00354A
        lsr.l        #$8, d0                                       ; $00354E
        bsr.w        FormatDecimalNumber                           ; $003550
        lea.l        rSharedScratchBuffer(a6), a0                                ; $003554
        move.w       #$c22e, d0                                    ; $003558
        jsr          PrintCenteredAlternateFont.l                  ; $00355C
        lea.l        LevelStatisticsStrings(pc), a0                ; $003562
        move.w       #$c384, d0                                    ; $003566
        jsr          PrintCenteredAlternateFont.l                  ; $00356A
        move.w       rObjectiveProgressCount(a6), d0                                ; $003570
        tst.w        d0                                            ; $003574
        bne.b        loc_00358A                                    ; $003576
        lea.l        Data_0039AE(pc), a0                           ; $003578
        move.w       #$c3ae, d0                                    ; $00357C
        jsr          PrintCenteredAlternateFont.l                  ; $003580
        bra.w        loc_0035EA                                    ; $003586

loc_00358A:
        bsr.w        FormatDecimalNumber                           ; $00358A
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00358E
        move.w       #$c3ae, d0                                    ; $003592
        move.w       d0, -(a7)                                     ; $003596
        jsr          PrintCenteredAlternateFont.l                  ; $003598
        clr.w        d1                                            ; $00359E
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0035A0

loc_0035A4:
        tst.b        (a0)+                                         ; $0035A4
        beq.b        loc_0035AC                                    ; $0035A6
        addq.w       #$2, d1                                       ; $0035A8
        bra.b        loc_0035A4                                    ; $0035AA

loc_0035AC:
        lea.l        Data_0039A9(pc), a0                           ; $0035AC
        move.w       (a7)+, d0                                     ; $0035B0
        add.w        d1, d0                                        ; $0035B2
        move.w       d0, -(a7)                                     ; $0035B4
        jsr          PrintCenteredAlternateFont.l                  ; $0035B6
        move.w       rEpisodeObjectiveCellTotal(a6), d0                                ; $0035BC
        cmp.w        rObjectiveProgressCount(a6), d0                                ; $0035C0
        bne.b        loc_0035D8                                    ; $0035C4
        move.w       (a7)+, d0                                     ; $0035C6
        lea.l        Data_0039B3(pc), a0                           ; $0035C8
        move.w       #$c3ae, d0                                    ; $0035CC
        jsr          PrintCenteredAlternateFont.l                  ; $0035D0
        bra.b        loc_0035EA                                    ; $0035D6

loc_0035D8:
        bsr.w        FormatDecimalNumber                           ; $0035D8
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0035DC
        move.w       (a7)+, d0                                     ; $0035E0
        addq.w       #$8, d0                                       ; $0035E2
        jsr          PrintCenteredAlternateFont.l                  ; $0035E4

loc_0035EA:
        lea.l        Data_003939(pc), a0                           ; $0035EA
        move.w       #$c504, d0                                    ; $0035EE
        jsr          PrintCenteredAlternateFont.l                  ; $0035F2
        move.w       rEnemyDeathsRecorded(a6), d0                                ; $0035F8
        cmpi.w       #$0, d0                                       ; $0035FC
        bne.b        loc_003614                                    ; $003600
        lea.l        Data_0039AE(pc), a0                           ; $003602
        move.w       #$c52e, d0                                    ; $003606
        jsr          PrintCenteredAlternateFont.l                  ; $00360A
        bra.w        loc_003674                                    ; $003610

loc_003614:
        bsr.w        FormatDecimalNumber                           ; $003614
        lea.l        rSharedScratchBuffer(a6), a0                                ; $003618
        move.w       #$c52e, d0                                    ; $00361C
        move.w       d0, -(a7)                                     ; $003620
        jsr          PrintCenteredAlternateFont.l                  ; $003622
        clr.w        d1                                            ; $003628
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00362A

loc_00362E:
        tst.b        (a0)+                                         ; $00362E
        beq.b        loc_003636                                    ; $003630
        addq.w       #$2, d1                                       ; $003632
        bra.b        loc_00362E                                    ; $003634

loc_003636:
        lea.l        Data_0039A9(pc), a0                           ; $003636
        move.w       (a7)+, d0                                     ; $00363A
        add.w        d1, d0                                        ; $00363C
        move.w       d0, -(a7)                                     ; $00363E
        jsr          PrintCenteredAlternateFont.l                  ; $003640
        move.w       rEpisodeEnemyTotalForStats(a6), d0                                ; $003646
        cmp.w        rEnemyDeathsRecorded(a6), d0                                ; $00364A
        bne.b        loc_003662                                    ; $00364E
        move.w       (a7)+, d0                                     ; $003650
        lea.l        Data_0039B3(pc), a0                           ; $003652
        move.w       #$c52e, d0                                    ; $003656
        jsr          PrintCenteredAlternateFont.l                  ; $00365A
        bra.b        loc_003674                                    ; $003660

loc_003662:
        bsr.w        FormatDecimalNumber                           ; $003662
        lea.l        rSharedScratchBuffer(a6), a0                                ; $003666
        move.w       (a7)+, d0                                     ; $00366A
        addq.w       #$8, d0                                       ; $00366C
        jsr          PrintCenteredAlternateFont.l                  ; $00366E

loc_003674:
        lea.l        Data_00394E(pc), a0                           ; $003674
        move.w       #$c684, d0                                    ; $003678
        jsr          PrintCenteredAlternateFont.l                  ; $00367C
        clr.l        d0                                            ; $003682
        move.w       rEnemyHitCallbacksRecorded(a6), d0                                ; $003684
        mulu.w       #$64, d0                                      ; $003688
        move.l       rAmmoUsageFixedCounter(a6), d1                ; $00368C
        lsr.l        #$8, d1                                       ; $003690
        tst.w        d0                                            ; $003692
        beq.b        loc_0036A8                                    ; $003694
        tst.w        d1                                            ; $003696
        beq.b        loc_0036A8                                    ; $003698
        divu.w       d1, d0                                        ; $00369A
        cmpi.w       #$5f, d0                                      ; $00369C
        blt.b        loc_0036A8                                    ; $0036A0
        lea.l        Data_0039A2(pc), a0                           ; $0036A2
        bra.b        loc_0036B0                                    ; $0036A6

loc_0036A8:
        bsr.w        FormatDecimalNumber                           ; $0036A8
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0036AC

loc_0036B0:
        move.w       #$c6ae, d0                                    ; $0036B0
        jsr          PrintCenteredAlternateFont.l                  ; $0036B4
        lea.l        Data_00398D(pc), a0                           ; $0036BA
        move.w       #$c804, d0                                    ; $0036BE
        jsr          PrintCenteredAlternateFont.l                  ; $0036C2
        move.w       rMedipacksCollectedCount(a6), d0                                ; $0036C8
        cmpi.w       #$0, d0                                       ; $0036CC
        bne.b        loc_0036E4                                    ; $0036D0
        lea.l        Data_0039AE(pc), a0                           ; $0036D2
        move.w       #$c82e, d0                                    ; $0036D6
        jsr          PrintCenteredAlternateFont.l                  ; $0036DA
        bra.w        loc_003744                                    ; $0036E0

loc_0036E4:
        bsr.w        FormatDecimalNumber                           ; $0036E4
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0036E8
        move.w       #$c82e, d0                                    ; $0036EC
        move.w       d0, -(a7)                                     ; $0036F0
        jsr          PrintCenteredAlternateFont.l                  ; $0036F2
        clr.w        d1                                            ; $0036F8
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0036FA

loc_0036FE:
        tst.b        (a0)+                                         ; $0036FE
        beq.b        loc_003706                                    ; $003700
        addq.w       #$2, d1                                       ; $003702
        bra.b        loc_0036FE                                    ; $003704

loc_003706:
        lea.l        Data_0039A9(pc), a0                           ; $003706
        move.w       (a7)+, d0                                     ; $00370A
        add.w        d1, d0                                        ; $00370C
        move.w       d0, -(a7)                                     ; $00370E
        jsr          PrintCenteredAlternateFont.l                  ; $003710
        move.w       rEpisodeMedipackCellTotal(a6), d0                                ; $003716
        cmp.w        rMedipacksCollectedCount(a6), d0                                ; $00371A
        bne.b        loc_003732                                    ; $00371E
        move.w       (a7)+, d0                                     ; $003720
        lea.l        Data_0039B3(pc), a0                           ; $003722
        move.w       #$c82e, d0                                    ; $003726
        jsr          PrintCenteredAlternateFont.l                  ; $00372A
        bra.b        loc_003744                                    ; $003730

loc_003732:
        bsr.w        FormatDecimalNumber                           ; $003732
        lea.l        rSharedScratchBuffer(a6), a0                                ; $003736
        move.w       (a7)+, d0                                     ; $00373A
        addq.w       #$8, d0                                       ; $00373C
        jsr          PrintCenteredAlternateFont.l                  ; $00373E

loc_003744:
        lea.l        Data_003963(pc), a0                           ; $003744
        move.w       #$c984, d0                                    ; $003748
        jsr          PrintCenteredAlternateFont.l                  ; $00374C
        clr.w        d0                                            ; $003752
        move.b       rGameClockHours(a6), d0                                ; $003754
        bsr.w        FormatDecimalNumber                           ; $003758
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00375C
        tst.b        $1(a0)                                        ; $003760
        bne.b        loc_003772                                    ; $003764
        move.b       (a0), $1(a0)                                  ; $003766
        move.b       #$30, (a0)                                    ; $00376A
        clr.b        $2(a0)                                        ; $00376E

loc_003772:
        move.w       #$c9ae, d0                                    ; $003772
        move.w       d0, -(a7)                                     ; $003776
        jsr          PrintCenteredAlternateFont.l                  ; $003778
        move.w       (a7)+, d0                                     ; $00377E
        lea.l        Data_0039C3(pc), a0                           ; $003780
        addq.w       #$4, d0                                       ; $003784
        move.w       d0, -(a7)                                     ; $003786
        jsr          PrintCenteredAlternateFont.l                  ; $003788
        clr.w        d0                                            ; $00378E
        move.b       rGameClockMinutes(a6), d0                                ; $003790
        bsr.w        FormatDecimalNumber                           ; $003794
        lea.l        rSharedScratchBuffer(a6), a0                                ; $003798
        tst.b        $1(a0)                                        ; $00379C
        bne.b        loc_0037AE                                    ; $0037A0
        move.b       (a0), $1(a0)                                  ; $0037A2
        move.b       #$30, (a0)                                    ; $0037A6
        clr.b        $2(a0)                                        ; $0037AA

loc_0037AE:
        move.w       (a7)+, d0                                     ; $0037AE
        addq.w       #$2, d0                                       ; $0037B0
        move.w       d0, -(a7)                                     ; $0037B2
        jsr          PrintCenteredAlternateFont.l                  ; $0037B4
        move.w       (a7)+, d0                                     ; $0037BA
        lea.l        Data_0039C3(pc), a0                           ; $0037BC
        addq.w       #$4, d0                                       ; $0037C0
        move.w       d0, -(a7)                                     ; $0037C2
        jsr          PrintCenteredAlternateFont.l                  ; $0037C4
        clr.w        d0                                            ; $0037CA
        move.b       rGameClockSeconds(a6), d0                                ; $0037CC
        bsr.w        FormatDecimalNumber                           ; $0037D0
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0037D4
        tst.b        $1(a0)                                        ; $0037D8
        bne.b        loc_0037EA                                    ; $0037DC
        move.b       (a0), $1(a0)                                  ; $0037DE
        move.b       #$30, (a0)                                    ; $0037E2
        clr.b        $2(a0)                                        ; $0037E6

loc_0037EA:
        move.w       (a7)+, d0                                     ; $0037EA
        addq.w       #$2, d0                                       ; $0037EC
        jsr          PrintCenteredAlternateFont.l                  ; $0037EE
        tst.w        rSceneExitRequested(a6)                       ; $0037F4
        beq.b        loc_003828                                    ; $0037F8
        lea.l        StatisticsPasswordLabel(pc), a0               ; $0037FA
        move.w       #$cb04, d0                                    ; $0037FE
        jsr          PrintCenteredAlternateFont.l                  ; $003802
        move.w       #$0, rPauseMapFloorLabelIndex(a6)                               ; $003808
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00380E
        jsr          CopyFirstSceneLabel.l                         ; $003812
        clr.b        (a0)+                                         ; $003818
        lea.l        rSharedScratchBuffer(a6), a0                                ; $00381A
        move.w       #$cb2e, d0                                    ; $00381E
        jsr          PrintCenteredAlternateFont.l                  ; $003822

loc_003828:
        bsr.w        WaitForVBlank                                 ; $003828
        move.w       #$8164, VDP_CONTROL.l                         ; $00382C

loc_003834:
        bsr.w        WaitForVBlank                                 ; $003834
        bsr.w        FlushDmaQueue                                 ; $003838
        bsr.w        UpdateDemoInput                               ; $00383C
        move.w       #$1, rSpriteAttributeNextLink(a6)                               ; $003840
        move.l       #ramSpriteAttributeTable, rSpriteAttributeTableWritePointer(a6)                          ; $003846
        movea.l      rDmaQueueTail(a6), a0                         ; $00384E
        move.l       #$ffffffff, (a0)                              ; $003852
        jsr          UploadSpriteTable.l                           ; $003858
        tst.w        rLinkRole(a6)                                 ; $00385E
        beq.b        loc_003878                                    ; $003862
        cmpi.w       #$1, rLinkRole(a6)                            ; $003864
        bne.b        loc_003872                                    ; $00386A
        jsr          TransmitLinkCommands.l                        ; $00386C

loc_003872:
        jsr          ExecuteLinkCommands.l                         ; $003872

loc_003878:
        btst.b       #$0, rPauseFlags(a6)                          ; $003878
        beq.b        loc_0038A4                                    ; $00387E
        btst.b       #$7, rControllerState(a6)                     ; $003880
        beq.b        loc_0038A4                                    ; $003886
        btst.b       #$7, rPreviousControllerState(a6)             ; $003888
        bne.b        loc_0038A4                                    ; $00388E
        bclr.b       #$0, rPauseFlags(a6)                          ; $003890
        lea.l        rSharedScratchBuffer(a6), a0                                ; $003896
        move.b       #$15, (a0)                                    ; $00389A
        jsr          QueueLinkCommand.l                            ; $00389E

loc_0038A4:
        tst.b        rPauseFlags(a6)                               ; $0038A4
        bne.b        loc_003834                                    ; $0038A8
        jsr          ResumeGemsSequences.l                         ; $0038AA
        rts                                                        ; $0038B0
        ifne *-$38B2
        fail "ROM end moved"
        endif
