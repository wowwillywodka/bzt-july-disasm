; $028740..$028B97 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: VDP setup, palette cycling and repeated direct D4E4 wall calls; ordinary entry not established
        ifne *-$28740
        fail "ROM start moved"
        endif

RetainedWallRendererScreenEffect:
        clr.w        rVBlankTransferPhasesRemaining(a6)                                    ; $028740
        jsr          ClearVramLongs.l                              ; $028744
        jsr          ClearVideoMemory.l                            ; $02874A
        movea.l      #VDP_DATA, a4                                 ; $028750
        move.l       #$c0000000, VDP_CONTROL.l                     ; $028756
        movea.l      #RetainedScreenEffectBaseColors, a0           ; $028760
        move.l       (a0)+, (a4)                                   ; $028766
        move.l       (a0)+, (a4)                                   ; $028768
        move.l       (a0)+, (a4)                                   ; $02876A
        move.l       (a0)+, (a4)                                   ; $02876C
        move.l       (a0)+, (a4)                                   ; $02876E
        move.l       (a0)+, (a4)                                   ; $028770
        move.l       (a0)+, (a4)                                   ; $028772
        move.l       (a0)+, (a4)                                   ; $028774
        move.l       #$40200000, VDP_CONTROL.l                     ; $028776
        moveq        #$0, d6                                       ; $028780
        move.w       #$27f, d7                                     ; $028782

loc_028786:
        move.l       d6, (a4)                                      ; $028786
        move.l       d6, (a4)                                      ; $028788
        move.l       d6, (a4)                                      ; $02878A
        move.l       d6, (a4)                                      ; $02878C
        dbra         d7, loc_028786                                ; $02878E
        lea.l        rSoftwareFrameBuffer(a6), a0                                ; $028792
        move.w       #$27f, d7                                     ; $028796

loc_02879A:
        move.l       d6, (a0)+                                     ; $02879A
        move.l       d6, (a0)+                                     ; $02879C
        move.l       d6, (a0)+                                     ; $02879E
        move.l       d6, (a0)+                                     ; $0287A0
        dbra         d7, loc_02879A                                ; $0287A2
        move.l       #$c488, d1                                    ; $0287A6
        move.w       #$1f, d2                                      ; $0287AC
        move.w       #$8001, d4                                    ; $0287B0

loc_0287B4:
        move.l       d1, d0                                        ; $0287B4
        move.w       #$9, d3                                       ; $0287B6

loc_0287BA:
        movem.l      d0-d4, -(a7)                                  ; $0287BA
        move.w       d0, d1                                        ; $0287BE
        andi.w       #$3fff, d1                                    ; $0287C0
        ori.w        #$4000, d1                                    ; $0287C4
        swap         d1                                            ; $0287C8
        lsr.w        #$8, d0                                       ; $0287CA
        lsr.w        #$6, d0                                       ; $0287CC
        move.w       d0, d1                                        ; $0287CE
        move.l       d1, VDP_CONTROL.l                             ; $0287D0
        movem.l      (a7)+, d0-d4                                  ; $0287D6
        move.w       d4, VDP_DATA.l                                ; $0287DA
        addi.l       #$80, d0                                      ; $0287E0
        addq.w       #$1, d4                                       ; $0287E6
        dbra         d3, loc_0287BA                                ; $0287E8
        addq.l       #$2, d1                                       ; $0287EC
        dbra         d2, loc_0287B4                                ; $0287EE
        move.w       #$20, rWallEndpointBScreenX(a6)                              ; $0287F2
        move.w       #$40, rWallEndpointBInverseDepth(a6)                              ; $0287F8
        move.w       #$5f, rWallEndpointAScreenX(a6)                              ; $0287FE
        move.w       #$40, rWallEndpointAInverseDepth(a6)                              ; $028804
        lea.l        rVramDmaCommandQueue(a6), a0                                ; $02880A
        move.l       #$ffffffff, (a0)                              ; $02880E
        move.l       a0, rDmaQueueTail(a6)                         ; $028814
        clr.w        rRetainedWallEffectOffset(a6)                                    ; $028818
        move.w       #$e00, rRetainedWallEffectScale(a6)                             ; $02881C

