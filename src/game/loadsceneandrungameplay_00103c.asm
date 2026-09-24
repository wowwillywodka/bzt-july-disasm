; $00103C..$0013DF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Initialize scene; load geometry from GeometryEpisode and floor from low nibble of LevelSelection. Its bits 4..5 select legacy music/demo logic, not the geometry bank.
        ifne *-$103C
        fail "ROM start moved"
        endif

LoadSceneAndRunGameplay:
; Initialize scene; load geometry from GeometryEpisode and floor from low nibble of LevelSelection. Its bits 4..5 select legacy music/demo logic, not the geometry bank.
        clr.w        rRemoteSceneExitDelay(a6)                     ; $00103C
        clr.w        rLegacyObjectiveFloor(a6)                     ; $001040
        clr.w        rFloorClearMessageTimer(a6)                   ; $001044
        clr.w        rRemainingEnemyCount(a6)                      ; $001048
        move.w       #$1, rWallOpeningPermit(a6)                   ; $00104C
        move.w       #$ffff, rLastDrawnEnemyCount(a6)              ; $001052
        clr.b        rRemoteHitCommandVariant(a6)                                    ; $001058
        clr.b        rRemoteHitCommandSpecial(a6)                                    ; $00105C
        move.b       #$5c, rLastStrideSoundPhase(a6)                              ; $001060
        clr.w        rInventorySlotDepletionFlag(a6)                                    ; $001066
        clr.b        rRetainedPanoramaEffectActive(a6)                                    ; $00106A
        move.b       #$3, rRetainedPanoramaEffectBudget(a6)                               ; $00106E
        clr.w        rRetainedSceneLoopGate(a6)                                    ; $001074
        move.b       rLevelSelection(a6), d0                       ; $001078
        asr.w        #$4, d0                                       ; $00107C
        andi.w       #$3, d0                                       ; $00107E
        move.w       d0, rLegacyEpisodeSelection(a6)               ; $001082
        move.b       rLevelSelection(a6), d0                       ; $001086
        andi.w       #$f, d0                                       ; $00108A
        move.w       d0, rCurrentFloor(a6)                         ; $00108E
        move.w       d0, rLegacyObjectiveFloor(a6)                 ; $001092
        lea.l        rSceneProgressPasswordText(a6), a0                                ; $001096

loc_00109A:
        tst.w        d0                                            ; $00109A
        beq.b        loc_0010C6                                    ; $00109C
        move.b       #$2a, (a0)+                                   ; $00109E
        move.b       #$53, (a0)+                                   ; $0010A2
        move.b       #$45, (a0)+                                   ; $0010A6
        move.b       #$43, (a0)+                                   ; $0010AA
        move.b       #$55, (a0)+                                   ; $0010AE
        move.b       #$52, (a0)+                                   ; $0010B2
        move.b       #$45, (a0)+                                   ; $0010B6
        move.b       #$44, (a0)+                                   ; $0010BA
        move.b       #$2a, (a0)+                                   ; $0010BE
        subq.w       #$1, d0                                       ; $0010C2
        bne.b        loc_00109A                                    ; $0010C4

loc_0010C6:
        move.w       rGeometryEpisode(a6), d0                      ; $0010C6
        move.w       rCurrentFloor(a6), d1                         ; $0010CA
        jsr          LoadEpisodeGeometry.l                         ; $0010CE
        move.w       rGeometryEpisode(a6), d0                      ; $0010D4
        jsr          LoadZoneGraphicsDescriptor.l                  ; $0010D8
        jsr          InitializeEpisodeTrain.l                      ; $0010DE
        clr.w        d0                                            ; $0010E4

loc_0010E6:
        cmp.w        rCurrentFloor(a6), d0                         ; $0010E6
        beq.b        loc_0010F4                                    ; $0010EA
        move.w       d0, -(a7)                                     ; $0010EC
        move.w       (a7)+, d0                                     ; $0010EE
        addq.w       #$1, d0                                       ; $0010F0
        bra.b        loc_0010E6                                    ; $0010F2

loc_0010F4:
        move.l       #$c0000000, VDP_CONTROL.l                     ; $0010F4
        moveq        #$1f, d0                                      ; $0010FE

