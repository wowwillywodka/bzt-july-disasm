; $01F7FE..$01F811 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F7FE
        fail "ROM start moved"
        endif

DrawDogBaseFrame:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01F7FE
        move.w       #$0, d0                                       ; $01F806
        move.w       #$ffff, d2                                    ; $01F80A
        bra.w        DrawActorAnimation                            ; $01F80E
        ifne *-$1F812
        fail "ROM end moved"
        endif
