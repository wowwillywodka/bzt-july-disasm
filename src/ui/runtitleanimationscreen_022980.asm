; $022980..$022EB3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 543EC] показ экрана: инит VDP-регистров ($C00004: 0x8124, autoinc 0x4000_0000) + DMA-копирование (jsr 1A62)
        ifne *-$22980
        fail "ROM start moved"
        endif

RunTitleAnimationScreen:
        jsr          WaitForVBlank.l                               ; $022980
        move.w       #$8124, VDP_CONTROL.l                         ; $022986
        move.l       #$40000000, VDP_CONTROL.l                     ; $02298E
        move.w       #$3fff, d0                                    ; $022998

loc_02299C:
        move.l       #$0, VDP_DATA.l                               ; $02299C
        dbra         d0, loc_02299C                                ; $0229A6
        move.l       #$7c000002, VDP_CONTROL.l                     ; $0229AA
        move.l       #$0, VDP_DATA.l                               ; $0229B4
        move.l       #$40000010, VDP_CONTROL.l                     ; $0229BE
        move.l       #$0, VDP_DATA.l                               ; $0229C8
        move.l       #$78000002, VDP_CONTROL.l                     ; $0229D2
        move.l       #$0, VDP_DATA.l                               ; $0229DC
        move.l       #$0, VDP_DATA.l                               ; $0229E6
        movea.l      #VDP_CONTROL, a0                              ; $0229F0
        lea.l        TitleLabels(pc), a2                           ; $0229F6
        moveq        #$12, d7                                      ; $0229FA

loc_0229FC:
        move.w       (a2)+, (a0)                                   ; $0229FC
        dbra         d7, loc_0229FC                                ; $0229FE
        move.l       #$c0000000, VDP_CONTROL.l                     ; $022A02
        movea.l      #TitlePalette, a0                             ; $022A0C
        movea.l      #VDP_DATA, a4                                 ; $022A12
        move.l       (a0)+, (a4)                                   ; $022A18
        move.l       (a0)+, (a4)                                   ; $022A1A
        move.l       (a0)+, (a4)                                   ; $022A1C
        move.l       (a0)+, (a4)                                   ; $022A1E
        move.l       (a0)+, (a4)                                   ; $022A20
        move.l       (a0)+, (a4)                                   ; $022A22
        move.l       (a0)+, (a4)                                   ; $022A24
        move.l       (a0)+, (a4)                                   ; $022A26
        move.w       #$17, d7                                      ; $022A28
        moveq        #$0, d6                                       ; $022A2C

loc_022A2E:
        move.l       d6, (a4)                                      ; $022A2E
        dbra         d7, loc_022A2E                                ; $022A30
        move.l       #$60000003, VDP_CONTROL.l                     ; $022A34
        move.w       #$7ff, d7                                     ; $022A3E

loc_022A42:
        move.l       d6, (a4)                                      ; $022A42
        dbra         d7, loc_022A42                                ; $022A44
        move.l       #$40000003, VDP_CONTROL.l                     ; $022A48
        move.w       #$7ff, d7                                     ; $022A52

loc_022A56:
        move.l       d6, (a4)                                      ; $022A56
        dbra         d7, loc_022A56                                ; $022A58
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $022A5C
        move.l       #$ffffffff, (a0)                              ; $022A60
        move.l       a0, rDmaQueueTail(a6)                         ; $022A66
        move.l       #$40000000, VDP_CONTROL.l                     ; $022A6A
        move.l       d6, (a4)                                      ; $022A74
        move.l       d6, (a4)                                      ; $022A76
        move.l       d6, (a4)                                      ; $022A78
        move.l       d6, (a4)                                      ; $022A7A
        move.l       d6, (a4)                                      ; $022A7C
        move.l       d6, (a4)                                      ; $022A7E
        move.l       d6, (a4)                                      ; $022A80
        move.l       d6, (a4)                                      ; $022A82
