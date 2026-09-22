; $07F612..$07FC89 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7F612
        fail "ROM start moved"
        endif

RetainedBriefingAlternatePage:
        btst.b       #$7, ramControllerState.l                     ; $07F612
        bne.w        loc_07F6A2                                    ; $07F61A
        lea.l        $ff0778.l, a0                                 ; $07F61E
        move.w       #$4, d1                                       ; $07F624
        jsr          VideoRoutine_022018.l                         ; $07F628
        lea.l        loc_081C5C.l, a0                              ; $07F62E
        move.w       #$1, d0                                       ; $07F634
        move.w       #$3f0, d1                                     ; $07F638
        jsr          UploadTiles.l                                 ; $07F63C
        lea.l        loc_081C5C.l, a0                              ; $07F642
        movea.w      #$0, a1                                       ; $07F648
        move.w       #$28, d0                                      ; $07F64C
        move.w       #$1c, d1                                      ; $07F650
        move.w       #$80, d2                                      ; $07F654
        move.w       #$1, d3                                       ; $07F658
        jsr          loc_021EFA.l                                  ; $07F65C
        lea.l        loc_081C5C.l, a0                              ; $07F662
        lea.l        $ff0778.l, a1                                 ; $07F668
        jsr          CopyOneTile.l                                 ; $07F66E
        lea.l        BriefingTextPalette.l, a0                     ; $07F674
        lea.l        $ff07d8.l, a1                                 ; $07F67A
        jsr          CopyOneTile.l                                 ; $07F680
        lea.l        $ff0778.l, a0                                 ; $07F686
        move.w       #$4, d1                                       ; $07F68C
        jsr          loc_022010.l                                  ; $07F690
        lea.l        BriefingStationOrdersText.l, a0               ; $07F696
        jsr          RunBriefingTextLoop.l                         ; $07F69C

loc_07F6A2:
        lea.l        $ff0778.l, a0                                 ; $07F6A2
        move.w       #$4, d1                                       ; $07F6A8
        jsr          VideoRoutine_022018.l                         ; $07F6AC
        jsr          PlayPendingSequence(pc)                       ; $07F6B2
        addq.l       #$4, a7                                       ; $07F6B6
        movea.l      (a7)+, a6                                     ; $07F6B8
        rts                                                        ; $07F6BA

loc_07F6BC:
        move.w       #$41, d0                                      ; $07F6BC
        jsr          loc_07ACE4(pc)                                ; $07F6C0
        lea.l        loc_081C5C.l, a0                              ; $07F6C4
        move.w       #$1, d0                                       ; $07F6CA
        move.w       #$3f0, d1                                     ; $07F6CE
        jsr          UploadTiles.l                                 ; $07F6D2
        lea.l        loc_081C5C.l, a0                              ; $07F6D8
        movea.w      #$0, a1                                       ; $07F6DE
        move.w       #$28, d0                                      ; $07F6E2
        move.w       #$1c, d1                                      ; $07F6E6
        move.w       #$80, d2                                      ; $07F6EA
        move.w       #$1, d3                                       ; $07F6EE
        jsr          loc_021EFA.l                                  ; $07F6F2
        lea.l        loc_081C5C.l, a0                              ; $07F6F8
        lea.l        $ff0778.l, a1                                 ; $07F6FE
        jsr          CopyOneTile.l                                 ; $07F704
        lea.l        BriefingTextPalette.l, a0                     ; $07F70A
        lea.l        $ff07d8.l, a1                                 ; $07F710
        jsr          CopyOneTile.l                                 ; $07F716
        lea.l        $ff0778.l, a0                                 ; $07F71C
        move.w       #$4, d1                                       ; $07F722
        jsr          loc_022010.l                                  ; $07F726
        lea.l        BriefingStationCompleteText.l, a0             ; $07F72C
        jsr          RunBriefingTextLoop.l                         ; $07F732
        btst.b       #$7, ramControllerState.l                     ; $07F738
        bne.w        loc_07F7C8                                    ; $07F740
        lea.l        $ff0778.l, a0                                 ; $07F744
        move.w       #$4, d1                                       ; $07F74A
        jsr          VideoRoutine_022018.l                         ; $07F74E
        lea.l        loc_081C5C.l, a0                              ; $07F754
        move.w       #$1, d0                                       ; $07F75A
        move.w       #$441, d1                                     ; $07F75E
        jsr          UploadTiles.l                                 ; $07F762
        lea.l        loc_081C5C.l, a0                              ; $07F768
        movea.w      #$0, a1                                       ; $07F76E
        move.w       #$28, d0                                      ; $07F772
        move.w       #$1c, d1                                      ; $07F776
        move.w       #$80, d2                                      ; $07F77A
        move.w       #$1, d3                                       ; $07F77E
        jsr          loc_021EFA.l                                  ; $07F782
        lea.l        loc_081C5C.l, a0                              ; $07F788
        lea.l        $ff0778.l, a1                                 ; $07F78E
        jsr          CopyOneTile.l                                 ; $07F794
        lea.l        BriefingTextPalette.l, a0                     ; $07F79A
        lea.l        $ff07d8.l, a1                                 ; $07F7A0
        jsr          CopyOneTile.l                                 ; $07F7A6
        lea.l        $ff0778.l, a0                                 ; $07F7AC
        move.w       #$4, d1                                       ; $07F7B2
        jsr          loc_022010.l                                  ; $07F7B6
        lea.l        BriefingHeadquartersOrdersText.l, a0          ; $07F7BC
        jsr          RunBriefingTextLoop.l                         ; $07F7C2