loc_001100:
        move.l       #$0, VDP_DATA.l                               ; $001100
        dbra         d0, loc_001100                                ; $00110A
        clr.w        rPlayerHealth(a6)                             ; $00110E
        move.b       rSavedHealth(a6), rPlayerHealthLow(a6)                  ; $001112
        clr.w        rPlayerDeathTicks(a6)                         ; $001118
        jsr          ResetInventoryAndVisualEffects.l                            ; $00111C
        move.w       rLegacyEpisodeSelection(a6), d0               ; $001122
        addi.w       #$45, d0                                      ; $001126
        jsr          StoreCurrentSoundSequenceAndPlayEvent.l                                  ; $00112A
        bsr.w        InitializeVdpRegisters                        ; $001130
        move.w       #$8124, VDP_CONTROL.l                         ; $001134
        bsr.w        SeedRandom                                    ; $00113C
        move.l       rZonePanoramaTilemap(a6), rActivePanoramaTilemap(a6)          ; $001140
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $001146
        move.l       #$ffffffff, (a0)                              ; $00114A
        move.l       a0, rDmaQueueTail(a6)                         ; $001150
        clr.w        rPlayerFacingAngle(a6)                                    ; $001154
        move.w       #$ffe1, rPanoramaVerticalScroll(a6)                            ; $001158
        clr.w        rPanoramaScrollCadence(a6)                                    ; $00115E
        move.w       #$1, rPanoramaVerticalStep(a6)                               ; $001162
        clr.w        rPlayerViewOffsetZ(a6)                                    ; $001168
        clr.w        rBackgroundProfileViewOffsetZ(a6)                                    ; $00116C
        clr.w        rPlayerViewOffsetTargetZ(a6)                                    ; $001170
        clr.w        rPlayerViewVerticalVelocity(a6)                                    ; $001174
        clr.w        rPlayerViewTargetHoldTicks(a6)                                    ; $001178
        clr.w        rPlayerTurnMomentum(a6)                                    ; $00117C
        clr.w        rPlayerTurnInput(a6)                                    ; $001180
        clr.w        rPlayerForwardSpeed(a6)                                    ; $001184
        clr.w        rPlayerForwardInput(a6)                                    ; $001188
        clr.w        rPlayerHitImpulseX(a6)                                    ; $00118C
        clr.w        rPlayerHitImpulseY(a6)                                    ; $001190
        move.w       #$ffff, rPauseMapRenderPassSelector(a6)                            ; $001194
        move.l       #ramTransientCellRecords, rTransientCellRecordsEnd(a6) ; $00119A
; Original initialization repeats the SAME slot +4 thirty times: no A0 increment. Only slot 0 is marked $FF; preserve this defect. See docs/WALL_CHANGES.md.
        move.w       #$1d, d0                                      ; $0011A2
        lea.l        rEpisode1CellRecords(a6), a0                  ; $0011A6

loc_0011AA:
        move.b       #$ff, $4(a0)                                  ; $0011AA
        dbra         d0, loc_0011AA                                ; $0011B0
        move.b       #$0, rEnemyReleaseWallCursor(a6)              ; $0011B4
        move.b       #$0, rEnemyReleaseWallTicks(a6)               ; $0011BA
        clr.w        rMenuIdleCounter(a6)                          ; $0011C0
        move.w       #$c8, rDemoFramesRemaining(a6)                ; $0011C4
        movea.l      #DemoInputRecording1, a0                      ; $0011CA
        tst.w        rLegacyEpisodeSelection(a6)                   ; $0011D0
        beq.b        loc_0011EA                                    ; $0011D4
        movea.l      #DemoInputRecording2, a0                      ; $0011D6
        cmpi.w       #$1, rLegacyEpisodeSelection(a6)              ; $0011DC
        beq.b        loc_0011EA                                    ; $0011E2
        movea.l      #DemoInputRecording3, a0                      ; $0011E4

loc_0011EA:
        cmpi.w       #$1, rDemoMode(a6)                            ; $0011EA
        bne.b        loc_0011F8                                    ; $0011F0
        move.l       (a0)+, rRandomSeed(a6)                             ; $0011F2
        bra.b        loc_001204                                    ; $0011F6

