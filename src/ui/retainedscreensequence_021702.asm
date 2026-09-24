; $021702..$021727 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: direct calls to screen helpers, ends RTS; ordinary reachability not established
        ifne *-$21702
        fail "ROM start moved"
        endif

RetainedScreenSequence:
        jsr          InitializeRetainedScreenVideo.l                            ; $021702
        jsr          RetainedUiWaitReturn.l                        ; $021708
        jsr          RunMissionSelectionFromRetainedUi.l                                  ; $02170E
        jsr          InitializeRetainedScreenVideo.l                            ; $021714
        jsr          RunRetainedScreenPresentation.l                            ; $02171A
        jsr          ClearAllVram.l                                ; $021720
        rts                                                        ; $021726
        ifne *-$21728
        fail "ROM end moved"
        endif
