; $011C72..$011C77 | m68k
; Maintained assembly input; no extraction occurs during build.
; Retained entry: copy D7 into the alternate hit-slot selector.
; No ordinary caller of this entry has been established in July.
        ifne *-$11C72
        fail "ROM start moved"
        endif

RetainedSetAlternateHitSlot:
        move.w       d7, rAlternateHitSlotIndex(a6)                                ; $011C72
        rts                                                        ; $011C76
        ifne *-$11C78
        fail "ROM end moved"
        endif