loc_0011F8:
        cmpi.w       #$2, rDemoMode(a6)                            ; $0011F8
        bne.b        loc_001204                                    ; $0011FE
        move.l       rRandomSeed(a6), (a0)+                             ; $001200

loc_001204:
        move.l       a0, rDemoInputPointer(a6)                     ; $001204
        lea.l        AngleVectorPairs(pc), a0                      ; $001208
        move.w       rPlayerFacingAngle(a6), d0                                ; $00120C
        lsl.w        #$2, d0                                       ; $001210
        adda.w       d0, a0                                        ; $001212
        move.w       (a0), rPlayerFacingVectorX(a6)                              ; $001214
        move.w       $2(a0), rPlayerFacingVectorY(a6)                            ; $001218
        clr.w        rPanoramaLastHorizontalScroll(a6)                                    ; $00121E
        clr.w        rPanoramaFineScroll(a6)                                    ; $001222
        clr.w        rPanoramaCoarseTileOffset(a6)                                    ; $001226
        clr.w        rLastStrideSoundPhase(a6)                                    ; $00122A
        jsr          ResetActorPool.l                              ; $00122E
; Per-floor color mode is one byte in ZoneFloorColorModes, not a menu selection.
        movea.l      rZoneFloorColorModes(a6), a0                  ; $001234
        adda.w       rCurrentFloor(a6), a0                         ; $001238
        move.b       (a0), d0                                      ; $00123C
        jsr          SelectSceneColorMode.l                        ; $00123E
        move.l       #ramVisibleMapWindow, d0                      ; $001244
        move.l       d0, rVisibleMapBasePointer(a6)                ; $00124A
        jsr          ResetActorPool.l                              ; $00124E
        clr.w        rPlayerDamageFlashColor(a6)                                    ; $001254
        clr.w        rTransitHeightOffset(a6)                                    ; $001258
        clr.w        rTransitDirectionState(a6)                                    ; $00125C
        jsr          ResetStatusMessages.l                         ; $001260
        clr.w        d0                                            ; $001266
        lea.l        rCellTypeByIndex(a6), a0                      ; $001268
        movea.l      a0, a1                                        ; $00126C
        move.w       #$ff, d7                                      ; $00126E

loc_001272:
        clr.w        d3                                            ; $001272
        move.b       (a0)+, d3                                     ; $001274
        cmpi.b       #$85, d3                                      ; $001276
        beq.b        loc_001284                                    ; $00127A
        addq.w       #$1, d0                                       ; $00127C
        dbra         d7, loc_001272                                ; $00127E
        illegal                                                    ; $001282

loc_001284:
        move.b       d0, rVisibleObjectCellTypeIndex(a6)                                ; $001284
        clr.b        rPauseFlags(a6)                               ; $001288
        tst.w        rLinkRole(a6)                                 ; $00128C
        beq.w        loc_00132E                                    ; $001290
        addi.w       #$40, rPlayerX(a6)                            ; $001294
        cmpi.w       #$1, rLinkRole(a6)                            ; $00129A
        beq.b        loc_0012A8                                    ; $0012A0
        subi.w       #$80, rPlayerX(a6)                            ; $0012A2

loc_0012A8:
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0012A8
        move.b       #$4, (a0)+                                    ; $0012AC
        clr.b        (a0)+                                         ; $0012B0
        move.w       rPlayerX(a6), (a0)+                           ; $0012B2
        move.w       rPlayerY(a6), (a0)+                           ; $0012B6
        move.b       #$e0, (a0)+                                   ; $0012BA
        move.b       #$fa, (a0)+                                   ; $0012BE
        move.b       rCurrentFloorLow(a6), (a0)+                   ; $0012C2
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0012C6
        jsr          QueueLinkCommand.l                            ; $0012CA
        bsr.w        WaitForVBlank                                 ; $0012D0
        jsr          UploadSceneScreen.l                           ; $0012D4
        move.w       #$8164, VDP_CONTROL.l                         ; $0012DA