loc_028822:
        move.w       #$2, rVBlankTransferPhasesRemaining(a6)                               ; $028822
        jsr          WaitForVBlank.l                               ; $028828
        movea.l      #VDP_DATA, a4                                 ; $02882E
        move.l       #$c0080000, VDP_CONTROL.l                     ; $028834
        movea.l      #RetainedScreenEffectColorCycle, a0           ; $02883E
        move.w       rGameTick(a6), d0                             ; $028844
        addq.w       #$1, d0                                       ; $028848
        cmpi.w       #$16, d0                                      ; $02884A
        bcs.b        loc_028852                                    ; $02884E
        clr.w        d0                                            ; $028850

loc_028852:
        move.w       d0, rGameTick(a6)                             ; $028852
        lsl.w        #$1, d0                                       ; $028856
        adda.w       d0, a0                                        ; $028858
        move.l       (a0)+, (a4)                                   ; $02885A
        move.l       (a0)+, (a4)                                   ; $02885C
        move.l       (a0)+, (a4)                                   ; $02885E
        move.l       (a0)+, (a4)                                   ; $028860
        move.l       (a0)+, (a4)                                   ; $028862
        move.l       (a0)+, (a4)                                   ; $028864
        subq.w       #$8, rRetainedWallEffectOffset(a6)                               ; $028866
        move.w       rRetainedWallEffectScale(a6), d0                                ; $02886A
        subi.w       #$2b5, d0                                     ; $02886E
        asr.w        #$4, d0                                       ; $028872
        cmpi.w       #$18, d0                                      ; $028874
        bcc.b        loc_02887E                                    ; $028878
        move.w       #$18, d0                                      ; $02887A

loc_02887E:
        neg.w        d0                                            ; $02887E
        add.w        rRetainedWallEffectScale(a6), d0                                ; $028880
        cmpi.w       #$2b5, d0                                     ; $028884
        bcc.b        loc_02888E                                    ; $028888
        move.w       #$2b5, d0                                     ; $02888A

loc_02888E:
        move.w       d0, rRetainedWallEffectScale(a6)                                ; $02888E
        lea.l        rScreenColumnDepthWords(a6), a0                                  ; $028892
        move.w       #$3f, d7                                      ; $028896

loc_02889A:
        clr.l        (a0)+                                         ; $02889A
        dbra         d7, loc_02889A                                ; $02889C

loc_0288A0:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $0288A0
        bne.b        loc_0288A0                                    ; $0288A4
        lea.l        rSoftwareFrameBuffer(a6), a0                                ; $0288A6
        move.w       #$13f, d7                                     ; $0288AA