loc_07F7C8:
        lea.l        $ff0778.l, a0                                 ; $07F7C8
        move.w       #$4, d1                                       ; $07F7CE
        jsr          VideoRoutine_022018.l                         ; $07F7D2
        jsr          PlayPendingSequence(pc)                       ; $07F7D8
        addq.l       #$4, a7                                       ; $07F7DC
        movea.l      (a7)+, a6                                     ; $07F7DE
        rts                                                        ; $07F7E0

loc_07F7E2:
        move.w       #$41, d0                                      ; $07F7E2
        jsr          loc_07ACE4(pc)                                ; $07F7E6
        lea.l        loc_081C5C.l, a0                              ; $07F7EA
        move.w       #$1, d0                                       ; $07F7F0
        move.w       #$411, d1                                     ; $07F7F4
        jsr          UploadTiles.l                                 ; $07F7F8
        lea.l        loc_081C5C.l, a0                              ; $07F7FE
        movea.w      #$0, a1                                       ; $07F804
        move.w       #$28, d0                                      ; $07F808
        move.w       #$1c, d1                                      ; $07F80C
        move.w       #$80, d2                                      ; $07F810
        move.w       #$1, d3                                       ; $07F814
        jsr          loc_021EFA.l                                  ; $07F818
        lea.l        loc_081C5C.l, a0                              ; $07F81E
        lea.l        $ff0778.l, a1                                 ; $07F824
        jsr          CopyOneTile.l                                 ; $07F82A
        jsr          CopyOneTile.l                                 ; $07F830
        lea.l        BriefingTextPalette.l, a0                     ; $07F836
        lea.l        $ff07d8.l, a1                                 ; $07F83C
        jsr          CopyOneTile.l                                 ; $07F842
        lea.l        $ff0778.l, a0                                 ; $07F848
        move.w       #$4, d1                                       ; $07F84E
        jsr          loc_022010.l                                  ; $07F852
        lea.l        BriefingBasementOrdersText.l, a0              ; $07F858
        jsr          RunBriefingTextLoop.l                         ; $07F85E
        lea.l        $ff0778.l, a0                                 ; $07F864
        move.w       #$4, d1                                       ; $07F86A
        jsr          VideoRoutine_022018.l                         ; $07F86E
        jsr          PlayPendingSequence(pc)                       ; $07F874
        addq.l       #$4, a7                                       ; $07F878
        movea.l      (a7)+, a6                                     ; $07F87A
        rts                                                        ; $07F87C

