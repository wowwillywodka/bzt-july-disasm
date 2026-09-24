; $01F092..$01F0A5 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F092
        fail "ROM start moved"
        endif

DrawBloodBodyBaseFrame:
        move.l       #BloodBodySpriteBank, ActorSpriteBank(a0)     ; $01F092
        move.w       #$0, d0                                       ; $01F09A
        move.w       #$ffff, d2                                    ; $01F09E
        bra.w        DrawActorAnimation                            ; $01F0A2
        ifne *-$1F0A6
        fail "ROM end moved"
        endif