loc_0288AE:
        clr.l        (a0)+                                         ; $0288AE
        clr.l        (a0)+                                         ; $0288B0
        clr.l        (a0)+                                         ; $0288B2
        clr.l        (a0)+                                         ; $0288B4
        clr.l        (a0)+                                         ; $0288B6
        clr.l        (a0)+                                         ; $0288B8
        clr.l        (a0)+                                         ; $0288BA
        clr.l        (a0)+                                         ; $0288BC
        dbra         d7, loc_0288AE                                ; $0288BE
        lea.l        rWallEndpointBRecord(a6), a2                                ; $0288C2
        lea.l        rWallEndpointARecord(a6), a3                                ; $0288C6
        move.w       rRetainedWallEffectOffset(a6), d0                                ; $0288CA
        addi.w       #$c0, d0                                      ; $0288CE
        andi.w       #$7f, d0                                      ; $0288D2
        subi.w       #$c0, d0                                      ; $0288D6
        move.w       d0, rRetainedWallEffectOffset(a6)                                ; $0288DA
        movea.l      #AngleVectorPairs, a0                         ; $0288DE
        andi.w       #$1ff, d0                                     ; $0288E4
        lsl.w        #$2, d0                                       ; $0288E8
        adda.w       d0, a0                                        ; $0288EA
        move.w       $2(a0), d3                                    ; $0288EC
        add.w        rRetainedWallEffectScale(a6), d3                                ; $0288F0
        move.w       (a0), d0                                      ; $0288F4
        ext.l        d0                                            ; $0288F6
        lsl.l        #$8, d0                                       ; $0288F8
        divs.w       #$b5, d0                                      ; $0288FA
        ext.l        d0                                            ; $0288FE
        lsl.l        #$6, d0                                       ; $028900
        divs.w       d3, d0                                        ; $028902
        addi.w       #$40, d0                                      ; $028904
        move.w       d0, $e(a2)                                    ; $028908
        move.l       #$8000, d0                                    ; $02890C
        divs.w       d3, d0                                        ; $028912
        move.w       d0, $c(a2)                                    ; $028914
        move.w       rRetainedWallEffectOffset(a6), d0                                ; $028918
        addi.w       #$80, d0                                      ; $02891C
        movea.l      #AngleVectorPairs, a0                         ; $028920
        andi.w       #$1ff, d0                                     ; $028926
        lsl.w        #$2, d0                                       ; $02892A
        adda.w       d0, a0                                        ; $02892C
        move.w       $2(a0), d3                                    ; $02892E
        add.w        rRetainedWallEffectScale(a6), d3                                ; $028932
        move.w       (a0), d0                                      ; $028936
        ext.l        d0                                            ; $028938
        lsl.l        #$8, d0                                       ; $02893A
        divs.w       #$b5, d0                                      ; $02893C
        ext.l        d0                                            ; $028940
        lsl.l        #$6, d0                                       ; $028942
        divs.w       d3, d0                                        ; $028944
        addi.w       #$40, d0                                      ; $028946
        move.w       d0, $e(a3)                                    ; $02894A
        move.l       #$8000, d0                                    ; $02894E
        divs.w       d3, d0                                        ; $028954
        move.w       d0, $c(a3)                                    ; $028956
        clr.w        rWallTextureUStart(a6)                                    ; $02895A
        move.w       #$ff, rWallTextureUEnd(a6)                              ; $02895E
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $028964
        move.l       rZoneBackgroundProfile0(a6), rActiveSceneBackgroundProfile(a6) ; $02896C
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $028972
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $028976
        move.l       d1, (a0)+                                     ; $02897A
        move.l       d1, (a0)+                                     ; $02897C
        move.l       d1, (a0)+                                     ; $02897E
        move.l       d1, (a0)+                                     ; $028980
        move.l       d1, (a0)                                      ; $028982
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $028984
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $028988
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $02898C
        clr.w        rNightVisionInventorySlotIndex(a6)                                    ; $028990
        clr.w        rFlashlightInventorySlotIndex(a6)                                    ; $028994
        move.l       #RetainedScreenEffectColumnPixels, rCurrentWallTilePair(a6) ; $028998
        jsr          DrawWallTextureSpan.l                         ; $0289A0
        lea.l        rWallEndpointBRecord(a6), a2                                ; $0289A6
        lea.l        rWallEndpointARecord(a6), a3                                ; $0289AA
        move.w       rRetainedWallEffectOffset(a6), d0                                ; $0289AE
        addi.w       #$80, d0                                      ; $0289B2
        movea.l      #AngleVectorPairs, a0                         ; $0289B6
        andi.w       #$1ff, d0                                     ; $0289BC
        lsl.w        #$2, d0                                       ; $0289C0
        adda.w       d0, a0                                        ; $0289C2
        move.w       $2(a0), d3                                    ; $0289C4
        add.w        rRetainedWallEffectScale(a6), d3                                ; $0289C8
        move.w       (a0), d0                                      ; $0289CC
        ext.l        d0                                            ; $0289CE
        lsl.l        #$8, d0                                       ; $0289D0
        divs.w       #$b5, d0                                      ; $0289D2
        ext.l        d0                                            ; $0289D6
        lsl.l        #$6, d0                                       ; $0289D8
        divs.w       d3, d0                                        ; $0289DA
        addi.w       #$40, d0                                      ; $0289DC
        move.w       d0, $e(a2)                                    ; $0289E0
        move.l       #$8000, d0                                    ; $0289E4
        divs.w       d3, d0                                        ; $0289EA
        move.w       d0, $c(a2)                                    ; $0289EC
        move.w       rRetainedWallEffectOffset(a6), d0                                ; $0289F0
        addi.w       #$100, d0                                     ; $0289F4
        movea.l      #AngleVectorPairs, a0                         ; $0289F8
        andi.w       #$1ff, d0                                     ; $0289FE
        lsl.w        #$2, d0                                       ; $028A02
        adda.w       d0, a0                                        ; $028A04
        move.w       $2(a0), d3                                    ; $028A06
        add.w        rRetainedWallEffectScale(a6), d3                                ; $028A0A
        move.w       (a0), d0                                      ; $028A0E
        ext.l        d0                                            ; $028A10
        lsl.l        #$8, d0                                       ; $028A12
        divs.w       #$b5, d0                                      ; $028A14
        ext.l        d0                                            ; $028A18
        lsl.l        #$6, d0                                       ; $028A1A
        divs.w       d3, d0                                        ; $028A1C
        addi.w       #$40, d0                                      ; $028A1E
        move.w       d0, $e(a3)                                    ; $028A22
        move.l       #$8000, d0                                    ; $028A26
        divs.w       d3, d0                                        ; $028A2C
        move.w       d0, $c(a3)                                    ; $028A2E
        clr.w        rWallTextureUStart(a6)                                    ; $028A32
        move.w       #$ff, rWallTextureUEnd(a6)                              ; $028A36
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $028A3C
        move.l       rZoneBackgroundProfile0(a6), rActiveSceneBackgroundProfile(a6) ; $028A44
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $028A4A
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $028A4E
        move.l       d1, (a0)+                                     ; $028A52
        move.l       d1, (a0)+                                     ; $028A54
        move.l       d1, (a0)+                                     ; $028A56
        move.l       d1, (a0)+                                     ; $028A58
        move.l       d1, (a0)                                      ; $028A5A
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $028A5C
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $028A60
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $028A64
        clr.w        rNightVisionInventorySlotIndex(a6)                                    ; $028A68
        clr.w        rFlashlightInventorySlotIndex(a6)                                    ; $028A6C
        move.l       #RetainedScreenEffectColumnPixels, rCurrentWallTilePair(a6) ; $028A70
        jsr          DrawWallTextureSpan.l                         ; $028A78
        cmpi.w       #$2b5, rRetainedWallEffectScale(a6)                             ; $028A7E
        bne.w        loc_028822                                    ; $028A84
        cmpi.w       #$ff40, rRetainedWallEffectOffset(a6)                            ; $028A88
        bne.w        loc_028822                                    ; $028A8E
        move.w       #$f, d7                                       ; $028A92

