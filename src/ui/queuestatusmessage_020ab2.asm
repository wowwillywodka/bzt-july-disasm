; $020AB2..$020ACD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Append A0 message pointer to the 16-entry array; count == 16 returns. This is not a ring buffer; the update shifts pending pointers.
        ifne *-$20AB2
        fail "ROM start moved"
        endif

QueueStatusMessage:
; Append A0 message pointer to the 16-entry array; count == 16 returns. This is not a ring buffer; the update shifts pending pointers.
        move.w       rStatusMessageQueueCount(a6), d0                                ; $020AB2
        cmpi.w       #$10, d0                                      ; $020AB6
        bne.b        loc_020ABE                                    ; $020ABA
        rts                                                        ; $020ABC

loc_020ABE:
        addq.w       #$1, rStatusMessageQueueCount(a6)                               ; $020ABE
        lea.l        rStatusMessageQueue(a6), a1                                ; $020AC2
        lsl.w        #$2, d0                                       ; $020AC6
        adda.w       d0, a1                                        ; $020AC8
        move.l       a0, (a1)                                      ; $020ACA
        rts                                                        ; $020ACC
        ifne *-$20ACE
        fail "ROM end moved"
        endif
