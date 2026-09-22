; $000FD0..$00103B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Initialize all five character availability bytes, saved inventory and saved health; normal mode validates password and copies RequestedStartSelection. GeometryEpisode is not cleared here.
        ifne *-$FD0
        fail "ROM start moved"
        endif

InitializeNewGameState:
; Initialize all five character availability bytes, saved inventory and saved health; normal mode validates password and copies RequestedStartSelection. GeometryEpisode is not cleared here.
        clr.b        -$5584(a6)                                    ; $000FD0
        clr.b        rLevelSelection(a6)                           ; $000FD4
        move.b       #$64, rSavedHealth(a6)                        ; $000FD8
        move.b       #$1, rCharacterAvailable0(a6)                 ; $000FDE
        move.b       #$1, rCharacterAvailable1(a6)                 ; $000FE4
        move.b       #$1, rCharacterAvailable2(a6)                 ; $000FEA
        move.b       #$1, rCharacterAvailable3(a6)                 ; $000FF0
        move.b       #$1, rCharacterAvailable4(a6)                 ; $000FF6
        clr.b        rSavedInventoryItem0(a6)                      ; $000FFC
        clr.b        rSavedInventoryItem1(a6)                      ; $001000
        clr.b        rSavedInventoryItem2(a6)                      ; $001004
        clr.b        rSavedInventoryItem3(a6)                      ; $001008
        clr.b        rSavedInventoryItem4(a6)                      ; $00100C
        clr.b        rSavedInventoryAmount0(a6)                    ; $001010
        clr.b        rSavedInventoryAmount1(a6)                    ; $001014
        clr.b        rSavedInventoryAmount2(a6)                    ; $001018
        clr.b        rSavedInventoryAmount3(a6)                    ; $00101C
        clr.b        rSavedInventoryAmount4(a6)                    ; $001020
        tst.w        rDemoMode(a6)                                 ; $001024
        bne.b        loc_00103A                                    ; $001028
        lea.l        -$7ff6(a6), a0                                ; $00102A
        jsr          ValidatePasswordAndCheats.l                   ; $00102E
        move.b       rRequestedStartSelection(a6), rLevelSelection(a6) ; $001034

loc_00103A:
        rts                                                        ; $00103A
        ifne *-$103C
        fail "ROM end moved"
        endif
