; $02173C..$021745 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$2173C
        fail "ROM start moved"
        endif

RetainedUiWaitReturn:
        rts                                                        ; $02173C

; Reviewed call entry (wrapper): Calls RunMissionSelection and returns; retained caller.
RunMissionSelectionFromRetainedUi:
        jsr          RunMissionSelection.l                         ; $02173E
        rts                                                        ; $021744
        ifne *-$21746
        fail "ROM end moved"
        endif
