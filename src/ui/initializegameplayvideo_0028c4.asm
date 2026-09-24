; $0028C4..$002B93 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация игрового видео: копирует текущую scene/effect CRAM, очищает VRAM, загружает рамку HUD, портрет, панораму и вспомогательные тайлы; затем сбрасывает очередь DMA и SAT. См. docs/WEAPON_GRAPHICS.md.
        ifne *-$28C4
        fail "ROM start moved"
        endif

InitializeGameplayVideo:
        bsr.w        WaitForVBlank                                 ; $0028C4
        move.w       #$8124, VDP_CONTROL.l                         ; $0028C8
        move.w       #$20, rWeaponLoweringOffset(a6)               ; $0028D0
        clr.w        rVBlankTransferPhasesRemaining(a6)                                    ; $0028D6
        bsr.w        ResetVerticalScroll                           ; $0028DA
        cmpi.w       #$ffff, rNightVisionInventorySlotIndex(a6)                            ; $0028DE
        bne.b        loc_0028EC                                    ; $0028E4
        movea.l      rZoneScenePalette(a6), a0                     ; $0028E6
        bra.b        loc_0028F0                                    ; $0028EA

loc_0028EC:
        movea.l      rZoneEffectPalette(a6), a0                    ; $0028EC

loc_0028F0:
        move.l       #$c0000000, VDP_CONTROL.l                     ; $0028F0
        movea.l      #VDP_DATA, a4                                 ; $0028FA
        move.w       #$1f, d0                                      ; $002900

loc_002904:
        move.l       (a0)+, (a4)                                   ; $002904
        dbra         d0, loc_002904                                ; $002906
        bsr.w        ClearVramLongs                                ; $00290A
        bsr.w        ClearVideoMemory                              ; $00290E
        clr.w        rPauseMapPanY(a6)                                    ; $002912
        clr.w        rPauseMapPanX(a6)                                    ; $002916
        lea.l        Data_160CFC.l, a0                             ; $00291A
        move.w       #$53d, d0                                     ; $002920
        move.w       #$4, d1                                       ; $002924
        jsr          UploadTiles.l                                 ; $002928
        lea.l        GameplayFrameCompressedTiles.l, a3            ; $00292E
        move.w       #$301, d0                                     ; $002934
; Decompress gameplay frame tiles to VRAM tile $301; map at GameplayFrameTilemap, 40x28.
        jsr          DecompressBytePairToVramLong.l                ; $002938
        lea.l        GameplayFrameTilemap.l, a0                    ; $00293E
        movea.l      #$c000, a1                                    ; $002944
        move.w       #$28, d0                                      ; $00294A
        move.w       #$1c, d1                                      ; $00294E
        move.w       #$40, d2                                      ; $002952
        move.w       #$e301, d3                                    ; $002956
        jsr          UploadAttributedTilemap.l                     ; $00295A
        move.l       #$b100003, VDP_CONTROL.l                      ; $002960
        move.l       VDP_DATA.l, rInitialVideoPortSnapshot(a6)                        ; $00296A
        jsr          DelayVdpAccess.l                              ; $002972
        movea.l      #VDP_DATA, a4                                 ; $002978
        move.l       #$4ca0003, VDP_CONTROL.l                      ; $00297E
        move.w       VDP_DATA.l, d0                                ; $002988
        jsr          DelayVdpAccess.l                              ; $00298E
        andi.w       #$7ff, d0                                     ; $002994
        lsl.w        #$5, d0                                       ; $002998
        move.w       d0, d1                                        ; $00299A
        andi.w       #$3fff, d1                                    ; $00299C
        ori.w        #$4000, d1                                    ; $0029A0
        swap         d1                                            ; $0029A4
        lsr.w        #$8, d0                                       ; $0029A6
        lsr.w        #$6, d0                                       ; $0029A8
        move.w       d0, d1                                        ; $0029AA
        move.l       d1, VDP_CONTROL.l                             ; $0029AC
        moveq        #-1, d7                                       ; $0029B2
        move.l       d7, (a4)                                      ; $0029B4
        move.l       d7, (a4)                                      ; $0029B6
        move.l       d7, (a4)                                      ; $0029B8
        move.l       d7, (a4)                                      ; $0029BA
        move.l       d7, (a4)                                      ; $0029BC
        move.l       d7, (a4)                                      ; $0029BE
        move.l       d7, (a4)                                      ; $0029C0
        move.l       d7, (a4)                                      ; $0029C2
        jsr          UpdatePlayerHealthHudDigits.l                            ; $0029C4
        move.w       rRemainingEnemyCount(a6), d6                  ; $0029CA
        jsr          WriteTwoDigitHudNumberToVram.l                            ; $0029CE
        lea.l        CharacterPortraitGraphicsPointers(pc), a0     ; $0029D4
        move.w       rSelectedCharacter(a6), d0                    ; $0029D8
        cmpi.w       #$4, d0                                       ; $0029DC
        bls.b        loc_0029E4                                    ; $0029E0
        clr.w        d0                                            ; $0029E2

