; $01F39E..$01F3AD | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F39E
        fail "ROM start moved"
        endif

DrawGreenDummyStateParityFrame:
        move.l       #GreenDummySpriteBank, ActorSpriteBank(a0)    ; $01F39E
        move.w       #$2, d0                                       ; $01F3A6
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F3AA
        ifne *-$1F3AE
        fail "ROM end moved"
        endif