loc_0012E2:
        bsr.w        WaitForVBlank                                 ; $0012E2
        tst.w        rActiveActorCount(a6)                         ; $0012E6
        bne.b        loc_001322                                    ; $0012EA
        cmpi.w       #$1, rLinkRole(a6)                            ; $0012EC
        bne.b        loc_001314                                    ; $0012F2
        move.w       rLinkRetryDelay(a6), -(a7)                             ; $0012F4
        move.w       rLinkTransferModeShadow(a6), -(a7)                             ; $0012F8
        clr.w        rLinkRetryDelay(a6)                                    ; $0012FC
        move.w       #$2000, rLinkTransferModeShadow(a6)                            ; $001300
        jsr          TransmitLinkCommands.l                        ; $001306
        move.w       (a7)+, rLinkTransferModeShadow(a6)                             ; $00130C
        move.w       (a7)+, rLinkRetryDelay(a6)                             ; $001310

loc_001314:
        jsr          ExecuteLinkCommands.l                         ; $001314
        tst.w        rLinkRole(a6)                                 ; $00131A
        beq.b        loc_001322                                    ; $00131E
        bra.b        loc_0012E2                                    ; $001320

loc_001322:
        bsr.w        WaitForVBlank                                 ; $001322
        move.w       #$8124, VDP_CONTROL.l                         ; $001326

loc_00132E:
        lea.l        rSavedInventoryItem0(a6), a0                  ; $00132E
        lea.l        rSavedInventoryAmount0(a6), a1                ; $001332
        move.w       #$4, d7                                       ; $001336

loc_00133A:
        movem.l      d7/a0-a1, -(a7)                               ; $00133A
        clr.w        d0                                            ; $00133E
        move.b       (a0), d0                                      ; $001340
        beq.b        loc_001352                                    ; $001342
        move.b       (a1), d1                                      ; $001344
        lsl.w        #$8, d1                                       ; $001346
        move.w       d1, rItemGrantAmountOverride(a6)                                ; $001348
        jsr          GrantInventoryItem.l                            ; $00134C

loc_001352:
        movem.l      (a7)+, d7/a0-a1                               ; $001352
        addq.w       #$1, a0                                       ; $001356
        addq.w       #$1, a1                                       ; $001358
        dbra         d7, loc_00133A                                ; $00135A
        clr.w        rItemGrantAmountOverride(a6)                                    ; $00135E
        jsr          GrantCharacterStartingEquipment(pc)           ; $001362
        lea.l        rInventoryHudBlinkTicks(a6), a0                                ; $001366
        clr.b        (a0)+                                         ; $00136A
        clr.b        (a0)+                                         ; $00136C
        clr.b        (a0)+                                         ; $00136E
        clr.b        (a0)+                                         ; $001370
        clr.b        (a0)+                                         ; $001372
        clr.l        rPreviousPlayerCellPointer(a6)                ; $001374
        move.w       #$1, rWallChangeRefreshFlag(a6)                               ; $001378
        bsr.w        InitializeGameplayVideo                              ; $00137E
        move.w       #$1, rVisibleRaySampleStep(a6)                               ; $001382
        move.w       #$0, rRearViewActive(a6)                               ; $001388
        move.w       #$0, rRearViewInputLatch(a6)                               ; $00138E
        jsr          RenderWorldWithCameraOffset.l                                  ; $001394
        jsr          ClampPlayerToFloorBoundsAndRenderWorld.l                                  ; $00139A
        move.l       #$c0000000, VDP_CONTROL.l                     ; $0013A0
        moveq        #$1f, d0                                      ; $0013AA

loc_0013AC:
        move.l       #$0, VDP_DATA.l                               ; $0013AC
        dbra         d0, loc_0013AC                                ; $0013B6
        move.w       #$2, rVBlankTransferPhasesRemaining(a6)                               ; $0013BA
        bsr.w        ResetVerticalScroll                           ; $0013C0
        bsr.w        WaitForVBlank                                 ; $0013C4
        bsr.w        WaitForVBlank                                 ; $0013C8
        clr.w        rDisplayEnableDelay(a6)                                    ; $0013CC
        move.w       #$8164, VDP_CONTROL.l                         ; $0013D0
        bsr.w        FadeInScenePalette                            ; $0013D8
        clr.w        rLinkStallTicks(a6)                                    ; $0013DC
        ifne *-$13E0
        fail "ROM end moved"
        endif
