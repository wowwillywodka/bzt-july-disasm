; $01EE24..$01EE9D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Эмиттер draw-команд актёра: строит пакеты опкодов $10/$10/$11 в буфере -$6fdc(a6) из полей объекта (id $42, X/Y $24/$26, sub-state $29, тип $22/$39) и шлёт в кольцевую очередь jmp $1ffcc
        ifne *-$1EE24
        fail "ROM start moved"
        endif

ActorsRoutine_01EE24:
        lea.l        -$6fdc(a6), a1                                ; $01EE24
        move.b       #$10, (a1)+                                   ; $01EE28
        move.b       ActorLinkId(a0), (a1)+                        ; $01EE2C
        move.w       ActorX(a0), (a1)+                             ; $01EE30
        move.w       ActorY(a0), (a1)+                             ; $01EE34
        move.b       ActorZLow(a0), (a1)+                          ; $01EE38
        move.b       ActorEffectCounter(a0), (a1)+                 ; $01EE3C
        move.b       #$3, (a1)+                                    ; $01EE40
        lea.l        -$6fdc(a6), a0                                ; $01EE44
        jmp          QueueLinkCommand.l                            ; $01EE48
        lea.l        -$6fdc(a6), a1                                ; $01EE4E
        move.b       #$10, (a1)+                                   ; $01EE52
        move.b       ActorLinkId(a0), (a1)+                        ; $01EE56
        move.w       ActorX(a0), (a1)+                             ; $01EE5A
        move.w       ActorY(a0), (a1)+                             ; $01EE5E
        move.b       ActorZLow(a0), (a1)+                          ; $01EE62
        move.b       ActorStateCounter(a0), (a1)+                  ; $01EE66
        move.b       #$8, (a1)+                                    ; $01EE6A
        lea.l        -$6fdc(a6), a0                                ; $01EE6E
        jmp          QueueLinkCommand.l                            ; $01EE72
        lea.l        -$6fdc(a6), a1                                ; $01EE78
        move.b       #$11, (a1)+                                   ; $01EE7C
        move.b       ActorLinkId(a0), (a1)+                        ; $01EE80
        move.w       ActorX(a0), (a1)+                             ; $01EE84
        move.w       ActorY(a0), (a1)+                             ; $01EE88
        move.b       ActorEffectCounter(a0), (a1)+                 ; $01EE8C
        move.b       #$5, (a1)+                                    ; $01EE90
        lea.l        -$6fdc(a6), a0                                ; $01EE94
        jmp          QueueLinkCommand.l                            ; $01EE98
        ifne *-$1EE9E
        fail "ROM end moved"
        endif
