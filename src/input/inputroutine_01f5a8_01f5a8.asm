; $01F5A8..$01F5E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Линк-кабель: альт-вход постановки события в TX-кольцо — ставит D0=1/D2=2, грузит a0=staging-буфер пакета (-0x6fdc,A6 = $FF1024) и прыгает на энкью TX-ринга 0x1ffcc
        ifne *-$1F5A8
        fail "ROM start moved"
        endif

InputRoutine_01F5A8:
        move.w       #$1, d0                                       ; $01F5A8
        move.w       #$2, d2                                       ; $01F5AC
        bra.b        loc_01F5BA                                    ; $01F5B0

loc_01F5B2:
        move.w       #$1, d0                                       ; $01F5B2
        move.w       #$3, d2                                       ; $01F5B6

loc_01F5BA:
        lea.l        -$6fdc(a6), a0                                ; $01F5BA
        jmp          QueueLinkCommand.l                            ; $01F5BE

loc_01F5C4:
        move.l       #WhiteDummySpriteBank, ActorSpriteBank(a0)    ; $01F5C4
        move.w       #$0, d0                                       ; $01F5CC
        move.w       #$ffff, d2                                    ; $01F5D0
        bra.w        DrawActorAnimation                            ; $01F5D4

loc_01F5D8:
        move.l       #WhiteDummySpriteBank, ActorSpriteBank(a0)    ; $01F5D8
        move.w       #$3, d0                                       ; $01F5E0
        bra.w        loc_01F844                                    ; $01F5E4
        ifne *-$1F5E8
        fail "ROM end moved"
        endif