; Retained title path expects a count/offset header at RetainedTitleGlyphTiles; actual first words are zero. Do not reinterpret the glyph pixels as a valid header. See docs/WALL_GRAPHICS.md.
        movea.l      #RetainedTitleGlyphTiles, a0                  ; $022A84
        move.w       (a0), d6                                      ; $022A8A
        adda.w       $2(a0), a0                                    ; $022A8C
        subq.w       #$1, d6                                       ; $022A90

loc_022A92:
        move.l       (a0)+, (a4)                                   ; $022A92
        move.l       (a0)+, (a4)                                   ; $022A94
        move.l       (a0)+, (a4)                                   ; $022A96
        move.l       (a0)+, (a4)                                   ; $022A98
        move.l       (a0)+, (a4)                                   ; $022A9A
        move.l       (a0)+, (a4)                                   ; $022A9C
        move.l       (a0)+, (a4)                                   ; $022A9E
        move.l       (a0)+, (a4)                                   ; $022AA0
        dbra         d6, loc_022A92                                ; $022AA2
        movea.l      #RetainedTitleGlyphTiles, a0                  ; $022AA6
        move.w       (a0), d6                                      ; $022AAC
        adda.w       $2(a0), a0                                    ; $022AAE
        subq.w       #$1, d6                                       ; $022AB2

loc_022AB4:
        move.l       (a0)+, (a4)                                   ; $022AB4
        move.l       (a0)+, (a4)                                   ; $022AB6
        move.l       (a0)+, (a4)                                   ; $022AB8
        move.l       (a0)+, (a4)                                   ; $022ABA
        move.l       (a0)+, (a4)                                   ; $022ABC
        move.l       (a0)+, (a4)                                   ; $022ABE
        move.l       (a0)+, (a4)                                   ; $022AC0
        move.l       (a0)+, (a4)                                   ; $022AC2
        dbra         d6, loc_022AB4                                ; $022AC4
        move.l       #$6d000003, VDP_CONTROL.l                     ; $022AC8
        movea.l      #$14cd00, a0                                  ; $022AD2
        move.w       #$77f, d7                                     ; $022AD8
        move.w       #$4090, d1                                    ; $022ADC

loc_022AE0:
        move.w       (a0)+, d0                                     ; $022AE0
        add.w        d1, d0                                        ; $022AE2
        move.w       d0, (a4)                                      ; $022AE4
        dbra         d7, loc_022AE0                                ; $022AE6
        move.l       #$4d000003, VDP_CONTROL.l                     ; $022AEA
        movea.l      #$14cd00, a0                                  ; $022AF4
        move.w       #$77f, d7                                     ; $022AFA
        move.w       #$6090, d1                                    ; $022AFE

loc_022B02:
        move.w       (a0)+, d0                                     ; $022B02
        add.w        d1, d0                                        ; $022B04
        move.w       d0, (a4)                                      ; $022B06
        dbra         d7, loc_022B02                                ; $022B08
        move.l       #$6aa00001, VDP_CONTROL.l                     ; $022B0C
        lea.l        RetainedTitleGlyphTiles.l, a0                 ; $022B16
        move.w       #$5af, d7                                     ; $022B1C

loc_022B20:
        move.l       (a0)+, VDP_DATA.l                             ; $022B20
        dbra         d7, loc_022B20                                ; $022B26
; This retained title transfer copies exactly $D0 longs ($340 bytes) of raw VDP glyph tiles. Other reads in this routine have incompatible sizes/headers; preserved unchanged.
        lea.l        RetainedTitleGlyphTiles.l, a0                 ; $022B2A
        move.w       #$cf, d7                                      ; $022B30

