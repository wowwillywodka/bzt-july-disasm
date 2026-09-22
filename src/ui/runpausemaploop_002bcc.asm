; $002BCC..$002FAD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Pause/map loop selected by PauseFlags. It is separate from scene completion and the five-character selection screen.
        ifne *-$2BCC
        fail "ROM start moved"
        endif

RunPauseMapLoop:
; Pause/map loop selected by PauseFlags. It is separate from scene completion and the five-character selection screen.
        move.w       #$0, -$213c(a6)                               ; $002BCC
        clr.w        -$7ffe(a6)                                    ; $002BD2
        bsr.w        WaitForVBlank                                 ; $002BD6
        move.w       #$8124, VDP_CONTROL.l                         ; $002BDA
        bsr.w        ResetVerticalScroll                           ; $002BE2
        move.l       #$c07e0000, VDP_CONTROL.l                     ; $002BE6
        move.w       #$0, VDP_DATA.l                               ; $002BF0
        jsr          PauseGemsSequences.l                          ; $002BF8
        bsr.w        ClearVramLongs                                ; $002BFE
        bsr.w        ClearVideoMemory                              ; $002C02
        lea.l        PauseMapFrameCompressedTiles.l, a3            ; $002C06
        move.w       #$141, d0                                     ; $002C0C
; Decompress pause/map frame tiles to VRAM tile $141; map at PauseMapFrameTilemap, 40x28.
        jsr          DecompressBytePairToVramLong.l                ; $002C10
        lea.l        PauseMapFrameTilemap.l, a0                    ; $002C16
        movea.l      #UiRoutine_00E000, a1                         ; $002C1C
        move.w       #$28, d0                                      ; $002C22
        move.w       #$1c, d1                                      ; $002C26
        move.w       #$40, d2                                      ; $002C2A
        move.w       #$141, d3                                     ; $002C2E
        jsr          UploadAttributedTilemap.l                     ; $002C32
        lea.l        InventoryIconPalettes.l, a0                   ; $002C38
        move.w       #$0, d0                                       ; $002C3E
        jsr          LoadPaletteLine.l                             ; $002C42
        move.l       #TitleCharacterOrder, -$76ea(a6)              ; $002C48
        move.l       #$2fb4, -$76e4(a6)                            ; $002C50
        move.l       #$4e800001, VDP_CONTROL.l                     ; $002C58
        lea.l        Data_15CA58.l, a0                             ; $002C62
        move.w       #$97, d7                                      ; $002C68

loc_002C6C:
        move.l       (a0)+, VDP_DATA.l                             ; $002C6C
        dbra         d7, loc_002C6C                                ; $002C72
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $002C76
        move.w       #$287, d0                                     ; $002C7C
        jsr          DecompressBytePairToVramLong.l                ; $002C80
        bsr.w        CollectVisibleMapObjects                      ; $002C86
        move.w       #$c198, d2                                    ; $002C8A
        move.w       #$e341, d3                                    ; $002C8E
        move.w       #$f, d7                                       ; $002C92
        movea.l      #VDP_DATA, a4                                 ; $002C96

loc_002C9C:
        move.w       #$f, d6                                       ; $002C9C
        move.w       d2, d0                                        ; $002CA0
        addi.w       #$80, d2                                      ; $002CA2
        move.w       d0, d1                                        ; $002CA6
        andi.w       #$3fff, d1                                    ; $002CA8
        ori.w        #$4000, d1                                    ; $002CAC
        swap         d1                                            ; $002CB0
        lsr.w        #$8, d0                                       ; $002CB2
        lsr.w        #$6, d0                                       ; $002CB4
        move.w       d0, d1                                        ; $002CB6
        move.l       d1, VDP_CONTROL.l                             ; $002CB8

