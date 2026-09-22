; $01BB7E..$01BBC3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB->CC; wait for draw counter0 then CA/state4. Ordinary death never enables the later State3 pickup condition.
        ifne *-$1BB7E
        fail "ROM start moved"
        endif

UpdateDenpyderCorpse:
; CB->CC; wait for draw counter0 then CA/state4. Ordinary death never enables the later State3 pickup condition.
        clr.b        ActorUpdateDelay(a0)                          ; $01BB7E
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01BB82
        beq.w        loc_01BBBC                                    ; $01BB88
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01BB8C
        beq.w        WaitDenpyderCorpseDrawing                     ; $01BB92
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01BB96
        beq.w        loc_01BBB8                                    ; $01BB9C
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01BBA0
        beq.w        loc_01BBB8                                    ; $01BBA6
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $01BBAA
        beq.w        MoveDenpyderCorpseAndTryPickup                ; $01BBB0
        bra.w        MoveDenpyderCorpseAndTryPickup                ; $01BBB4

loc_01BBB8:
        bra.w        MoveDenpyderCorpseAndTryPickup                ; $01BBB8

loc_01BBBC:
        move.b       #$cc, ActorDeathMode(a0)                      ; $01BBBC
        rts                                                        ; $01BBC2
        ifne *-$1BBC4
        fail "ROM end moved"
        endif