loc_022B34:
        move.l       (a0)+, VDP_DATA.l                             ; $022B34
        dbra         d7, loc_022B34                                ; $022B3A
        clr.w        rTitleScrollVerticalOffset(a6)                                    ; $022B3E
        clr.w        rTitleScrollFrameDivider(a6)                                    ; $022B42
        clr.w        rTitleScrollDisplacement(a6)                                    ; $022B46
        clr.w        rTitleScrollTrack0Ticks(a6)                                    ; $022B4A
        clr.w        rTitleScrollTrack1Ticks(a6)                                    ; $022B4E
        move.l       #TitleScrollWordSequences, rTitleScrollTrack0Pointer(a6)         ; $022B52
        move.l       #$22fd6, rTitleScrollTrack1Pointer(a6)                           ; $022B5A
        move.l       #TitleAnimationCurves, rTitleScrollCurve0Pointer(a6)             ; $022B62
        move.l       #TitleAnimationCurves, rTitleScrollCurve1Pointer(a6)             ; $022B6A
        jsr          WaitForVBlank.l                               ; $022B72
        move.w       #$8164, VDP_CONTROL.l                         ; $022B78
        clr.w        rTitleScrollState(a6)                                    ; $022B80
        move.w       #$564, rMenuIdleCounter(a6)                   ; $022B84
        clr.w        rDemoMode(a6)                                 ; $022B8A

loc_022B8E:
        jsr          WaitForVBlank.l                               ; $022B8E
        jsr          FlushDmaQueue.l                               ; $022B94
        lea.l        rTitleScrollLayerWords(a6), a0                                ; $022B9A
        movea.l      #VDP_DATA, a4                                 ; $022B9E
        move.l       #$c0200000, VDP_CONTROL.l                     ; $022BA4
        move.l       (a0)+, (a4)                                   ; $022BAE
        move.l       (a0)+, (a4)                                   ; $022BB0
        move.l       (a0)+, (a4)                                   ; $022BB2
        move.l       (a0)+, (a4)                                   ; $022BB4
        move.l       (a0)+, (a4)                                   ; $022BB6
        move.l       (a0)+, (a4)                                   ; $022BB8
        move.l       (a0)+, (a4)                                   ; $022BBA
        move.l       (a0)+, (a4)                                   ; $022BBC
        movea.l      rTitleScrollCurve0Pointer(a6), a0                                ; $022BBE
        move.l       (a0)+, (a4)                                   ; $022BC2
        move.l       (a0)+, (a4)                                   ; $022BC4
        move.l       (a0)+, (a4)                                   ; $022BC6
        move.l       (a0)+, (a4)                                   ; $022BC8
        move.l       (a0)+, (a4)                                   ; $022BCA
        move.l       (a0)+, (a4)                                   ; $022BCC
        move.l       (a0)+, (a4)                                   ; $022BCE
        move.l       (a0)+, (a4)                                   ; $022BD0
        movea.l      rTitleScrollCurve1Pointer(a6), a0                                ; $022BD2
        move.l       (a0)+, (a4)                                   ; $022BD6
        move.l       (a0)+, (a4)                                   ; $022BD8
        move.l       (a0)+, (a4)                                   ; $022BDA
        move.l       (a0)+, (a4)                                   ; $022BDC
        move.l       (a0)+, (a4)                                   ; $022BDE
        move.l       (a0)+, (a4)                                   ; $022BE0
        move.l       (a0)+, (a4)                                   ; $022BE2
        move.l       (a0)+, (a4)                                   ; $022BE4
        jsr          ReadController.l                              ; $022BE6
        move.w       #$1, rSpriteAttributeNextLink(a6)                               ; $022BEC
        lea.l        rSpriteAttributeTable(a6), a0                                ; $022BF2
        move.l       a0, rSpriteAttributeTableWritePointer(a6)                                ; $022BF6
        bsr.w        AdvanceTitleScrollBackground                              ; $022BFA
        bsr.w        BuildTitleScrollLayers                              ; $022BFE
        addq.w       #$1, rTitleScrollFrameDivider(a6)                               ; $022C02
        cmpi.w       #$4, rTitleScrollFrameDivider(a6)                               ; $022C06
        bne.w        loc_022C9A                                    ; $022C0C
        clr.w        rTitleScrollFrameDivider(a6)                                    ; $022C10
        move.w       rTitleScrollVerticalOffset(a6), d2                                ; $022C14
        move.w       d2, d3                                        ; $022C18
        addi.w       #$54, d3                                      ; $022C1A
        andi.w       #$ff, d3                                      ; $022C1E
        addi.w       #$e000, d3                                    ; $022C22
        movea.l      #VDP_DATA, a4                                 ; $022C26
        addq.w       #$2, rTitleScrollVerticalOffset(a6)                               ; $022C2C
        cmpi.w       #$100, d2                                     ; $022C30
        bcc.b        loc_022C70                                    ; $022C34
        movea.l      #$14ce00, a0                                  ; $022C36
        adda.w       d2, a0                                        ; $022C3C
        move.w       #$b, d7                                       ; $022C3E
        move.w       #$100, d5                                     ; $022C42

