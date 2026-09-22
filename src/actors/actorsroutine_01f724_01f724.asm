; $01F724..$01F763 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Аниматор спрайт-сета $27d95c: блок кадров D0=1,D2=2/3, выбор кадра по байтам состояния 0x38/0x39/0x3a и переход в аниматор 0x1f982
        ifne *-$1F724
        fail "ROM start moved"
        endif

ActorsRoutine_01F724:
        move.w       #$1, d0                                       ; $01F724
        move.w       #$2, d2                                       ; $01F728
        bra.b        loc_01F736                                    ; $01F72C

loc_01F72E:
        move.w       #$1, d0                                       ; $01F72E
        move.w       #$3, d2                                       ; $01F732

loc_01F736:
        lea.l        -$6fdc(a6), a0                                ; $01F736
        jmp          QueueLinkCommand.l                            ; $01F73A

loc_01F740:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $01F740
        move.w       #$0, d0                                       ; $01F748
        move.w       #$ffff, d2                                    ; $01F74C
        bra.w        DrawActorAnimation                            ; $01F750

loc_01F754:
        move.l       #BlueDummySpriteBank, ActorSpriteBank(a0)     ; $01F754
        move.w       #$2, d0                                       ; $01F75C
        bra.w        loc_01F844                                    ; $01F760
        ifne *-$1F764
        fail "ROM end moved"
        endif
