; $01F696..$01F6A5 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F696
        fail "ROM start moved"
        endif

DrawBeatressStateParityFrame:
        move.l       #BeatressSpriteBank, ActorSpriteBank(a0)      ; $01F696
        move.w       #$2, d0                                       ; $01F69E
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F6A2
        ifne *-$1F6A6
        fail "ROM end moved"
        endif
