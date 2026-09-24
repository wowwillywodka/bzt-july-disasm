; $01F2CC..$01F2DF | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F2CC
        fail "ROM start moved"
        endif

DrawGreyDummyBaseFrame:
        move.l       #GreyDummySpriteBank, ActorSpriteBank(a0)     ; $01F2CC
        move.w       #$0, d0                                       ; $01F2D4
        move.w       #$ffff, d2                                    ; $01F2D8
        bra.w        DrawActorAnimation                            ; $01F2DC
        ifne *-$1F2E0
        fail "ROM end moved"
        endif
