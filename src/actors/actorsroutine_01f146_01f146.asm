; $01F146..$01F173 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Общий хвост постинга draw-пакета актёра: lea -$6fdc(a6),a0; jmp $1ffcc — отправляет уже собранный $d-пакет в очередь рендера. Цель множества bra.b $1f146 из диспетчера кадров выше (@0x1f0b6+)
        ifne *-$1F146
        fail "ROM start moved"
        endif

ActorsRoutine_01F146:
        lea.l        -$6fdc(a6), a0                                ; $01F146
        jmp          QueueLinkCommand.l                            ; $01F14A

loc_01F150:
        move.l       #StananSpriteBank, ActorSpriteBank(a0)        ; $01F150
        move.w       #$0, d0                                       ; $01F158
        move.w       #$ffff, d2                                    ; $01F15C
        bra.w        DrawActorAnimation                            ; $01F160

loc_01F164:
        move.l       #StananSpriteBank, ActorSpriteBank(a0)        ; $01F164
        move.w       #$4, d0                                       ; $01F16C
        bra.w        loc_01F844                                    ; $01F170
        ifne *-$1F174
        fail "ROM end moved"
        endif
