; $01F080..$01F0B5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Хвост отрисовки актёра: задаёт d0=2/d2=3 кадр, постит пакет в очередь $1ffcc; далее ставит анимскрипт ($164820→$46(a0)) и зовёт LOS/направление $1f982/$1f844
        ifne *-$1F080
        fail "ROM start moved"
        endif

ActorsRoutine_01F080:
        move.w       #$2, d0                                       ; $01F080
        move.w       #$3, d2                                       ; $01F084

loc_01F088:
        lea.l        -$6fdc(a6), a0                                ; $01F088
        jmp          QueueLinkCommand.l                            ; $01F08C

loc_01F092:
        move.l       #BloodBodySpriteBank, ActorSpriteBank(a0)     ; $01F092
        move.w       #$0, d0                                       ; $01F09A
        move.w       #$ffff, d2                                    ; $01F09E
        bra.w        DrawActorAnimation                            ; $01F0A2

loc_01F0A6:
        move.l       #BloodBodySpriteBank, ActorSpriteBank(a0)     ; $01F0A6
        move.w       #$4, d0                                       ; $01F0AE
        bra.w        loc_01F844                                    ; $01F0B2
        ifne *-$1F0B6
        fail "ROM end moved"
        endif