loc_022C46:
        move.w       d3, d0                                        ; $022C46
        add.w        d5, d3                                        ; $022C48
        move.w       d0, d1                                        ; $022C4A
        andi.w       #$3fff, d1                                    ; $022C4C
        ori.w        #$4000, d1                                    ; $022C50
        swap         d1                                            ; $022C54
        lsr.w        #$8, d0                                       ; $022C56
        lsr.w        #$6, d0                                       ; $022C58
        move.w       d0, d1                                        ; $022C5A
        move.l       d1, VDP_CONTROL.l                             ; $022C5C
        move.w       (a0), d0                                      ; $022C62
        adda.w       d5, a0                                        ; $022C64
        addq.w       #$1, d0                                       ; $022C66
        move.w       d0, (a4)                                      ; $022C68
        dbra         d7, loc_022C46                                ; $022C6A
        bra.b        loc_022C9A                                    ; $022C6E

loc_022C70:
        move.w       #$b, d7                                       ; $022C70

loc_022C74:
        move.w       d3, d0                                        ; $022C74
        addi.w       #$100, d3                                     ; $022C76
        move.w       d0, d1                                        ; $022C7A
        andi.w       #$3fff, d1                                    ; $022C7C
        ori.w        #$4000, d1                                    ; $022C80
        swap         d1                                            ; $022C84
        lsr.w        #$8, d0                                       ; $022C86
        lsr.w        #$6, d0                                       ; $022C88
        move.w       d0, d1                                        ; $022C8A
        move.l       d1, VDP_CONTROL.l                             ; $022C8C
        move.w       #$0, (a4)                                     ; $022C92
        dbra         d7, loc_022C74                                ; $022C96

loc_022C9A:
        subq.w       #$2, rTitleScrollDisplacement(a6)                               ; $022C9A
        move.w       rTitleScrollDisplacement(a6), d0                                ; $022C9E
        lea.l        rTitleScrollLayerWordsEnd(a6), a0                                ; $022CA2
        move.w       #$cf, d7                                      ; $022CA6

loc_022CAA:
        move.w       d0, (a0)+                                     ; $022CAA
        dbra         d7, loc_022CAA                                ; $022CAC
        move.w       rTitleScrollTrack0Ticks(a6), d0                                ; $022CB0
        cmpi.w       #$40, d0                                      ; $022CB4
        bcs.b        loc_022CBE                                    ; $022CB8
        move.w       #$3f, d0                                      ; $022CBA

loc_022CBE:
        subi.w       #$20, d0                                      ; $022CBE
        ext.l        d0                                            ; $022CC2
        move.w       rTitleScrollTrack1Ticks(a6), d4                                ; $022CC4
        cmpi.w       #$40, d4                                      ; $022CC8
        bcs.b        loc_022CD2                                    ; $022CCC
        move.w       #$3f, d4                                      ; $022CCE

loc_022CD2:
        subi.w       #$20, d4                                      ; $022CD2
        ext.l        d4                                            ; $022CD6
        move.l       #$ffffe9e0, d2                                ; $022CD8
        move.l       #$ffffe9e0, d3                                ; $022CDE
        move.w       #$77, d7                                      ; $022CE4