loc_002CBE:
        move.w       d3, (a4)                                      ; $002CBE
        addq.w       #$1, d3                                       ; $002CC0
        dbra         d6, loc_002CBE                                ; $002CC2
        dbra         d7, loc_002C9C                                ; $002CC6
        move.l       #$40000010, VDP_CONTROL.l                     ; $002CCA
        move.w       #$0, (a4)                                     ; $002CD4
        move.w       #$fffc, (a4)                                  ; $002CD8
        move.l       #$c0400000, VDP_CONTROL.l                     ; $002CDC
        movea.l      #InterfacePalettes, a0                        ; $002CE6
        move.l       (a0)+, (a4)                                   ; $002CEC
        move.l       (a0)+, (a4)                                   ; $002CEE
        move.l       (a0)+, (a4)                                   ; $002CF0
        move.l       (a0)+, (a4)                                   ; $002CF2
        move.l       (a0)+, (a4)                                   ; $002CF4
        move.l       (a0)+, (a4)                                   ; $002CF6
        move.l       (a0)+, (a4)                                   ; $002CF8
        move.l       (a0)+, (a4)                                   ; $002CFA
        move.l       #$68200001, VDP_CONTROL.l                     ; $002CFC
        move.w       #$7ff, d7                                     ; $002D06

loc_002D0A:
        move.l       #$0, VDP_DATA.l                               ; $002D0A
        dbra         d7, loc_002D0A                                ; $002D14
        bsr.w        RenderSceneWalls                              ; $002D18
        lea.l        -$7abc(a6), a0                                ; $002D1C
        move.l       #$ffffffff, (a0)                              ; $002D20
        move.l       a0, rDmaQueueTail(a6)                         ; $002D26
        move.w       #$1, -$7fbe(a6)                               ; $002D2A
        move.l       #$ff0044, -$7fc2(a6)                          ; $002D30
        move.w       rLegacyObjectiveFloor(a6), -$6fac(a6)         ; $002D38
        move.w       -$6fac(a6), d1                                ; $002D3E
        jsr          PrintFirstSceneLabel.l                        ; $002D42
        clr.w        -$6faa(a6)                                    ; $002D48
        move.w       rCurrentFloor(a6), d0                         ; $002D4C
        add.w        d0, d0                                        ; $002D50
        lea.l        TwoDigitCharacterLabels(pc), a1               ; $002D52
        lea.l        -$6fdc(a6), a0                                ; $002D56
        move.w       (a1, d0.w), (a0)                              ; $002D5A
        move.b       #$0, $2(a0)                                   ; $002D5E
        move.w       #$e000, d0                                    ; $002D64
        jsr          PrintCenteredText.l                           ; $002D68
        bsr.w        WaitForVBlank                                 ; $002D6E
        move.w       #$8164, VDP_CONTROL.l                         ; $002D72

loc_002D7A:
        bsr.w        WaitForVBlank                                 ; $002D7A
        bsr.w        FlushDmaQueue                                 ; $002D7E
        bsr.w        UpdateDemoInput                               ; $002D82
        movem.l      d0-d7/a0-a6, -(a7)                            ; $002D86
        bsr.w        RenderSceneWalls                              ; $002D8A
        movem.l      (a7)+, d0-d7/a0-a6                            ; $002D8E
        btst.b       #$2, rControllerState(a6)                     ; $002D92
        beq.b        loc_002DAE                                    ; $002D98
        move.w       rMapWindowOriginX(a6), d1                     ; $002D9A
        move.w       -$2262(a6), d0                                ; $002D9E
        neg.w        d0                                            ; $002DA2
        cmp.w        d0, d1                                        ; $002DA4
        beq.b        loc_002DAE                                    ; $002DA6
        subq.w       #$1, -$2262(a6)                               ; $002DA8
        bra.b        loc_002DD4                                    ; $002DAC

loc_002DAE:
        btst.b       #$3, rControllerState(a6)                     ; $002DAE
        beq.b        loc_002DD4                                    ; $002DB4
        move.w       rCurrentFloorWidth(a6), d0                    ; $002DB6
        sub.w        rMapWindowOriginX(a6), d0                     ; $002DBA
        subi.w       #$20, d0                                      ; $002DBE
        cmp.w        -$2262(a6), d0                                ; $002DC2
        beq.b        loc_002DD4                                    ; $002DC6
        cmpi.w       #$20, rCurrentFloorWidth(a6)                  ; $002DC8
        ble.b        loc_002DD4                                    ; $002DCE
        addq.w       #$1, -$2262(a6)                               ; $002DD0

