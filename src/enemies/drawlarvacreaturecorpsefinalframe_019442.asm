; $019442..$019455 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Хвост 0x019372: кадр анимации D0=4/D2=3, декремент таймера 0x39, прыжок в аниматор спрайта 0x1f982
        ifne *-$19442
        fail "ROM start moved"
        endif

DrawLarvaCreatureCorpseFinalFrame:
        move.w       #$4, d0                                       ; $019442
        move.w       #$3, d2                                       ; $019446
        subq.b       #$1, ActorStateCounter(a0)                    ; $01944A
        jmp          DrawActorAnimation.l                          ; $01944E

loc_019454:
        bra.b        DrawLarvaCreatureCorpseTransition             ; $019454
        ifne *-$19456
        fail "ROM end moved"
        endif
