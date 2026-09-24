; $000E8C..$000EC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Save five inventory item/amount byte pairs, not a HUD digit buffer. Quantity representation depends on the caller; see docs/GAME_FLOW.md.
        ifne *-$E8C
        fail "ROM start moved"
        endif

SaveInventoryForSceneRestart:
; Save five inventory item/amount byte pairs, not a HUD digit buffer. Quantity representation depends on the caller; see docs/GAME_FLOW.md.
        move.b       rInventorySlot0ItemIdLow(a6), rSavedInventoryItem0(a6)          ; $000E8C
        move.b       rInventorySlot0QuantityHigh(a6), rSavedInventoryAmount0(a6)        ; $000E92
        move.b       rInventorySlot1ItemIdLow(a6), rSavedInventoryItem1(a6)          ; $000E98
        move.b       rInventorySlot1QuantityHigh(a6), rSavedInventoryAmount1(a6)        ; $000E9E
        move.b       rInventorySlot2ItemIdLow(a6), rSavedInventoryItem2(a6)          ; $000EA4
        move.b       rInventorySlot2QuantityHigh(a6), rSavedInventoryAmount2(a6)        ; $000EAA
        move.b       rInventorySlot3ItemIdLow(a6), rSavedInventoryItem3(a6)          ; $000EB0
        move.b       rInventorySlot3QuantityHigh(a6), rSavedInventoryAmount3(a6)        ; $000EB6
        move.b       rInventorySlot4ItemIdLow(a6), rSavedInventoryItem4(a6)          ; $000EBC
        move.b       rInventorySlot4QuantityHigh(a6), rSavedInventoryAmount4(a6)        ; $000EC2
        rts                                                        ; $000EC8
        ifne *-$ECA
        fail "ROM end moved"
        endif