loc_002DD4:
        btst.b       #$0, rControllerState(a6)                     ; $002DD4
        beq.b        loc_002DEE                                    ; $002DDA
        move.w       rMapWindowOriginY(a6), d1                     ; $002DDC
        move.w       -$2260(a6), d0                                ; $002DE0
        neg.w        d0                                            ; $002DE4
        cmp.w        d0, d1                                        ; $002DE6
        beq.b        loc_002DEE                                    ; $002DE8
        subq.w       #$1, -$2260(a6)                               ; $002DEA

loc_002DEE:
        btst.b       #$1, rControllerState(a6)                     ; $002DEE
        beq.b        loc_002E14                                    ; $002DF4
        move.w       rCurrentFloorHeight(a6), d0                   ; $002DF6
        sub.w        rMapWindowOriginY(a6), d0                     ; $002DFA
        subi.w       #$20, d0                                      ; $002DFE
        cmp.w        -$2260(a6), d0                                ; $002E02
        beq.b        loc_002E14                                    ; $002E06
        cmpi.w       #$20, rCurrentFloorHeight(a6)                 ; $002E08
        ble.b        loc_002E14                                    ; $002E0E
        addq.w       #$1, -$2260(a6)                               ; $002E10

loc_002E14:
        move.w       #$1, -$7fbe(a6)                               ; $002E14
        move.l       #$ff0044, -$7fc2(a6)                          ; $002E1A
        btst.b       #$4, -$7fff(a6)                               ; $002E22
        beq.b        loc_002E96                                    ; $002E28
        movea.l      -$7fc2(a6), a2                                ; $002E2A
        move.w       rPlayerY(a6), d0                              ; $002E2E
        asr.w        #$6, d0                                       ; $002E32
        move.w       -$2260(a6), d1                                ; $002E34
        asl.w        #$2, d1                                       ; $002E38
        neg.w        d1                                            ; $002E3A
        add.w        d1, d0                                        ; $002E3C
        addi.w       #$d1, d0                                      ; $002E3E
        cmpi.w       #$151, d0                                     ; $002E42
        bge.b        loc_002E96                                    ; $002E46
        cmpi.w       #$d1, d0                                      ; $002E48
        ble.b        loc_002E96                                    ; $002E4C
        move.w       d0, -(a7)                                     ; $002E4E
        move.w       rPlayerX(a6), d0                              ; $002E50
        asr.w        #$6, d0                                       ; $002E54
        move.w       -$2262(a6), d1                                ; $002E56
        andi.w       #$fffe, d1                                    ; $002E5A
        asl.w        #$2, d1                                       ; $002E5E
        neg.w        d1                                            ; $002E60
        add.w        d1, d0                                        ; $002E62
        addi.w       #$dd, d0                                      ; $002E64
        move.w       d0, d1                                        ; $002E68
        move.w       (a7)+, d0                                     ; $002E6A
        cmpi.w       #$15d, d1                                     ; $002E6C
        bge.b        loc_002E96                                    ; $002E70
        cmpi.w       #$dd, d1                                      ; $002E72
        ble.b        loc_002E96                                    ; $002E76
        subi.w       #$38, d0                                      ; $002E78
        move.w       d0, (a2)+                                     ; $002E7C
        move.w       -$7fbe(a6), d0                                ; $002E7E
        ori.w        #$0, d0                                       ; $002E82
        move.w       d0, (a2)+                                     ; $002E86
        addq.w       #$1, -$7fbe(a6)                               ; $002E88
        move.w       #$e276, (a2)+                                 ; $002E8C
        move.w       d1, (a2)+                                     ; $002E90
        move.l       a2, -$7fc2(a6)                                ; $002E92

loc_002E96:
        movea.l      -$7fc2(a6), a2                                ; $002E96
        jsr          UiRoutine_0114FA.l                            ; $002E9A
        move.l       a2, -$7fc2(a6)                                ; $002EA0
        movea.l      rDmaQueueTail(a6), a0                         ; $002EA4
        move.l       #$ffffffff, (a0)                              ; $002EA8
        bsr.w        ProjectMapObjects                             ; $002EAE
        jsr          UploadSpriteTable.l                           ; $002EB2
        jsr          loc_002FEC.l                                  ; $002EB8
        tst.w        rLinkRole(a6)                                 ; $002EBE
        beq.b        loc_002ED8                                    ; $002EC2
        cmpi.w       #$1, rLinkRole(a6)                            ; $002EC4
        bne.b        loc_002ED2                                    ; $002ECA
        jsr          TransmitLinkCommands.l                        ; $002ECC

