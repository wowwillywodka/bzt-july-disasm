; $01F7E2..$01F821 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Аниматор спрайт-сета $29acf6: хвост D0=1,D2=2/3 и ветка инициализации графики (0x46,A0)=$29acf6 с переходом в 0x1f982/0x1f844
        ifne *-$1F7E2
        fail "ROM start moved"
        endif

ActorsRoutine_01F7E2:
        move.w       #$1, d0                                       ; $01F7E2
        move.w       #$2, d2                                       ; $01F7E6
        bra.b        loc_01F7F4                                    ; $01F7EA

loc_01F7EC:
        move.w       #$1, d0                                       ; $01F7EC
        move.w       #$3, d2                                       ; $01F7F0

loc_01F7F4:
        lea.l        -$6fdc(a6), a0                                ; $01F7F4
        jmp          QueueLinkCommand.l                            ; $01F7F8

loc_01F7FE:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01F7FE
        move.w       #$0, d0                                       ; $01F806
        move.w       #$ffff, d2                                    ; $01F80A
        bra.w        DrawActorAnimation                            ; $01F80E

loc_01F812:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01F812
        move.w       #$3, d0                                       ; $01F81A
        bra.w        loc_01F844                                    ; $01F81E
        ifne *-$1F822
        fail "ROM end moved"
        endif
