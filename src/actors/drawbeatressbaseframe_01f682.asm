; $01F682..$01F695 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F682
        fail "ROM start moved"
        endif

DrawBeatressBaseFrame:
        move.l       #BeatressSpriteBank, ActorSpriteBank(a0)      ; $01F682
        move.w       #$0, d0                                       ; $01F68A
        move.w       #$ffff, d2                                    ; $01F68E
        bra.w        DrawActorAnimation                            ; $01F692
        ifne *-$1F696
        fail "ROM end moved"
        endif
