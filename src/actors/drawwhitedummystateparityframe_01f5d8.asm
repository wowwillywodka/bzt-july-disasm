; $01F5D8..$01F5E7 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F5D8
        fail "ROM start moved"
        endif

DrawWhiteDummyStateParityFrame:
        move.l       #WhiteDummySpriteBank, ActorSpriteBank(a0)    ; $01F5D8
        move.w       #$3, d0                                       ; $01F5E0
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F5E4
        ifne *-$1F5E8
        fail "ROM end moved"
        endif