loc_028A96:
        move.w       d7, -(a7)                                     ; $028A96
        move.w       #$2, rVBlankTransferPhasesRemaining(a6)                               ; $028A98
        jsr          WaitForVBlank.l                               ; $028A9E
        movea.l      #VDP_DATA, a4                                 ; $028AA4
        move.l       #$c0080000, VDP_CONTROL.l                     ; $028AAA
        movea.l      #RetainedScreenEffectColorCycle, a0           ; $028AB4
        move.w       rGameTick(a6), d0                             ; $028ABA
        addq.w       #$1, d0                                       ; $028ABE
        cmpi.w       #$16, d0                                      ; $028AC0
        bcs.b        loc_028AC8                                    ; $028AC4
        clr.w        d0                                            ; $028AC6

loc_028AC8:
        move.w       d0, rGameTick(a6)                             ; $028AC8
        lsl.w        #$1, d0                                       ; $028ACC
        adda.w       d0, a0                                        ; $028ACE
        move.l       (a0)+, (a4)                                   ; $028AD0
        move.l       (a0)+, (a4)                                   ; $028AD2
        move.l       (a0)+, (a4)                                   ; $028AD4
        move.l       (a0)+, (a4)                                   ; $028AD6
        move.l       (a0)+, (a4)                                   ; $028AD8
        move.l       (a0)+, (a4)                                   ; $028ADA
        lea.l        rScreenColumnDepthWords(a6), a0                                  ; $028ADC
        move.w       #$3f, d7                                      ; $028AE0

