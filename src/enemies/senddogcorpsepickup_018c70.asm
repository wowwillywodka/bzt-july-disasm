; $018C70..$018C9D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active remote-target path: set state4; command13/item08/amount2 or3. It must not be classified as the preceding retained local tail.
        ifne *-$18C70
        fail "ROM start moved"
        endif

SendDogCorpsePickup:
; Active remote-target path: set state4; command13/item08/amount2 or3. It must not be classified as the preceding retained local tail.
        lea.l        -$6fdc(a6), a1                                ; $018C70
        move.b       #$4, ActorState(a0)                           ; $018C74
        move.b       #$13, (a1)+                                   ; $018C7A
        move.b       #$8, (a1)+                                    ; $018C7E
        jsr          NextRandom.l                                  ; $018C82
        asr.w        #$8, d2                                       ; $018C88
        andi.w       #$1, d2                                       ; $018C8A
        addq.w       #$2, d2                                       ; $018C8E
        move.b       d2, (a1)+                                     ; $018C90
        lea.l        -$6fdc(a6), a0                                ; $018C92
        jmp          QueueLinkCommand.l                            ; $018C96

loc_018C9C:
        rts                                                        ; $018C9C
        ifne *-$18C9E
        fail "ROM end moved"
        endif
