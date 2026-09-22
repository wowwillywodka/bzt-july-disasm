; $0128D6..$0128EF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Selected inventory slot -> item kind -> ItemSelectionRemap -> PendingWeaponId. Item kind is not weapon ID: 4->16 Gunrock,5->17 Snowman; non-weapons map0. No bounds check on kind.
        ifne *-$128D6
        fail "ROM start moved"
        endif

RequestWeaponFromSelectedItem:
; Selected inventory slot -> item kind -> ItemSelectionRemap -> PendingWeaponId. Item kind is not weapon ID: 4->16 Gunrock,5->17 Snowman; non-weapons map0. No bounds check on kind.
        lea.l        rInventorySlots(a6), a0                       ; $0128D6
        clr.w        d0                                            ; $0128DA
        move.b       rSelectedInventorySlot(a6), d0                ; $0128DC
        mulu.w       #$4, d0                                       ; $0128E0
        move.w       (a0, d0.w), d0                                ; $0128E4
        move.b       ItemSelectionRemap(pc, d0.w), rPendingWeaponId(a6) ; $0128E8
        rts                                                        ; $0128EE
        ifne *-$128F0
        fail "ROM end moved"
        endif
