; $01F2E0..$01F2EF | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F2E0
        fail "ROM start moved"
        endif

DrawGreyDummyStateParityFrame:
        move.l       #GreyDummySpriteBank, ActorSpriteBank(a0)     ; $01F2E0
        move.w       #$2, d0                                       ; $01F2E8
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F2EC
        ifne *-$1F2F0
        fail "ROM end moved"
        endif