loc_0029E4:
        move.w       d0, rSelectedCharacter(a6)                    ; $0029E4
        lsl.w        #$2, d0                                       ; $0029E8
        movea.l      (a0, d0.w), a0                                ; $0029EA
        lea.l        GameplayPortraitTilemapPointers.l, a1        ; $0029EE
        movea.l      (a1, d0.w), a1                                ; $0029F4
        move.l       a1, -(a7)                                     ; $0029F8
        move.w       #$3f4, d0                                     ; $0029FA
        move.w       #$ab, d1                                      ; $0029FE
        jsr          UploadTiles.l                                 ; $002A02
        movea.l      (a7)+, a1                                     ; $002A08
        movea.l      a1, a0                                        ; $002A0A
        moveq        #$18, d0                                      ; $002A0C
        moveq        #$10, d1                                      ; $002A0E
        moveq        #$40, d2                                      ; $002A10
        jsr          CalculateTilemapAddress.l                     ; $002A12
        adda.w       #$c000, a1                                    ; $002A18
        move.w       #$10, d0                                      ; $002A1C
        move.w       #$c, d1                                       ; $002A20
        move.w       #$40, d2                                      ; $002A24
        move.w       #$e3f4, d3                                    ; $002A28
        jsr          UploadAttributedTilemap.l                     ; $002A2C
        jsr          UploadInventorySlotIconsToVram.l                         ; $002A32
        move.l       #$62800002, VDP_CONTROL.l                     ; $002A38
        moveq        #-1, d7                                       ; $002A42
        move.l       d7, (a4)                                      ; $002A44
        move.l       d7, (a4)                                      ; $002A46
        move.l       d7, (a4)                                      ; $002A48
        move.l       d7, (a4)                                      ; $002A4A
        move.l       d7, (a4)                                      ; $002A4C
        move.l       d7, (a4)                                      ; $002A4E
        move.l       d7, (a4)                                      ; $002A50
        move.l       d7, (a4)                                      ; $002A52
        lea.l        GameplayHudGlyphTiles.l, a0                             ; $002A54
        move.w       #$13f, d7                                     ; $002A5A

loc_002A5E:
        move.l       (a0)+, VDP_DATA.l                             ; $002A5E
        dbra         d7, loc_002A5E                                ; $002A64
        movea.l      rZonePanoramaCompressedTiles(a6), a3          ; $002A68
        move.w       #$141, d0                                     ; $002A6C
; A3 is loaded from zone descriptor +$2C; four episode panorama streams. Output starts at VRAM tile $141.
        jsr          DecompressBytePairToVramLong.l                ; $002A70
        move.l       #$c288, d1                                    ; $002A76
        move.w       #$1f, d2                                      ; $002A7C
        move.w       #$8001, d4                                    ; $002A80

loc_002A84:
        move.l       d1, d0                                        ; $002A84
        move.w       #$9, d3                                       ; $002A86

