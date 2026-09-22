; $01F1F2..$01F231 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 19860] Хвост выбора направленного кадра актёра: задаёт индекс кадра d0=1/d2=2..3 и строит draw-пакет типа $d (коорд $24/$26, суб-коорд $2e/$30) для очереди рендера $1a342
        ifne *-$1F1F2
        fail "ROM start moved"
        endif

ActorsRoutine_01F1F2:
        move.w       #$1, d0                                       ; $01F1F2
        move.w       #$2, d2                                       ; $01F1F6
        bra.b        loc_01F204                                    ; $01F1FA

loc_01F1FC:
        move.w       #$1, d0                                       ; $01F1FC
        move.w       #$3, d2                                       ; $01F200

loc_01F204:
        lea.l        -$6fdc(a6), a0                                ; $01F204
        jmp          QueueLinkCommand.l                            ; $01F208

loc_01F20E:
        move.l       #GunnerSpriteBank, ActorSpriteBank(a0)        ; $01F20E
        move.w       #$0, d0                                       ; $01F216
        move.w       #$ffff, d2                                    ; $01F21A
        bra.w        DrawActorAnimation                            ; $01F21E

loc_01F222:
        move.l       #GunnerSpriteBank, ActorSpriteBank(a0)        ; $01F222
        move.w       #$3, d0                                       ; $01F22A
        bra.w        loc_01F844                                    ; $01F22E
        ifne *-$1F232
        fail "ROM end moved"
        endif
