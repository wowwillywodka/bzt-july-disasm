; $00182A..$001883 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Clear availability of SelectedCharacter; zero OR of all five bytes -> no survivors. Otherwise save inventory and open character selection; no episode geometry reload.
        ifne *-$182A
        fail "ROM start moved"
        endif

RetireDeadCharacter:
; Clear availability of SelectedCharacter; zero OR of all five bytes -> no survivors. Otherwise save inventory and open character selection; no episode geometry reload.
        jsr          PlayPendingSequence.l                         ; $00182A
        move.w       rSelectedCharacter(a6), d0                    ; $001830
        lea.l        rCharacterAvailable0(a6), a0                  ; $001834
        clr.b        (a0, d0.w)                                    ; $001838
        move.b       rCharacterAvailable0(a6), d0                  ; $00183C
        or.b         rCharacterAvailable1(a6), d0                  ; $001840
        or.b         rCharacterAvailable2(a6), d0                  ; $001844
        or.b         rCharacterAvailable3(a6), d0                  ; $001848
        or.b         rCharacterAvailable4(a6), d0                  ; $00184C
        beq.w        HandleNoSurvivingCharacters                   ; $001850
        tst.w        rLinkRole(a6)                                 ; $001854
        beq.b        loc_001874                                    ; $001858
        bset.b       #$0, rPauseFlags(a6)                          ; $00185A
        lea.l        -$6fdc(a6), a0                                ; $001860
        move.b       #$14, (a0)                                    ; $001864
        jsr          QueueLinkCommand.l                            ; $001868
        jsr          InputRoutine_020058.l                         ; $00186E

loc_001874:
        bsr.w        SaveInventoryForSceneRestart                  ; $001874
        movea.l      #ActorNoOp, a1                                ; $001878
        jsr          RunCharacterSelection.l                       ; $00187E
        ifne *-$1884
        fail "ROM end moved"
        endif
