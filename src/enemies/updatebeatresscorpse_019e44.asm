; $019E44..$019E89 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB->CC, CC waits for draw counter0, then CA/state3. Without draw calls transition stalls.
        ifne *-$19E44
        fail "ROM start moved"
        endif

UpdateBeatressCorpse:
; CB->CC, CC waits for draw counter0, then CA/state3. Without draw calls transition stalls.
        clr.b        ActorUpdateDelay(a0)                          ; $019E44
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $019E48
        beq.w        loc_019E82                                    ; $019E4E
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $019E52
        beq.w        WaitBeatressCorpseDrawing                     ; $019E58
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019E5C
        beq.w        loc_019E7E                                    ; $019E62
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019E66
        beq.w        loc_019E7E                                    ; $019E6C
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $019E70
        beq.w        MoveBeatressCorpseAndTryPickup                ; $019E76
        bra.w        MoveBeatressCorpseAndTryPickup                ; $019E7A

loc_019E7E:
        bra.w        MoveBeatressCorpseAndTryPickup                ; $019E7E

loc_019E82:
        move.b       #$cc, ActorDeathMode(a0)                      ; $019E82
        rts                                                        ; $019E88
        ifne *-$19E8A
        fail "ROM end moved"
        endif