loc_022CE8:
        sub.l        d0, d2                                        ; $022CE8
        sub.l        d4, d3                                        ; $022CEA
        move.l       d2, d1                                        ; $022CEC
        asr.l        #$4, d1                                       ; $022CEE
        bclr.l       #$0, d1                                       ; $022CF0
        move.w       d1, (a0)+                                     ; $022CF4
        move.l       d3, d1                                        ; $022CF6
        asr.l        #$4, d1                                       ; $022CF8
        bset.l       #$0, d1                                       ; $022CFA
        move.w       d1, (a0)+                                     ; $022CFE
        dbra         d7, loc_022CE8                                ; $022D00
        move.w       #$f, d7                                       ; $022D04
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $022D08
        lea.l        TitleStaticSpriteMappings(pc), a0             ; $022D0C
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $022D10

loc_022D14:
        move.w       (a0)+, (a2)+                                  ; $022D14
        move.w       (a0)+, d1                                     ; $022D16
        or.w         d0, d1                                        ; $022D18
        move.w       d1, (a2)+                                     ; $022D1A
        addq.w       #$1, d0                                       ; $022D1C
        move.l       (a0)+, (a2)+                                  ; $022D1E
        dbra         d7, loc_022D14                                ; $022D20
        move.w       rTitleScrollState(a6), d1                                ; $022D24
        beq.w        loc_022D66                                    ; $022D28
        subq.w       #$1, d1                                       ; $022D2C
        lsl.w        #$3, d1                                       ; $022D2E
        move.w       d1, d2                                        ; $022D30
        lsl.w        #$1, d1                                       ; $022D32
        add.w        d2, d1                                        ; $022D34
        addi.w       #$112, d1                                     ; $022D36
        move.w       d1, (a2)+                                     ; $022D3A
        move.w       #$400, d1                                     ; $022D3C
        or.w         d0, d1                                        ; $022D40
        addq.w       #$1, d0                                       ; $022D42
        move.w       d1, (a2)+                                     ; $022D44
        move.w       #$840b, (a2)+                                 ; $022D46
        move.w       #$fc, (a2)+                                   ; $022D4A
        move.w       #$3, d7                                       ; $022D4E
        lea.l        TitleSpriteMappings(pc), a0                   ; $022D52

loc_022D56:
        move.w       (a0)+, (a2)+                                  ; $022D56
        move.w       (a0)+, d1                                     ; $022D58
        or.w         d0, d1                                        ; $022D5A
        move.w       d1, (a2)+                                     ; $022D5C
        addq.w       #$1, d0                                       ; $022D5E
        move.l       (a0)+, (a2)+                                  ; $022D60
        dbra         d7, loc_022D56                                ; $022D62

loc_022D66:
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $022D66
        move.w       d0, rSpriteAttributeNextLink(a6)                                ; $022D6A
        move.l       #ramTitleScrollLayerWordsEnd, d4                                  ; $022D6E
        move.w       #$1c0, d6                                     ; $022D74
        move.w       #$bc00, d5                                    ; $022D78
        jsr          QueueVramDma.l                                ; $022D7C
        movea.l      rSpriteAttributeTableWritePointer(a6), a0                                ; $022D82
        cmpa.l       #ramSpriteAttributeTable, a0                                  ; $022D86
        beq.b        loc_022D94                                    ; $022D8C
        clr.b        -$5(a0)                                       ; $022D8E
        bra.b        loc_022D98                                    ; $022D92

loc_022D94:
        clr.l        (a0)+                                         ; $022D94
        clr.l        (a0)+                                         ; $022D96

