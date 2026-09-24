; $029496..$0294FD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Capture the first five ordinary inventory slot IDs,
; scan IDs 1..14 for matching quantities in ascending order, quantize health,
; and encode GeometryEpisode as the ordinary password's six-bit episode field.
        ifne *-$29496
        fail "ROM start moved"
        endif

EncodeCurrentProgressSnapshot:
; The separate quantity scan preserves the ascending order reconstructed by
; the decoder from the item-ID mask; special inventory slots are excluded.
        lea.l        rSceneProgressPasswordText(a6), a0                                ; $029496
        move.b       rInventorySlot0ItemIdLow(a6), rSavedInventoryItem0(a6)          ; $02949A
        move.b       rInventorySlot1ItemIdLow(a6), rSavedInventoryItem1(a6)          ; $0294A0
        move.b       rInventorySlot2ItemIdLow(a6), rSavedInventoryItem2(a6)          ; $0294A6
        move.b       rInventorySlot3ItemIdLow(a6), rSavedInventoryItem3(a6)          ; $0294AC
        move.b       rInventorySlot4ItemIdLow(a6), rSavedInventoryItem4(a6)          ; $0294B2
        lea.l        rSavedInventoryAmount0(a6), a2                ; $0294B8
        move.w       #$1, d6                                       ; $0294BC

loc_0294C0:
        lea.l        rInventorySlots(a6), a3                       ; $0294C0
        cmp.w        (a3), d6                                      ; $0294C4
        beq.b        loc_0294E0                                    ; $0294C6
        addq.w       #$4, a3                                       ; $0294C8
        cmp.w        (a3), d6                                      ; $0294CA
        beq.b        loc_0294E0                                    ; $0294CC
        addq.w       #$4, a3                                       ; $0294CE
        cmp.w        (a3), d6                                      ; $0294D0
        beq.b        loc_0294E0                                    ; $0294D2
        addq.w       #$4, a3                                       ; $0294D4
        cmp.w        (a3), d6                                      ; $0294D6
        beq.b        loc_0294E0                                    ; $0294D8
        addq.w       #$4, a3                                       ; $0294DA
        cmp.w        (a3), d6                                      ; $0294DC
        bne.b        loc_0294EA                                    ; $0294DE

loc_0294E0:
        bsr.b        AppendScaledProgressByte                            ; $0294E0
        cmpa.l       #$ff2c45, a2                                  ; $0294E2
        beq.b        loc_02951C                                    ; $0294E8

loc_0294EA:
        addq.w       #$1, d6                                       ; $0294EA
        cmpi.w       #$f, d6                                       ; $0294EC
        bcs.b        loc_0294C0                                    ; $0294F0

loc_0294F2:
        cmpa.l       #$ff2c45, a2                                  ; $0294F2
        beq.b        loc_02951C                                    ; $0294F8
        clr.b        (a2)+                                         ; $0294FA
        bra.b        loc_0294F2                                    ; $0294FC
        ifne *-$294FE
        fail "ROM end moved"
        endif
