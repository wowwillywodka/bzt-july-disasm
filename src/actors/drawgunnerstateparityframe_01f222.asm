; $01F222..$01F231 | m68k
; Remote actor draw callback: select sprite bank and state-dependent frame.
        ifne *-$1F222
        fail "ROM start moved"
        endif

DrawGunnerStateParityFrame:
        move.l       #GunnerSpriteBank, ActorSpriteBank(a0)        ; $01F222
        move.w       #$3, d0                                       ; $01F22A
        bra.w        SelectActorStateCounterParityFrame                                    ; $01F22E
        ifne *-$1F232
        fail "ROM end moved"
        endif