loc_002A8A:
        movem.l      d0-d4, -(a7)                                  ; $002A8A
        move.w       d0, d1                                        ; $002A8E
        andi.w       #$3fff, d1                                    ; $002A90
        ori.w        #$4000, d1                                    ; $002A94
        swap         d1                                            ; $002A98
        lsr.w        #$8, d0                                       ; $002A9A
        lsr.w        #$6, d0                                       ; $002A9C
        move.w       d0, d1                                        ; $002A9E
        move.l       d1, VDP_CONTROL.l                             ; $002AA0
        movem.l      (a7)+, d0-d4                                  ; $002AA6
        move.w       d4, VDP_DATA.l                                ; $002AAA
        addi.l       #$80, d0                                      ; $002AB0
        addq.w       #$1, d4                                       ; $002AB6
        dbra         d3, loc_002A8A                                ; $002AB8
        addq.l       #$2, d1                                       ; $002ABC
        dbra         d2, loc_002A84                                ; $002ABE
        move.l       #$5d400001, VDP_CONTROL.l                     ; $002AC2
        lea.l        GameplayFrameAuxiliaryData.l, a0              ; $002ACC
        move.w       #$b7, d7                                      ; $002AD2

loc_002AD6:
        move.l       (a0)+, VDP_DATA.l                             ; $002AD6
        dbra         d7, loc_002AD6                                ; $002ADC
        move.w       #$8f80, VDP_CONTROL.l                         ; $002AE0
        move.w       #$0, d3                                       ; $002AE8
        move.w       d3, d4                                        ; $002AEC
        move.w       #$29, d7                                      ; $002AEE

loc_002AF2:
        andi.w       #$ff, d3                                      ; $002AF2
        andi.w       #$7f, d4                                      ; $002AF6
        move.w       #$e000, d0                                    ; $002AFA
        add.w        d4, d0                                        ; $002AFE
        move.w       d0, d1                                        ; $002B00
        andi.w       #$3fff, d1                                    ; $002B02
        ori.w        #$4000, d1                                    ; $002B06
        swap         d1                                            ; $002B0A
        lsr.w        #$8, d0                                       ; $002B0C
        lsr.w        #$6, d0                                       ; $002B0E
        move.w       d0, d1                                        ; $002B10
        move.l       d1, VDP_CONTROL.l                             ; $002B12
        movea.l      rActivePanoramaTilemap(a6), a0                                ; $002B18
        adda.w       d3, a0                                        ; $002B1C
        addq.w       #$2, d3                                       ; $002B1E
        addq.w       #$2, d4                                       ; $002B20
        move.w       #$f, d6                                       ; $002B22

loc_002B26:
        move.w       (a0), d2                                      ; $002B26
        addi.w       #$4141, d2                                    ; $002B28
        move.w       d2, (a4)                                      ; $002B2C
        adda.w       #$100, a0                                     ; $002B2E
        dbra         d6, loc_002B26                                ; $002B32
        dbra         d7, loc_002AF2                                ; $002B36
        move.w       #$8f02, VDP_CONTROL.l                         ; $002B3A
        move.l       #$40000010, VDP_CONTROL.l                     ; $002B42
        move.l       #$7c000002, VDP_CONTROL.l                     ; $002B4C
        move.w       #$0, (a4)                                     ; $002B56
        move.w       #$1, rWallChangeRefreshFlag(a6)                               ; $002B5A
        move.w       rSceneColorMode(a6), d0                       ; $002B60
        move.w       #$ffff, rSceneColorMode(a6)                   ; $002B64
        jsr          SelectSceneColorMode.l                        ; $002B6A
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $002B70
        move.l       #$ffffffff, (a0)                              ; $002B74
        move.l       a0, rDmaQueueTail(a6)                         ; $002B7A
        move.w       #$1, rSpriteAttributeNextLink(a6)                               ; $002B7E
        move.l       #ramSpriteAttributeTable, rSpriteAttributeTableWritePointer(a6)                          ; $002B84
        move.w       #$2, rDisplayEnableDelay(a6)                               ; $002B8C
        rts                                                        ; $002B92
        ifne *-$2B94
        fail "ROM end moved"
        endif