loc_022D98:
        move.l       a0, d6                                        ; $022D98
        move.l       #ramSpriteAttributeTable, d4                                  ; $022D9A
        sub.l        d4, d6                                        ; $022DA0
        lsr.w        #$1, d6                                       ; $022DA2
        move.l       #$b800, d5                                    ; $022DA4
        jsr          QueueVramDma.l                                ; $022DAA
        movea.l      rDmaQueueTail(a6), a0                         ; $022DB0
        move.l       #$ffffffff, (a0)                              ; $022DB4
        subq.w       #$1, rMenuIdleCounter(a6)                     ; $022DBA
        bne.b        loc_022DE2                                    ; $022DBE
        move.w       #$1, rTitleScrollState(a6)                               ; $022DC0
        jsr          NextRandom.w                                  ; $022DC6
        swap         d2                                            ; $022DCA
        andi.l       #$ff, d2                                      ; $022DCC
        divu.w       #$56, d2                                      ; $022DD2
        move.w       d2, rLegacyEpisodeSelection(a6)               ; $022DD6
        move.w       #$1, rDemoMode(a6)                            ; $022DDA
        bra.b        loc_022E4E                                    ; $022DE0

loc_022DE2:
        cmpi.w       #$faa0, rTitleScrollDisplacement(a6)                            ; $022DE2
        bne.b        loc_022DEE                                    ; $022DE8
        bsr.w        InitializeTitleScrollBackground                              ; $022DEA

loc_022DEE:
        move.b       rControllerState(a6), d0                      ; $022DEE
        andi.w       #$f0, d0                                      ; $022DF2
        beq.b        loc_022E12                                    ; $022DF6
        move.b       rPreviousControllerState(a6), d1              ; $022DF8
        and.b        d0, d1                                        ; $022DFC
        cmp.b        d0, d1                                        ; $022DFE
        beq.b        loc_022E12                                    ; $022E00
        tst.w        rTitleScrollState(a6)                                    ; $022E02
        bne.b        loc_022E4E                                    ; $022E06
        move.w       #$1, rTitleScrollState(a6)                               ; $022E08
        bra.w        loc_022B8E                                    ; $022E0E

loc_022E12:
        btst.b       #$0, rControllerState(a6)                     ; $022E12
        beq.b        loc_022E2E                                    ; $022E18
        btst.b       #$0, rPreviousControllerState(a6)             ; $022E1A
        bne.b        loc_022E2E                                    ; $022E20
        tst.w        rTitleScrollState(a6)                                    ; $022E22
        beq.b        loc_022E2E                                    ; $022E26
        move.w       #$1, rTitleScrollState(a6)                               ; $022E28

loc_022E2E:
        btst.b       #$1, rControllerState(a6)                     ; $022E2E
        beq.b        loc_022E4A                                    ; $022E34
        btst.b       #$1, rPreviousControllerState(a6)             ; $022E36
        bne.b        loc_022E4A                                    ; $022E3C
        tst.w        rTitleScrollState(a6)                                    ; $022E3E
        beq.b        loc_022E4A                                    ; $022E42
        move.w       #$2, rTitleScrollState(a6)                               ; $022E44

loc_022E4A:
        bra.w        loc_022B8E                                    ; $022E4A

loc_022E4E:
        jsr          WaitForVBlank.l                               ; $022E4E
        move.w       #$8124, VDP_CONTROL.l                         ; $022E54
        jsr          InitializeVdpRegisters.l                      ; $022E5C
        move.l       #$c0000000, VDP_CONTROL.l                     ; $022E62
        movea.l      #VDP_DATA, a4                                 ; $022E6C
        moveq        #$0, d6                                       ; $022E72
        move.w       #$1f, d7                                      ; $022E74

loc_022E78:
        move.l       d6, (a4)                                      ; $022E78
        dbra         d7, loc_022E78                                ; $022E7A
        move.l       #$7c000002, VDP_CONTROL.l                     ; $022E7E
        move.l       d6, (a4)                                      ; $022E88
        move.l       #$40000010, VDP_CONTROL.l                     ; $022E8A
        move.l       d6, (a4)                                      ; $022E94
        move.l       #$78000002, VDP_CONTROL.l                     ; $022E96
        move.l       d6, (a4)                                      ; $022EA0
        move.l       d6, (a4)                                      ; $022EA2
        jsr          WaitForVBlank.l                               ; $022EA4
        move.w       #$8164, VDP_CONTROL.l                         ; $022EAA
        rts                                                        ; $022EB2
        ifne *-$22EB4
        fail "ROM end moved"
        endif
