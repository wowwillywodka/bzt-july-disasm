; $01F2C2..$01F2EF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обработчик отрисовки актёра (анимскрипт $1c4576): $d-пакет с X/Y и вектором $2e/$30, выбор кадра по $38/$39, постинг в $1ffcc, ветки LOS/направления $1f982/$1f844
        ifne *-$1F2C2
        fail "ROM start moved"
        endif

ActorsRoutine_01F2C2:
        lea.l        -$6fdc(a6), a0                                ; $01F2C2
        jmp          QueueLinkCommand.l                            ; $01F2C6

loc_01F2CC:
        move.l       #GreyDummySpriteBank, ActorSpriteBank(a0)     ; $01F2CC
        move.w       #$0, d0                                       ; $01F2D4
        move.w       #$ffff, d2                                    ; $01F2D8
        bra.w        DrawActorAnimation                            ; $01F2DC

loc_01F2E0:
        move.l       #GreyDummySpriteBank, ActorSpriteBank(a0)     ; $01F2E0
        move.w       #$2, d0                                       ; $01F2E8
        bra.w        loc_01F844                                    ; $01F2EC
        ifne *-$1F2F0
        fail "ROM end moved"
        endif
