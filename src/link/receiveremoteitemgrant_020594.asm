; $020594..$0205D5 | m68k
; Separate link command handler entry.
        ifne *-$20594
        fail "ROM start moved"
        endif

ReceiveRemoteItemGrant:
        clr.w        d0                                            ; $020594
        move.b       (a0)+, d0                                     ; $020596
        move.b       (a0)+, d2                                     ; $020598
        lsl.w        #$8, d2                                       ; $02059A
        move.w       d2, rItemGrantAmountOverride(a6)                                ; $02059C
        move.w       d0, -(a7)                                     ; $0205A0
        jsr          GrantInventoryItem.l                            ; $0205A2
        move.w       (a7)+, d0                                     ; $0205A8
        clr.w        rItemGrantAmountOverride(a6)                                    ; $0205AA
        cmpi.w       #$ffff, d7                                    ; $0205AE
        bne.b        loc_0205B6                                    ; $0205B2
        rts                                                        ; $0205B4

loc_0205B6:
        move.w       d0, -(a7)                                     ; $0205B6
        move.w       #$60, d0                                      ; $0205B8
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $0205BC
        move.w       (a7)+, d0                                     ; $0205C2
        movea.l      #ItemPickupMessagePointers, a0                ; $0205C4
        lsl.w        #$2, d0                                       ; $0205CA
        adda.w       d0, a0                                        ; $0205CC
        movea.l      (a0), a0                                      ; $0205CE
        jmp          QueueStatusMessage.l                          ; $0205D0
        ifne *-$205D6
        fail "ROM end moved"
        endif