loc_028AE4:
        clr.l        (a0)+                                         ; $028AE4
        dbra         d7, loc_028AE4                                ; $028AE6

loc_028AEA:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $028AEA
        bne.b        loc_028AEA                                    ; $028AEE
        lea.l        rSoftwareFrameBuffer(a6), a0                                ; $028AF0
        move.w       #$13f, d7                                     ; $028AF4

loc_028AF8:
        clr.l        (a0)+                                         ; $028AF8
        clr.l        (a0)+                                         ; $028AFA
        clr.l        (a0)+                                         ; $028AFC
        clr.l        (a0)+                                         ; $028AFE
        clr.l        (a0)+                                         ; $028B00
        clr.l        (a0)+                                         ; $028B02
        clr.l        (a0)+                                         ; $028B04
        clr.l        (a0)+                                         ; $028B06
        dbra         d7, loc_028AF8                                ; $028B08
        lea.l        rWallEndpointBRecord(a6), a2                                ; $028B0C
        lea.l        rWallEndpointARecord(a6), a3                                ; $028B10
        move.w       #$20, $e(a2)                                  ; $028B14
        move.w       #$40, $c(a2)                                  ; $028B1A
        move.w       #$5f, $e(a3)                                  ; $028B20
        move.w       #$40, $c(a3)                                  ; $028B26
        clr.w        rWallTextureUStart(a6)                                    ; $028B2C
        move.w       #$ff, rWallTextureUEnd(a6)                              ; $028B30
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $028B36
        move.l       rZoneBackgroundProfile0(a6), rActiveSceneBackgroundProfile(a6) ; $028B3E
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $028B44
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $028B48
        move.l       d1, (a0)+                                     ; $028B4C
        move.l       d1, (a0)+                                     ; $028B4E
        move.l       d1, (a0)+                                     ; $028B50
        move.l       d1, (a0)+                                     ; $028B52
        move.l       d1, (a0)                                      ; $028B54
        clr.l        rWallFaceHeightProfile0(a6)                                    ; $028B56
        clr.l        rWallFaceHeightProfile2(a6)                                    ; $028B5A
        clr.w        rCurrentWallFaceHeightProfile(a6)                                    ; $028B5E
        clr.w        rNightVisionInventorySlotIndex(a6)                                    ; $028B62
        clr.w        rFlashlightInventorySlotIndex(a6)                                    ; $028B66
        move.l       #RetainedScreenEffectColumnPixels, rCurrentWallTilePair(a6) ; $028B6A
        jsr          DrawWallTextureSpan.l                         ; $028B72
        move.w       (a7)+, d7                                     ; $028B78
        subq.w       #$1, d7                                       ; $028B7A
        bpl.w        loc_028A96                                    ; $028B7C
        tst.w        rGameTick(a6)                                 ; $028B80
        bne.w        loc_028A96                                    ; $028B84
        move.w       #$1e, d7                                      ; $028B88

loc_028B8C:
        jsr          WaitForVBlank.l                               ; $028B8C
        dbra         d7, loc_028B8C                                ; $028B92
        rts                                                        ; $028B96
        ifne *-$28B98
        fail "ROM end moved"
        endif
