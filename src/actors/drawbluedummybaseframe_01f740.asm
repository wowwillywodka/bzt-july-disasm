; $01F740..$01F753 | m68k
; Remote actor draw callback: select sprite bank and base animation frame.
        ifne *-$1F740
        fail "ROM start moved"
        endif

DrawBlueDummyBaseFrame:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $01F740
        move.w       #$0, d0                                       ; $01F748
        move.w       #$ffff, d2                                    ; $01F74C
        bra.w        DrawActorAnimation                            ; $01F750
        ifne *-$1F754
        fail "ROM end moved"
        endif
