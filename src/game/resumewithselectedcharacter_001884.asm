; $001884..$001A1B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Resume at the same world position/floor with health 100 and restored inventory plus starting equipment. $01D756 places a cell marker; it does not choose a new spawn coordinate.
        ifne *-$1884
        fail "ROM start moved"
        endif

ResumeWithSelectedCharacter:
; Resume at the same world position/floor with health 100 and restored inventory plus starting equipment. $01D756 places a cell marker; it does not choose a new spawn coordinate.
        move.l       #$c0000000, VDP_CONTROL.l                     ; $001884
        moveq        #$1f, d0                                      ; $00188E

loc_001890:
        move.l       #$0, VDP_DATA.l                               ; $001890
        dbra         d0, loc_001890                                ; $00189A
        move.w       rLegacyEpisodeSelection(a6), d0               ; $00189E
        addi.w       #$45, d0                                      ; $0018A2
        jsr          StoreCurrentSoundSequenceAndPlayEvent.l                                  ; $0018A6
        bsr.w        InitializeVdpRegisters                        ; $0018AC
        move.w       #$8124, VDP_CONTROL.l                         ; $0018B0
        bsr.w        SeedRandom                                    ; $0018B8
        move.w       #$64, rPlayerHealth(a6)                       ; $0018BC
        jsr          FillNearbyEmptyCellAtPlayer.l                     ; $0018C2
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $0018C8
        move.l       #$ffffffff, (a0)                              ; $0018CC
        move.l       a0, rDmaQueueTail(a6)                         ; $0018D2
        clr.w        rPlayerFacingAngle(a6)                                    ; $0018D6
        clr.w        rPlayerViewOffsetZ(a6)                                    ; $0018DA
        clr.w        rBackgroundProfileViewOffsetZ(a6)                                    ; $0018DE
        clr.w        rPlayerViewOffsetTargetZ(a6)                                    ; $0018E2
        clr.w        rPlayerViewVerticalVelocity(a6)                                    ; $0018E6
        clr.w        rPlayerViewTargetHoldTicks(a6)                                    ; $0018EA
        clr.w        rPlayerTurnMomentum(a6)                                    ; $0018EE
        clr.w        rPlayerTurnInput(a6)                                    ; $0018F2
        clr.w        rPlayerForwardSpeed(a6)                                    ; $0018F6
        clr.w        rPlayerForwardInput(a6)                                    ; $0018FA
        clr.w        rPlayerHitImpulseX(a6)                                    ; $0018FE
        clr.w        rPlayerHitImpulseY(a6)                                    ; $001902
        clr.w        rMenuIdleCounter(a6)                          ; $001906
        move.w       #$c8, rDemoFramesRemaining(a6)                ; $00190A
        movea.l      #DemoInputRecording1, a0                      ; $001910
        tst.w        rLegacyEpisodeSelection(a6)                   ; $001916
        beq.b        loc_001930                                    ; $00191A
        movea.l      #DemoInputRecording2, a0                      ; $00191C
        cmpi.w       #$1, rLegacyEpisodeSelection(a6)              ; $001922
        beq.b        loc_001930                                    ; $001928
        movea.l      #DemoInputRecording3, a0                      ; $00192A

loc_001930:
        cmpi.w       #$1, rDemoMode(a6)                            ; $001930
        bne.b        loc_00193E                                    ; $001936
        move.l       (a0)+, rRandomSeed(a6)                             ; $001938
        bra.b        loc_00194A                                    ; $00193C

loc_00193E:
        cmpi.w       #$2, rDemoMode(a6)                            ; $00193E
        bne.b        loc_00194A                                    ; $001944
        move.l       rRandomSeed(a6), (a0)+                             ; $001946

loc_00194A:
        move.l       a0, rDemoInputPointer(a6)                     ; $00194A
        lea.l        AngleVectorPairs(pc), a0                      ; $00194E
        move.w       rPlayerFacingAngle(a6), d0                                ; $001952
        lsl.w        #$2, d0                                       ; $001956
        adda.w       d0, a0                                        ; $001958
        move.w       (a0), rPlayerFacingVectorX(a6)                              ; $00195A
        move.w       $2(a0), rPlayerFacingVectorY(a6)                            ; $00195E
        clr.w        rPanoramaLastHorizontalScroll(a6)                                    ; $001964
        clr.w        rPanoramaFineScroll(a6)                                    ; $001968
        clr.w        rPanoramaCoarseTileOffset(a6)                                    ; $00196C
        clr.w        rLastStrideSoundPhase(a6)                                    ; $001970
        clr.w        rRetainedPanoramaTileDelay(a6)                                    ; $001974
        clr.l        rRetainedPanoramaTileState0(a6)                                    ; $001978
        clr.l        rRetainedPanoramaTileState1(a6)                                    ; $00197C
        clr.l        rRetainedPanoramaTileState2(a6)                                    ; $001980
        clr.w        rPlayerDamageFlashColor(a6)                                    ; $001984
        clr.w        rTransitHeightOffset(a6)                                    ; $001988
        clr.w        rTransitDirectionState(a6)                                    ; $00198C
        jsr          ResetStatusMessages.l                         ; $001990
        bsr.w        RestoreInventoryAfterCharacterDeath           ; $001996
        jsr          GrantCharacterStartingEquipment(pc)           ; $00199A
        bsr.w        InitializeGameplayVideo                              ; $00199E
        jsr          SelectSceneRefreshMode.l                      ; $0019A2
        jsr          RenderWorldWithCameraOffset.l                                  ; $0019A8
        jsr          ClampPlayerToFloorBoundsAndRenderWorld.l                                  ; $0019AE
        clr.w        rPlayerDeathTicks(a6)                         ; $0019B4
        move.l       #$c0000000, VDP_CONTROL.l                     ; $0019B8
        moveq        #$1f, d0                                      ; $0019C2

loc_0019C4:
        move.l       #$0, VDP_DATA.l                               ; $0019C4
        dbra         d0, loc_0019C4                                ; $0019CE
        move.w       #$2, rVBlankTransferPhasesRemaining(a6)                               ; $0019D2
        bsr.w        WaitForVBlank                                 ; $0019D8
        bsr.w        WaitForVBlank                                 ; $0019DC
        move.w       #$8164, VDP_CONTROL.l                         ; $0019E0
        bsr.w        FadeInScenePalette                            ; $0019E8
        tst.w        rLinkRole(a6)                                 ; $0019EC
        beq.b        loc_001A06                                    ; $0019F0
        bclr.b       #$0, rPauseFlags(a6)                          ; $0019F2
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0019F8
        move.b       #$15, (a0)                                    ; $0019FC
        jsr          QueueLinkCommand.l                            ; $001A00

loc_001A06:
        lea.l        rInventoryHudBlinkTicks(a6), a0                                ; $001A06
        clr.b        (a0)+                                         ; $001A0A
        clr.b        (a0)+                                         ; $001A0C
        clr.b        (a0)+                                         ; $001A0E
        clr.b        (a0)+                                         ; $001A10
        clr.b        (a0)+                                         ; $001A12
        clr.w        rLinkStallTicks(a6)                                    ; $001A14
        bra.w        RunGameplayIteration                          ; $001A18
        ifne *-$1A1C
        fail "ROM end moved"
        endif
