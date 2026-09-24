; $01F0A6..$01F0B5 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F0A6
        fail "ROM start moved"
        endif

DrawBloodBodyStateParityFrame:
        move.l       #BloodBodySpriteBank, ActorSpriteBank(a0)     ; $01F0A6
        move.w       #$4, d0                                       ; $01F0AE
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F0B2
        ifne *-$1F0B6
        fail "ROM end moved"
        endif