loc_07F87E:
        lea.l        loc_081C5C.l, a0                              ; $07F87E
        move.w       #$1, d0                                       ; $07F884
        move.w       #$3aa, d1                                     ; $07F888
        jsr          UploadTiles.l                                 ; $07F88C
        lea.l        loc_081C5C.l, a0                              ; $07F892
        movea.w      #$0, a1                                       ; $07F898
        move.w       #$28, d0                                      ; $07F89C
        move.w       #$1c, d1                                      ; $07F8A0
        move.w       #$80, d2                                      ; $07F8A4
        move.w       #$1, d3                                       ; $07F8A8
        jsr          loc_021EFA.l                                  ; $07F8AC
        lea.l        loc_081C5C.l, a0                              ; $07F8B2
        lea.l        $ff0778.l, a1                                 ; $07F8B8
        jsr          CopyOneTile.l                                 ; $07F8BE
        lea.l        InterfacePalettes.l, a0                       ; $07F8C4
        lea.l        $ff07d8.l, a1                                 ; $07F8CA
        jsr          CopyOneTile.l                                 ; $07F8D0
        lea.l        $ff0778.l, a0                                 ; $07F8D6
        move.w       #$4, d1                                       ; $07F8DC
        jsr          loc_022010.l                                  ; $07F8E0
        lea.l        BriefingDayOneText.l, a0                      ; $07F8E6
        jsr          RunBriefingTextLoop.l                         ; $07F8EC
        btst.b       #$7, ramControllerState.l                     ; $07F8F2
        bne.w        loc_07F906                                    ; $07F8FA
        move.w       #$0, d7                                       ; $07F8FE
        bra.w        loc_07F90A                                    ; $07F902

loc_07F906:
        move.w       #$1, d7                                       ; $07F906

loc_07F90A:
        move.w       d7, -(a7)                                     ; $07F90A
        lea.l        $ff0778.l, a0                                 ; $07F90C
        move.w       #$4, d1                                       ; $07F912
        jsr          VideoRoutine_022018.l                         ; $07F916
        move.w       (a7)+, d7                                     ; $07F91C
        addq.l       #$4, a7                                       ; $07F91E
        movea.l      (a7)+, a6                                     ; $07F920
        rts                                                        ; $07F922

loc_07F924:
        move.w       #$43, d0                                      ; $07F924
        jsr          loc_07ACE4(pc)                                ; $07F928
        lea.l        loc_081C5C.l, a0                              ; $07F92C
        move.w       #$1, d0                                       ; $07F932
        move.w       #$43e, d1                                     ; $07F936
        jsr          UploadTiles.l                                 ; $07F93A
        lea.l        loc_081C5C.l, a0                              ; $07F940
        movea.w      #$0, a1                                       ; $07F946
        move.w       #$28, d0                                      ; $07F94A
        move.w       #$1c, d1                                      ; $07F94E
        move.w       #$80, d2                                      ; $07F952
        move.w       #$1, d3                                       ; $07F956
        jsr          loc_021EFA.l                                  ; $07F95A
        lea.l        loc_081C5C.l, a0                              ; $07F960
        lea.l        $ff0778.l, a1                                 ; $07F966
        jsr          CopyOneTile.l                                 ; $07F96C
        jsr          CopyOneTile.l                                 ; $07F972
        lea.l        BriefingTextPalette.l, a0                     ; $07F978
        lea.l        $ff07d8.l, a1                                 ; $07F97E
        jsr          CopyOneTile.l                                 ; $07F984
        lea.l        $ff0778.l, a0                                 ; $07F98A
        move.w       #$4, d1                                       ; $07F990
        jsr          loc_022010.l                                  ; $07F994
        lea.l        BriefingEndingAndCreditsText.l, a0            ; $07F99A
        jsr          RunBriefingTextLoop.l                         ; $07F9A0
        lea.l        $ff0778.l, a0                                 ; $07F9A6
        move.w       #$4, d1                                       ; $07F9AC
        jsr          VideoRoutine_022018.l                         ; $07F9B0
        jsr          PlayPendingSequence(pc)                       ; $07F9B6
        addq.l       #$4, a7                                       ; $07F9BA
        movea.l      (a7)+, a6                                     ; $07F9BC
        rts                                                        ; $07F9BE

