; $021702..$021727 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: direct calls to screen helpers, ends RTS; ordinary reachability not established
        ifne *-$21702
        fail "ROM start moved"
        endif

RetainedScreenSequence:
        jsr          UiRoutine_021728.l                            ; $021702
        jsr          RetainedUiWaitReturn.l                        ; $021708
        jsr          loc_02173E.l                                  ; $02170E
        jsr          UiRoutine_021728.l                            ; $021714
        jsr          UiRoutine_021746.l                            ; $02171A
        jsr          ClearAllVram.l                                ; $021720
        rts                                                        ; $021726
        ifne *-$21728
        fail "ROM end moved"
        endif
