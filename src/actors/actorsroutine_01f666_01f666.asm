; $01F666..$01F6A5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Аниматор спрайт-сета $1fecaa: блок кадров D0=1,D2=2/3, разбор ориентации/направления актёра и прыжок в аниматор кадра 0x1f982 с графикой (0x46,A0)
        ifne *-$1F666
        fail "ROM start moved"
        endif

ActorsRoutine_01F666:
        move.w       #$1, d0                                       ; $01F666
        move.w       #$2, d2                                       ; $01F66A
        bra.b        loc_01F678                                    ; $01F66E

loc_01F670:
        move.w       #$1, d0                                       ; $01F670
        move.w       #$3, d2                                       ; $01F674

loc_01F678:
        lea.l        -$6fdc(a6), a0                                ; $01F678
        jmp          QueueLinkCommand.l                            ; $01F67C

loc_01F682:
        move.l       #BeatressSpriteBank, ActorSpriteBank(a0)      ; $01F682
        move.w       #$0, d0                                       ; $01F68A
        move.w       #$ffff, d2                                    ; $01F68E
        bra.w        DrawActorAnimation                            ; $01F692

loc_01F696:
        move.l       #BeatressSpriteBank, ActorSpriteBank(a0)      ; $01F696
        move.w       #$2, d0                                       ; $01F69E
        bra.w        loc_01F844                                    ; $01F6A2
        ifne *-$1F6A6
        fail "ROM end moved"
        endif
