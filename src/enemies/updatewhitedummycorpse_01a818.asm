; $01A818..$01A85D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB->CC without decrement; CC waits for draw-side counter to reach zero, then CA/state3. Without draw calls this transition does not advance.
        ifne *-$1A818
        fail "ROM start moved"
        endif

UpdateWhiteDummyCorpse:
; CB->CC without decrement; CC waits for draw-side counter to reach zero, then CA/state3. Without draw calls this transition does not advance.
        clr.b        ActorUpdateDelay(a0)                          ; $01A818
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01A81C
        beq.w        loc_01A856                                    ; $01A822
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01A826
        beq.w        WaitWhiteDummyCorpseDrawing                   ; $01A82C
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01A830
        beq.w        loc_01A852                                    ; $01A836
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01A83A
        beq.w        loc_01A852                                    ; $01A840
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $01A844
        beq.w        MoveWhiteDummyCorpseAndTryPickup              ; $01A84A
        bra.w        MoveWhiteDummyCorpseAndTryPickup              ; $01A84E

loc_01A852:
        bra.w        MoveWhiteDummyCorpseAndTryPickup              ; $01A852

loc_01A856:
        move.b       #$cc, ActorDeathMode(a0)                      ; $01A856
        rts                                                        ; $01A85C
        ifne *-$1A85E
        fail "ROM end moved"
        endif
