; $000ECA..$000F3D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Rebuild inventory after character death: clear inventory via $0116BE, then call item allocator $011C78 for each saved nonzero item.
        ifne *-$ECA
        fail "ROM start moved"
        endif

RestoreInventoryAfterCharacterDeath:
; Rebuild inventory after character death: clear inventory via $0116BE, then call item allocator $011C78 for each saved nonzero item.
        jsr          ResetInventoryAndVisualEffects.l                            ; $000ECA
        clr.w        rItemGrantAmountOverride(a6)                                    ; $000ED0
        move.b       rSavedInventoryAmount0(a6), rItemGrantAmountOverride(a6)        ; $000ED4
        clr.w        d0                                            ; $000EDA
        move.b       rSavedInventoryItem0(a6), d0                  ; $000EDC
        beq.b        loc_000EE8                                    ; $000EE0
        jsr          GrantInventoryItem.l                            ; $000EE2

loc_000EE8:
        move.b       rSavedInventoryAmount1(a6), rItemGrantAmountOverride(a6)        ; $000EE8
        clr.w        d0                                            ; $000EEE
        move.b       rSavedInventoryItem1(a6), d0                  ; $000EF0
        beq.b        loc_000EFC                                    ; $000EF4
        jsr          GrantInventoryItem.l                            ; $000EF6

loc_000EFC:
        move.b       rSavedInventoryAmount2(a6), rItemGrantAmountOverride(a6)        ; $000EFC
        clr.w        d0                                            ; $000F02
        move.b       rSavedInventoryItem2(a6), d0                  ; $000F04
        beq.b        loc_000F10                                    ; $000F08
        jsr          GrantInventoryItem.l                            ; $000F0A

loc_000F10:
        move.b       rSavedInventoryAmount3(a6), rItemGrantAmountOverride(a6)        ; $000F10
        clr.w        d0                                            ; $000F16
        move.b       rSavedInventoryItem3(a6), d0                  ; $000F18
        beq.b        loc_000F24                                    ; $000F1C
        jsr          GrantInventoryItem.l                            ; $000F1E

loc_000F24:
        move.b       rSavedInventoryAmount4(a6), rItemGrantAmountOverride(a6)        ; $000F24
        clr.w        d0                                            ; $000F2A
        move.b       rSavedInventoryItem4(a6), d0                  ; $000F2C
        beq.b        loc_000F38                                    ; $000F30
        jsr          GrantInventoryItem.l                            ; $000F32

loc_000F38:
        clr.w        rItemGrantAmountOverride(a6)                                    ; $000F38
        rts                                                        ; $000F3C
        ifne *-$F3E
        fail "ROM end moved"
        endif
