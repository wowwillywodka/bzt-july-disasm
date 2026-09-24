; $01F150..$01F163 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F150
        fail "ROM start moved"
        endif

DrawStananBaseFrame:
        move.l       #StananSpriteBank, ActorSpriteBank(a0)        ; $01F150
        move.w       #$0, d0                                       ; $01F158
        move.w       #$ffff, d2                                    ; $01F15C
        bra.w        DrawActorAnimation                            ; $01F160
        ifne *-$1F164
        fail "ROM end moved"
        endif