loc_07F9C0:
        move.w       #$44, d0                                      ; $07F9C0
        jsr          loc_07ACE4(pc)                                ; $07F9C4
        cmpi.w       #$1, ramLegacyEpisodeSelection.l              ; $07F9C8
        beq.w        loc_07FA58                                    ; $07F9D0
        cmpi.w       #$2, ramLegacyEpisodeSelection.l              ; $07F9D4
        beq.w        loc_07FAE0                                    ; $07F9DC
        lea.l        loc_081C5C.l, a0                              ; $07F9E0
        move.w       #$1, d0                                       ; $07F9E6
        move.w       #$3f0, d1                                     ; $07F9EA
        jsr          UploadTiles.l                                 ; $07F9EE
        lea.l        loc_081C5C.l, a0                              ; $07F9F4
        movea.w      #$0, a1                                       ; $07F9FA
        move.w       #$28, d0                                      ; $07F9FE
        move.w       #$1c, d1                                      ; $07FA02
        move.w       #$80, d2                                      ; $07FA06
        move.w       #$1, d3                                       ; $07FA0A
        jsr          loc_021EFA.l                                  ; $07FA0E
        lea.l        loc_081C5C.l, a0                              ; $07FA14
        lea.l        $ff0778.l, a1                                 ; $07FA1A
        jsr          CopyOneTile.l                                 ; $07FA20
        lea.l        InterfacePalettes.l, a0                       ; $07FA26
        lea.l        $ff07d8.l, a1                                 ; $07FA2C
        jsr          CopyOneTile.l                                 ; $07FA32
        lea.l        $ff0778.l, a0                                 ; $07FA38
        move.w       #$4, d1                                       ; $07FA3E
        jsr          loc_022010.l                                  ; $07FA42
        lea.l        BriefingStationFailureText.l, a0              ; $07FA48
        jsr          RunBriefingTextLoop.l                         ; $07FA4E
        bra.w        loc_07FC70                                    ; $07FA54

loc_07FA58:
        lea.l        loc_081C5C.l, a0                              ; $07FA58
        move.w       #$1, d0                                       ; $07FA5E
        move.w       #$441, d1                                     ; $07FA62
        jsr          UploadTiles.l                                 ; $07FA66
        lea.l        loc_081C5C.l, a0                              ; $07FA6C
        movea.w      #$0, a1                                       ; $07FA72
        move.w       #$28, d0                                      ; $07FA76
        move.w       #$1c, d1                                      ; $07FA7A
        move.w       #$80, d2                                      ; $07FA7E
        move.w       #$1, d3                                       ; $07FA82
        jsr          loc_021EFA.l                                  ; $07FA86
        lea.l        loc_081C5C.l, a0                              ; $07FA8C
        lea.l        $ff0778.l, a1                                 ; $07FA92
        jsr          CopyOneTile.l                                 ; $07FA98
        lea.l        BriefingTextPalette.l, a0                     ; $07FA9E
        lea.l        $ff07d8.l, a1                                 ; $07FAA4
        jsr          CopyOneTile.l                                 ; $07FAAA
        lea.l        $ff0778.l, a0                                 ; $07FAB0
        move.w       #$4, d1                                       ; $07FAB6
        jsr          loc_022010.l                                  ; $07FABA
        lea.l        BriefingHeadquartersFailureText.l, a0         ; $07FAC0
        jsr          RunBriefingTextLoop.l                         ; $07FAC6
        lea.l        $ff0778.l, a0                                 ; $07FACC
        move.w       #$4, d1                                       ; $07FAD2
        jsr          VideoRoutine_022018.l                         ; $07FAD6
        bra.w        loc_07FB64                                    ; $07FADC

loc_07FAE0:
        lea.l        loc_081C5C.l, a0                              ; $07FAE0
        move.w       #$1, d0                                       ; $07FAE6
        move.w       #$446, d1                                     ; $07FAEA
        jsr          UploadTiles.l                                 ; $07FAEE
        lea.l        loc_081C5C.l, a0                              ; $07FAF4
        movea.w      #$0, a1                                       ; $07FAFA
        move.w       #$28, d0                                      ; $07FAFE
        move.w       #$1c, d1                                      ; $07FB02
        move.w       #$80, d2                                      ; $07FB06
        move.w       #$1, d3                                       ; $07FB0A
        jsr          loc_021EFA.l                                  ; $07FB0E
        lea.l        loc_081C5C.l, a0                              ; $07FB14
        lea.l        $ff0778.l, a1                                 ; $07FB1A
        jsr          CopyOneTile.l                                 ; $07FB20
        lea.l        BriefingTextPalette.l, a0                     ; $07FB26
        lea.l        $ff07d8.l, a1                                 ; $07FB2C
        jsr          CopyOneTile.l                                 ; $07FB32
        lea.l        $ff0778.l, a0                                 ; $07FB38
        move.w       #$4, d1                                       ; $07FB3E
        jsr          loc_022010.l                                  ; $07FB42
        lea.l        BriefingHeadquartersFailureText.l, a0         ; $07FB48
        jsr          RunBriefingTextLoop.l                         ; $07FB4E
        lea.l        $ff0778.l, a0                                 ; $07FB54
        move.w       #$4, d1                                       ; $07FB5A
        jsr          VideoRoutine_022018.l                         ; $07FB5E

