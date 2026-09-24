; $01498A..$0149EF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Timed inventory effects: Night Vision count at phase 0, Flash Light count at $70, third icon at $50. Flash Light band pointers track view sway after the scene render.
        ifne *-$1498A
        fail "ROM start moved"
        endif

TickTimedInventoryEffects:
        move.w       rGameTick(a6), d0                             ; $01498A
        andi.w       #$7f, d0                                      ; $01498E
        bne.b        loc_01499E                                    ; $014992
        tst.w        rNightVisionInventorySlotIndex(a6)                                    ; $014994
        bmi.b        loc_01499E                                    ; $014998
        bsr.w        TickNightVisionItemAndUpdateIcon                              ; $01499A

loc_01499E:
        tst.w        rNightVisionInventorySlotIndex(a6)                                    ; $01499E
        bpl.b        loc_0149D6                                    ; $0149A2
        tst.w        rFlashlightInventorySlotIndex(a6)                                    ; $0149A4
        bmi.b        loc_0149D6                                    ; $0149A8
        move.l       #$ff8aba, d1                                  ; $0149AA
        move.w       rViewSwayAngleOffset(a6), d2                                ; $0149B0
        lsl.w        #$2, d2                                       ; $0149B4
        ext.l        d2                                            ; $0149B6
        add.l        d2, d1                                        ; $0149B8
        move.l       d1, rFlashlightBandStartPointer(a6)                                ; $0149BA
        addi.l       #$20, d1                                      ; $0149BE
        move.l       d1, rFlashlightBandEndPointer(a6)                                ; $0149C4
        addi.w       #$10, d0                                      ; $0149C8
        andi.w       #$7f, d0                                      ; $0149CC
        bne.b        loc_0149D6                                    ; $0149D0
        bsr.w        TickFlashlightItemAndUpdateIcon                              ; $0149D2

loc_0149D6:
        move.w       rGameTick(a6), d0                             ; $0149D6
        addi.w       #$30, d0                                      ; $0149DA
        andi.w       #$7f, d0                                      ; $0149DE
        bne.b        loc_0149EE                                    ; $0149E2
        tst.w        rTimedItemSlot6Index(a6)                                    ; $0149E4
        bmi.b        loc_0149EE                                    ; $0149E8
        bsr.w        TickIndexedTimedItemAndUpdateIcon                              ; $0149EA

loc_0149EE:
        rts                                                        ; $0149EE
        ifne *-$149F0
        fail "ROM end moved"
        endif
