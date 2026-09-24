; $01F754..$01F763 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F754
        fail "ROM start moved"
        endif

DrawBlueDummyStateParityFrame:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $01F754
        move.w       #$2, d0                                       ; $01F75C
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F760
        ifne *-$1F764
        fail "ROM end moved"
        endif
