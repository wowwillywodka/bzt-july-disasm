; $01F5C4..$01F5D7 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F5C4
        fail "ROM start moved"
        endif

DrawWhiteDummyBaseFrame:
        move.l       #WhiteDummySpriteBank, ActorSpriteBank(a0)    ; $01F5C4
        move.w       #$0, d0                                       ; $01F5CC
        move.w       #$ffff, d2                                    ; $01F5D0
        bra.w        DrawActorAnimation                            ; $01F5D4
        ifne *-$1F5D8
        fail "ROM end moved"
        endif