loc_07FB64:
        lea.l        loc_081C5C.l, a0                              ; $07FB64
        move.w       #$1, d0                                       ; $07FB6A
        move.w       #$445, d1                                     ; $07FB6E
        jsr          UploadTiles.l                                 ; $07FB72
        lea.l        loc_081C5C.l, a0                              ; $07FB78
        movea.w      #$0, a1                                       ; $07FB7E
        move.w       #$28, d0                                      ; $07FB82
        move.w       #$1c, d1                                      ; $07FB86
        move.w       #$80, d2                                      ; $07FB8A
        move.w       #$1, d3                                       ; $07FB8E
        jsr          loc_021EFA.l                                  ; $07FB92
        move.w       #$0, d0                                       ; $07FB98
        jsr          ClearMenuTileRectangle.l                      ; $07FB9C
        move.w       #$10, d0                                      ; $07FBA2
        lea.l        $ff0778.l, a0                                 ; $07FBA6

loc_07FBAC:
        move.l       #$0, (a0)+                                    ; $07FBAC
        dbra         d0, loc_07FBAC                                ; $07FBB2
        lea.l        $ff0778.l, a0                                 ; $07FBB6
        move.w       #$1, d1                                       ; $07FBBC
        jsr          FadePaletteToWhite.l                          ; $07FBC0
        move.w       #$d, d0                                       ; $07FBC6
        jsr          PlaySoundEvent(pc)                            ; $07FBCA
        lea.l        loc_081C5C.l, a0                              ; $07FBCE
        lea.l        $ff0778.l, a1                                 ; $07FBD4
        jsr          CopyOneTile.l                                 ; $07FBDA
        lea.l        BriefingTextPalette.l, a0                     ; $07FBE0
        lea.l        $ff07d8.l, a1                                 ; $07FBE6
        jsr          CopyOneTile.l                                 ; $07FBEC
        lea.l        $ff0778.l, a0                                 ; $07FBF2
        move.w       #$4, d1                                       ; $07FBF8
        jsr          FadePaletteFromWhite.l                        ; $07FBFC
        lea.l        $ff0778.l, a0                                 ; $07FC02
        move.w       #$0, d0                                       ; $07FC08
        jsr          LoadPaletteLine.l                             ; $07FC0C
        move.w       #$3, d0                                       ; $07FC12
        jsr          LoadPaletteLine.l                             ; $07FC16
        move.w       #$d, d0                                       ; $07FC1C
        jsr          PlaySoundEvent(pc)                            ; $07FC20
        move.w       #$a, d0                                       ; $07FC24
        jsr          WaitVBlankFrames.l                            ; $07FC28
        move.w       #$d, d0                                       ; $07FC2E
        jsr          PlaySoundEvent(pc)                            ; $07FC32
        move.w       #$384, d0                                     ; $07FC36

loc_07FC3A:
        move.w       d0, -(a7)                                     ; $07FC3A
        jsr          WaitForVBlank.w                               ; $07FC3C
        movea.l      $2(a7), a1                                    ; $07FC40
; Saved briefing A1 callback at 2(sp), below pushed loop counter. Body bypassed by original $7F4FC RTS.
        jsr          (a1)                                          ; $07FC44
        jsr          ReadController.l                              ; $07FC46
        btst.b       #$7, ramControllerState.l                     ; $07FC4C
        beq.w        loc_07FC6A                                    ; $07FC54
        btst.b       #$7, ramPreviousControllerState.l             ; $07FC58
        bne.w        loc_07FC6A                                    ; $07FC60
        addq.w       #$2, a7                                       ; $07FC64
        bra.w        loc_07FC70                                    ; $07FC66

loc_07FC6A:
        move.w       (a7)+, d0                                     ; $07FC6A
        dbra         d0, loc_07FC3A                                ; $07FC6C

loc_07FC70:
        lea.l        $ff0778.l, a0                                 ; $07FC70
        move.w       #$4, d1                                       ; $07FC76
        jsr          VideoRoutine_022018.l                         ; $07FC7A
        jsr          PlayPendingSequence(pc)                       ; $07FC80
        addq.l       #$4, a7                                       ; $07FC84
        movea.l      (a7)+, a6                                     ; $07FC86
        rts                                                        ; $07FC88
        ifne *-$7FC8A
        fail "ROM end moved"
        endif
