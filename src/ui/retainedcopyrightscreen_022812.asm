; $022812..$0228B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: VDP setup, six string consumers and bounded wait; direct tail to 21702
        ifne *-$22812
        fail "ROM start moved"
        endif

RetainedCopyrightScreen:
        jsr          ClearCram(pc)                                 ; $022812
        jsr          ClearAllVram(pc)                              ; $022816
        jsr          InitializeMenuVdp(pc)                         ; $02281A
        move.w       #$0, d0                                       ; $02281E
        jsr          VideoRoutine_021E4A(pc)                       ; $022822
        move.w       #$0, d0                                       ; $022826
        jsr          WriteScreenTile(pc)                           ; $02282A
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $02282E
        move.w       #$4b0, d0                                     ; $022834
        jsr          DecompressBytePairToVramLong.l                ; $022838
        move.w       #$3, d0                                       ; $02283E
        lea.l        InterfacePalettes(pc), a0                     ; $022842
        jsr          LoadPaletteLine(pc)                           ; $022846
        move.w       #$c204, d0                                    ; $02284A
        lea.l        CopyrightScreenStrings.l, a0                  ; $02284E
        jsr          PrintCharacterMenuText.l                      ; $022854
        move.w       #$c404, d0                                    ; $02285A
        lea.l        Data_0228DB.l, a0                             ; $02285E
        jsr          PrintCharacterMenuText.l                      ; $022864
        move.w       #$c504, d0                                    ; $02286A
        lea.l        Data_0228FE.l, a0                             ; $02286E
        jsr          PrintCharacterMenuText.l                      ; $022874
        move.w       #$c704, d0                                    ; $02287A
        lea.l        Data_02291A.l, a0                             ; $02287E
        jsr          PrintCharacterMenuText.l                      ; $022884
        move.w       #$c804, d0                                    ; $02288A
        lea.l        Data_02293F.l, a0                             ; $02288E
        jsr          PrintCharacterMenuText.l                      ; $022894
        move.w       #$ca04, d0                                    ; $02289A
        lea.l        Data_02295B.l, a0                             ; $02289E
        jsr          PrintCharacterMenuText.l                      ; $0228A4
        move.w       #$78, d6                                      ; $0228AA

loc_0228AE:
        jsr          WaitForVBlank.w                               ; $0228AE
        dbra         d6, loc_0228AE                                ; $0228B2
        jmp          RetainedScreenSequence(pc)                    ; $0228B6
        ifne *-$228BA
        fail "ROM end moved"
        endif
