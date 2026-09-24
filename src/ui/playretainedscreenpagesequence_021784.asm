; $021784..$021D29 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Скрипт показа экранной страницы: серия (D1=тайл-база 0xd9/0xd5/0xeb…, столбец 0x1/0x2bc) → FUN_021e1e загрузка графики в VRAM, FUN_021ef2 блит тайлмапа 0x28×0x20, FUN_021db0 ожидание кадра — постраничная презентация (титры/интро) с двойной буферизацией
        ifne *-$21784
        fail "ROM start moved"
        endif

PlayRetainedScreenPageSequence:
        move.w       #$1, d0                                       ; $021784
        move.w       #$d9, d1                                      ; $021788
        lea.l        RunMissionSelection.l, a0                     ; $02178C
        jsr          UploadTiles.l                                 ; $021792
        lea.l        RunMissionSelection.l, a0                     ; $021798
        movea.l      #$0, a1                                       ; $02179E
        move.w       #$28, d0                                      ; $0217A4
        move.w       #$20, d1                                      ; $0217A8
        move.w       #$40, d2                                      ; $0217AC
        move.w       #$1, d3                                       ; $0217B0
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $0217B4
        lea.l        RunMissionSelection.l, a0                     ; $0217BA
        moveq        #$5, d1                                       ; $0217C0
        jsr          FadeAll64PaletteColorsFromBlack.l                                  ; $0217C2
        move.w       #$f, d0                                       ; $0217C8
        jsr          WaitVBlankFrames.l                            ; $0217CC
        moveq        #$6, d0                                       ; $0217D2
        jsr          WaitVBlankFrames.l                            ; $0217D4
        moveq        #$6, d0                                       ; $0217DA
        jsr          WaitVBlankFrames.l                            ; $0217DC
        move.w       #$2bc, d0                                     ; $0217E2
        move.w       #$d5, d1                                      ; $0217E6
        lea.l        RunMissionSelection.l, a0                     ; $0217EA
        jsr          UploadTiles.l                                 ; $0217F0
        lea.l        RunMissionSelection.l, a0                     ; $0217F6
        movea.l      #$0, a1                                       ; $0217FC
        move.w       #$28, d0                                      ; $021802
        move.w       #$20, d1                                      ; $021806
        move.w       #$40, d2                                      ; $02180A
        move.w       #$2bc, d3                                     ; $02180E
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021812
        moveq        #$6, d0                                       ; $021818
        jsr          WaitVBlankFrames.l                            ; $02181A
        move.w       #$1, d0                                       ; $021820
        move.w       #$d8, d1                                      ; $021824
        lea.l        RunMissionSelection.l, a0                     ; $021828
        jsr          UploadTiles.l                                 ; $02182E
        lea.l        RunMissionSelection.l, a0                     ; $021834
        movea.l      #$0, a1                                       ; $02183A
        move.w       #$28, d0                                      ; $021840
        move.w       #$20, d1                                      ; $021844
        move.w       #$40, d2                                      ; $021848
        move.w       #$1, d3                                       ; $02184C
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021850
        moveq        #$6, d0                                       ; $021856
        jsr          WaitVBlankFrames.l                            ; $021858
        move.w       #$2bc, d0                                     ; $02185E
        move.w       #$d5, d1                                      ; $021862
        lea.l        RunMissionSelection.l, a0                     ; $021866
        jsr          UploadTiles.l                                 ; $02186C
        lea.l        RunMissionSelection.l, a0                     ; $021872
        movea.l      #$0, a1                                       ; $021878
        move.w       #$28, d0                                      ; $02187E
        move.w       #$20, d1                                      ; $021882
        move.w       #$40, d2                                      ; $021886
        move.w       #$2bc, d3                                     ; $02188A
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $02188E
        moveq        #$6, d0                                       ; $021894
        jsr          WaitVBlankFrames.l                            ; $021896
        move.w       #$1, d0                                       ; $02189C
        move.w       #$eb, d1                                      ; $0218A0
        lea.l        RunMissionSelection.l, a0                     ; $0218A4
        jsr          UploadTiles.l                                 ; $0218AA
        lea.l        RunMissionSelection.l, a0                     ; $0218B0
        movea.l      #$0, a1                                       ; $0218B6
        move.w       #$28, d0                                      ; $0218BC
        move.w       #$20, d1                                      ; $0218C0
        move.w       #$40, d2                                      ; $0218C4
        move.w       #$1, d3                                       ; $0218C8
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $0218CC
        moveq        #$6, d0                                       ; $0218D2
        jsr          WaitVBlankFrames.l                            ; $0218D4
        move.w       #$2bc, d0                                     ; $0218DA
        move.w       #$fd, d1                                      ; $0218DE
        lea.l        RunMissionSelection.l, a0                     ; $0218E2
        jsr          UploadTiles.l                                 ; $0218E8
        lea.l        RunMissionSelection.l, a0                     ; $0218EE
        movea.l      #$0, a1                                       ; $0218F4
        move.w       #$28, d0                                      ; $0218FA
        move.w       #$20, d1                                      ; $0218FE
        move.w       #$40, d2                                      ; $021902
        move.w       #$2bc, d3                                     ; $021906
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $02190A
        moveq        #$6, d0                                       ; $021910
        jsr          WaitVBlankFrames.l                            ; $021912
        move.w       #$1, d0                                       ; $021918
        move.w       #$e6, d1                                      ; $02191C
        lea.l        RunMissionSelection.l, a0                     ; $021920
        jsr          UploadTiles.l                                 ; $021926
        lea.l        RunMissionSelection.l, a0                     ; $02192C
        movea.l      #$0, a1                                       ; $021932
        move.w       #$28, d0                                      ; $021938
        move.w       #$20, d1                                      ; $02193C
        move.w       #$40, d2                                      ; $021940
        move.w       #$1, d3                                       ; $021944
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021948
        moveq        #$6, d0                                       ; $02194E
        jsr          WaitVBlankFrames.l                            ; $021950
        move.w       #$2bc, d0                                     ; $021956
        move.w       #$da, d1                                      ; $02195A
        lea.l        RunMissionSelection.l, a0                     ; $02195E
        jsr          UploadTiles.l                                 ; $021964
        lea.l        RunMissionSelection.l, a0                     ; $02196A
        movea.l      #$0, a1                                       ; $021970
        move.w       #$28, d0                                      ; $021976
        move.w       #$20, d1                                      ; $02197A
        move.w       #$40, d2                                      ; $02197E
        move.w       #$2bc, d3                                     ; $021982
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021986
        moveq        #$6, d0                                       ; $02198C
        jsr          WaitVBlankFrames.l                            ; $02198E
        move.w       #$1, d0                                       ; $021994
        move.w       #$d8, d1                                      ; $021998
        lea.l        RunMissionSelection.l, a0                     ; $02199C
        jsr          UploadTiles.l                                 ; $0219A2
        lea.l        RunMissionSelection.l, a0                     ; $0219A8
        movea.l      #$0, a1                                       ; $0219AE
        move.w       #$28, d0                                      ; $0219B4
        move.w       #$20, d1                                      ; $0219B8
        move.w       #$40, d2                                      ; $0219BC
        move.w       #$1, d3                                       ; $0219C0
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $0219C4
        moveq        #$6, d0                                       ; $0219CA
        jsr          WaitVBlankFrames.l                            ; $0219CC
        move.w       #$2bc, d0                                     ; $0219D2
        move.w       #$de, d1                                      ; $0219D6
        lea.l        RunMissionSelection.l, a0                     ; $0219DA
        jsr          UploadTiles.l                                 ; $0219E0
        lea.l        RunMissionSelection.l, a0                     ; $0219E6
        movea.l      #$0, a1                                       ; $0219EC
        move.w       #$28, d0                                      ; $0219F2
        move.w       #$20, d1                                      ; $0219F6
        move.w       #$40, d2                                      ; $0219FA
        move.w       #$2bc, d3                                     ; $0219FE
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021A02
        moveq        #$6, d0                                       ; $021A08
        jsr          WaitVBlankFrames.l                            ; $021A0A
        move.w       #$1, d0                                       ; $021A10
        move.w       #$e7, d1                                      ; $021A14
        lea.l        RunMissionSelection.l, a0                     ; $021A18
        jsr          UploadTiles.l                                 ; $021A1E
        lea.l        RunMissionSelection.l, a0                     ; $021A24
        movea.l      #$0, a1                                       ; $021A2A
        move.w       #$28, d0                                      ; $021A30
        move.w       #$20, d1                                      ; $021A34
        move.w       #$40, d2                                      ; $021A38
        move.w       #$1, d3                                       ; $021A3C
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021A40
        moveq        #$6, d0                                       ; $021A46
        jsr          WaitVBlankFrames.l                            ; $021A48
        move.w       #$2bc, d0                                     ; $021A4E
        move.w       #$e2, d1                                      ; $021A52
        lea.l        RunMissionSelection.l, a0                     ; $021A56
        jsr          UploadTiles.l                                 ; $021A5C
        lea.l        RunMissionSelection.l, a0                     ; $021A62
        movea.l      #$0, a1                                       ; $021A68
        move.w       #$28, d0                                      ; $021A6E
        move.w       #$20, d1                                      ; $021A72
        move.w       #$40, d2                                      ; $021A76
        move.w       #$2bc, d3                                     ; $021A7A
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021A7E
        moveq        #$6, d0                                       ; $021A84
        jsr          WaitVBlankFrames.l                            ; $021A86
        move.w       #$1, d0                                       ; $021A8C
        move.w       #$e2, d1                                      ; $021A90
        lea.l        RunMissionSelection.l, a0                     ; $021A94
        jsr          UploadTiles.l                                 ; $021A9A
        lea.l        RunMissionSelection.l, a0                     ; $021AA0
        movea.l      #$0, a1                                       ; $021AA6
        move.w       #$28, d0                                      ; $021AAC
        move.w       #$20, d1                                      ; $021AB0
        move.w       #$40, d2                                      ; $021AB4
        move.w       #$1, d3                                       ; $021AB8
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021ABC
        moveq        #$6, d0                                       ; $021AC2
        jsr          WaitVBlankFrames.l                            ; $021AC4
        move.w       #$2bc, d0                                     ; $021ACA
        move.w       #$df, d1                                      ; $021ACE
        lea.l        RunMissionSelection.l, a0                     ; $021AD2
        jsr          UploadTiles.l                                 ; $021AD8
        lea.l        RunMissionSelection.l, a0                     ; $021ADE
        movea.l      #$0, a1                                       ; $021AE4
        move.w       #$28, d0                                      ; $021AEA
        move.w       #$20, d1                                      ; $021AEE
        move.w       #$40, d2                                      ; $021AF2
        move.w       #$2bc, d3                                     ; $021AF6
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021AFA
        moveq        #$6, d0                                       ; $021B00
        jsr          WaitVBlankFrames.l                            ; $021B02
        move.w       #$1, d0                                       ; $021B08
        move.w       #$da, d1                                      ; $021B0C
        lea.l        RunMissionSelection.l, a0                     ; $021B10
        jsr          UploadTiles.l                                 ; $021B16
        lea.l        RunMissionSelection.l, a0                     ; $021B1C
        movea.l      #$0, a1                                       ; $021B22
        move.w       #$28, d0                                      ; $021B28
        move.w       #$20, d1                                      ; $021B2C
        move.w       #$40, d2                                      ; $021B30
        move.w       #$1, d3                                       ; $021B34
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021B38
        moveq        #$6, d0                                       ; $021B3E
        jsr          WaitVBlankFrames.l                            ; $021B40
        moveq        #$6, d0                                       ; $021B46
        jsr          WaitVBlankFrames.l                            ; $021B48
        moveq        #$6, d0                                       ; $021B4E
        jsr          WaitVBlankFrames.l                            ; $021B50
        moveq        #$6, d0                                       ; $021B56
        jsr          WaitVBlankFrames.l                            ; $021B58
        moveq        #$6, d0                                       ; $021B5E
        jsr          WaitVBlankFrames.l                            ; $021B60
        moveq        #$6, d0                                       ; $021B66
        jsr          WaitVBlankFrames.l                            ; $021B68
        move.w       #$2bc, d0                                     ; $021B6E
        move.w       #$d5, d1                                      ; $021B72
        lea.l        RunMissionSelection.l, a0                     ; $021B76
        jsr          UploadTiles.l                                 ; $021B7C
        lea.l        RunMissionSelection.l, a0                     ; $021B82
        movea.l      #$0, a1                                       ; $021B88
        move.w       #$28, d0                                      ; $021B8E
        move.w       #$20, d1                                      ; $021B92
        move.w       #$40, d2                                      ; $021B96
        move.w       #$2bc, d3                                     ; $021B9A
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021B9E
        moveq        #$6, d0                                       ; $021BA4
        jsr          WaitVBlankFrames.l                            ; $021BA6
        move.w       #$1, d0                                       ; $021BAC
        move.w       #$f0, d1                                      ; $021BB0
        lea.l        RunMissionSelection.l, a0                     ; $021BB4
        jsr          UploadTiles.l                                 ; $021BBA
        lea.l        RunMissionSelection.l, a0                     ; $021BC0
        movea.l      #$0, a1                                       ; $021BC6
        move.w       #$28, d0                                      ; $021BCC
        move.w       #$20, d1                                      ; $021BD0
        move.w       #$40, d2                                      ; $021BD4
        move.w       #$1, d3                                       ; $021BD8
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021BDC
        moveq        #$6, d0                                       ; $021BE2
        jsr          WaitVBlankFrames.l                            ; $021BE4
        move.w       #$2bc, d0                                     ; $021BEA
        move.w       #$f9, d1                                      ; $021BEE
        lea.l        RunMissionSelection.l, a0                     ; $021BF2
        jsr          UploadTiles.l                                 ; $021BF8
        lea.l        RunMissionSelection.l, a0                     ; $021BFE
        movea.l      #$0, a1                                       ; $021C04
        move.w       #$28, d0                                      ; $021C0A
        move.w       #$20, d1                                      ; $021C0E
        move.w       #$40, d2                                      ; $021C12
        move.w       #$2bc, d3                                     ; $021C16
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021C1A
        moveq        #$6, d0                                       ; $021C20
        jsr          WaitVBlankFrames.l                            ; $021C22
        move.w       #$1, d0                                       ; $021C28
        move.w       #$fb, d1                                      ; $021C2C
        lea.l        RunMissionSelection.l, a0                     ; $021C30
        jsr          UploadTiles.l                                 ; $021C36
        lea.l        RunMissionSelection.l, a0                     ; $021C3C
        movea.l      #$0, a1                                       ; $021C42
        move.w       #$28, d0                                      ; $021C48
        move.w       #$20, d1                                      ; $021C4C
        move.w       #$40, d2                                      ; $021C50
        move.w       #$1, d3                                       ; $021C54
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021C58
        moveq        #$6, d0                                       ; $021C5E
        jsr          WaitVBlankFrames.l                            ; $021C60
        move.w       #$2bc, d0                                     ; $021C66
        move.w       #$f6, d1                                      ; $021C6A
        lea.l        RunMissionSelection.l, a0                     ; $021C6E
        jsr          UploadTiles.l                                 ; $021C74
        lea.l        RunMissionSelection.l, a0                     ; $021C7A
        movea.l      #$0, a1                                       ; $021C80
        move.w       #$28, d0                                      ; $021C86
        move.w       #$20, d1                                      ; $021C8A
        move.w       #$40, d2                                      ; $021C8E
        move.w       #$2bc, d3                                     ; $021C92
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021C96
        moveq        #$6, d0                                       ; $021C9C
        jsr          WaitVBlankFrames.l                            ; $021C9E
        move.w       #$1, d0                                       ; $021CA4
        move.w       #$e3, d1                                      ; $021CA8
        lea.l        RunMissionSelection.l, a0                     ; $021CAC
        jsr          UploadTiles.l                                 ; $021CB2
        lea.l        RunMissionSelection.l, a0                     ; $021CB8
        movea.l      #$0, a1                                       ; $021CBE
        move.w       #$28, d0                                      ; $021CC4
        move.w       #$20, d1                                      ; $021CC8
        move.w       #$40, d2                                      ; $021CCC
        move.w       #$1, d3                                       ; $021CD0
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021CD4
        moveq        #$6, d0                                       ; $021CDA
        jsr          WaitVBlankFrames.l                            ; $021CDC
        move.w       #$2bc, d0                                     ; $021CE2
        move.w       #$cb, d1                                      ; $021CE6
        lea.l        RunMissionSelection.l, a0                     ; $021CEA
        jsr          UploadTiles.l                                 ; $021CF0
        lea.l        RunMissionSelection.l, a0                     ; $021CF6
        movea.l      #$0, a1                                       ; $021CFC
        move.w       #$28, d0                                      ; $021D02
        move.w       #$20, d1                                      ; $021D06
        move.w       #$40, d2                                      ; $021D0A
        move.w       #$2bc, d3                                     ; $021D0E
        jsr          UploadAttributedTilemapAtC000Offset.l                                  ; $021D12
        moveq        #$6, d0                                       ; $021D18
        jsr          WaitVBlankFrames.l                            ; $021D1A
        moveq        #$6, d0                                       ; $021D20
        jsr          WaitVBlankFrames.l                            ; $021D22
        rts                                                        ; $021D28
        ifne *-$21D2A
        fail "ROM end moved"
        endif