loc_002ED2:
        jsr          ExecuteLinkCommands.l                         ; $002ED2

loc_002ED8:
        btst.b       #$6, rControllerState(a6)                     ; $002ED8
        beq.b        loc_002EFA                                    ; $002EDE
        btst.b       #$4, rControllerState(a6)                     ; $002EE0
        beq.b        loc_002EFA                                    ; $002EE6
        btst.b       #$5, rControllerState(a6)                     ; $002EE8
        beq.b        loc_002EFA                                    ; $002EEE
        jsr          RunInventoryStatusLoop.l                      ; $002EF0
        jmp          UiRoutine_0028C4(pc)                          ; $002EF6

loc_002EFA:
        tst.b        rControllerState(a6)                          ; $002EFA
        beq.b        loc_002F34                                    ; $002EFE
        move.b       rControllerState(a6), d0                      ; $002F00
        cmp.b        -$76ec(a6), d0                                ; $002F04
        beq.b        loc_002F34                                    ; $002F08
        move.b       d0, -$76ec(a6)                                ; $002F0A
        movea.l      -$76ea(a6), a0                                ; $002F0E
        move.b       (a0), d0                                      ; $002F12
        btst.b       d0, rControllerState(a6)                      ; $002F14
        beq.b        loc_002F2C                                    ; $002F18
        addq.l       #$1, -$76ea(a6)                               ; $002F1A
        cmpi.b       #$ff, $1(a0)                                  ; $002F1E
        bne.b        loc_002F34                                    ; $002F24
        eori.b       #$1, -$76eb(a6)                               ; $002F26

loc_002F2C:
        move.l       #TitleCharacterOrder, -$76ea(a6)              ; $002F2C

loc_002F34:
        tst.b        rControllerState(a6)                          ; $002F34
        beq.b        loc_002F6E                                    ; $002F38
        move.b       rControllerState(a6), d0                      ; $002F3A
        cmp.b        -$76e6(a6), d0                                ; $002F3E
        beq.b        loc_002F6E                                    ; $002F42
        move.b       d0, -$76e6(a6)                                ; $002F44
        movea.l      -$76e4(a6), a0                                ; $002F48
        move.b       (a0), d0                                      ; $002F4C
        btst.b       d0, rControllerState(a6)                      ; $002F4E
        beq.b        loc_002F66                                    ; $002F52
        addq.l       #$1, -$76e4(a6)                               ; $002F54
        cmpi.b       #$ff, $1(a0)                                  ; $002F58
        bne.b        loc_002F6E                                    ; $002F5E
        jsr          UiRoutine_011648.l                            ; $002F60

loc_002F66:
        move.l       #$2fb4, -$76e4(a6)                            ; $002F66

loc_002F6E:
        btst.b       #$0, rPauseFlags(a6)                          ; $002F6E
        beq.b        loc_002F9A                                    ; $002F74
        btst.b       #$7, rControllerState(a6)                     ; $002F76
        beq.b        loc_002F9A                                    ; $002F7C
        btst.b       #$7, rPreviousControllerState(a6)             ; $002F7E
        bne.b        loc_002F9A                                    ; $002F84
        bclr.b       #$0, rPauseFlags(a6)                          ; $002F86
        lea.l        -$6fdc(a6), a0                                ; $002F8C
        move.b       #$15, (a0)                                    ; $002F90
        jsr          QueueLinkCommand.l                            ; $002F94

loc_002F9A:
        tst.b        rPauseFlags(a6)                               ; $002F9A
        bne.w        loc_002D7A                                    ; $002F9E
        jsr          ResumeGemsSequences.l                         ; $002FA2
        bsr.w        UiRoutine_0028C4                              ; $002FA8
        rts                                                        ; $002FAC
        ifne *-$2FAE
        fail "ROM end moved"
        endif
