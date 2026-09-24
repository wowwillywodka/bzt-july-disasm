; $01F812..$01F821 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F812
        fail "ROM start moved"
        endif

DrawDogStateParityFrame:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01F812
        move.w       #$3, d0                                       ; $01F81A
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F81E
        ifne *-$1F822
        fail "ROM end moved"
        endif
