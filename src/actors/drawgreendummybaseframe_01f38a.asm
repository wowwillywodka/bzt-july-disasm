; $01F38A..$01F39D | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F38A
        fail "ROM start moved"
        endif

DrawGreenDummyBaseFrame:
        move.l       #GreenDummySpriteBank, ActorSpriteBank(a0)    ; $01F38A
        move.w       #$0, d0                                       ; $01F392
        move.w       #$ffff, d2                                    ; $01F396
        bra.w        DrawActorAnimation                            ; $01F39A
        ifne *-$1F39E
        fail "ROM end moved"
        endif
