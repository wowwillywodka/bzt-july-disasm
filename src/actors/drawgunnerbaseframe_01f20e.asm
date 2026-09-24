; $01F20E..$01F221 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F20E
        fail "ROM start moved"
        endif

DrawGunnerBaseFrame:
        move.l       #GunnerSpriteBank, ActorSpriteBank(a0)        ; $01F20E
        move.w       #$0, d0                                       ; $01F216
        move.w       #$ffff, d2                                    ; $01F21A
        bra.w        DrawActorAnimation                            ; $01F21E
        ifne *-$1F222
        fail "ROM end moved"
        endif
