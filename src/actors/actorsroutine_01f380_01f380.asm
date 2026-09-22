; $01F380..$01F3AD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обработчик отрисовки актёра (анимскрипт $1e1910): $d-пакет с X/Y и вектором, выбор кадра по $38/$39, постинг в $1ffcc, ветки LOS/направления $1f982/$1f844
        ifne *-$1F380
        fail "ROM start moved"
        endif

ActorsRoutine_01F380:
        lea.l        -$6fdc(a6), a0                                ; $01F380
        jmp          QueueLinkCommand.l                            ; $01F384

loc_01F38A:
        move.l       #GreenDummySpriteBank, ActorSpriteBank(a0)    ; $01F38A
        move.w       #$0, d0                                       ; $01F392
        move.w       #$ffff, d2                                    ; $01F396
        bra.w        DrawActorAnimation                            ; $01F39A

loc_01F39E:
        move.l       #GreenDummySpriteBank, ActorSpriteBank(a0)    ; $01F39E
        move.w       #$2, d0                                       ; $01F3A6
        bra.w        loc_01F844                                    ; $01F3AA
        ifne *-$1F3AE
        fail "ROM end moved"
        endif
