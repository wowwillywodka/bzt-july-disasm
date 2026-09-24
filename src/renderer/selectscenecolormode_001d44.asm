; $001D44..$001D67 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Select scene color mode from floor byte; effect-state flags can route through $011F70. This is not a menu-item selector.
        ifne *-$1D44
        fail "ROM start moved"
        endif

SelectSceneColorMode:
; Select scene color mode from floor byte; effect-state flags can route through $011F70. This is not a menu-item selector.
        andi.w       #$ff, d0                                      ; $001D44
        tst.w        rNightVisionInventorySlotIndex(a6)                                    ; $001D48
        bmi.b        loc_001D58                                    ; $001D4C
        move.w       d0, rSceneColorMode(a6)                       ; $001D4E
        jmp          ApplyEffectColorPalette.l                            ; $001D52

loc_001D58:
        tst.w        rFlashlightInventorySlotIndex(a6)                                    ; $001D58
        bmi.b        ApplySceneColorMode                           ; $001D5C
        bsr.b        ApplySceneColorMode                           ; $001D5E
        move.w       #$10, rVisibleRayCellRadius(a6)                              ; $001D60
        rts                                                        ; $001D66
        ifne *-$1D68
        fail "ROM end moved"
        endif
