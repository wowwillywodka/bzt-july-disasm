; $01F164..$01F173 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F164
        fail "ROM start moved"
        endif

DrawStananStateParityFrame:
        move.l       #StananSpriteBank, ActorSpriteBank(a0)        ; $01F164
        move.w       #$4, d0                                       ; $01F16C
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F170
        ifne *-$1F174
        fail "ROM end moved"
        endif
