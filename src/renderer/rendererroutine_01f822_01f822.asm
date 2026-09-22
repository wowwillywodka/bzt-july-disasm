; $01F822..$01F855 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка пакета отрисовки тип $0f (поля объекта x/y 0x24/0x26, id 0x42, флаг $23) в командную очередь jsr 0x1ffcc; +хвост 0x1f844: D2=паритет по биту 0 байта 0x39 для выбора зеркала кадра
        ifne *-$1F822
        fail "ROM start moved"
        endif

RendererRoutine_01F822:
        lea.l        -$6fdc(a6), a1                                ; $01F822
        move.b       #$f, (a1)+                                    ; $01F826
        move.b       ActorLinkId(a0), (a1)+                        ; $01F82A
        move.w       ActorX(a0), (a1)+                             ; $01F82E
        move.w       ActorY(a0), (a1)+                             ; $01F832
        move.b       #$23, (a1)+                                   ; $01F836
        lea.l        -$6fdc(a6), a0                                ; $01F83A
        jmp          QueueLinkCommand.l                            ; $01F83E

loc_01F844:
        clr.w        d2                                            ; $01F844
        btst.b       #$0, ActorStateCounter(a0)                    ; $01F846
        beq.w        DrawActorAnimation                            ; $01F84C
        addq.w       #$1, d2                                       ; $01F850
        bra.w        DrawActorAnimation                            ; $01F852
        ifne *-$1F856
        fail "ROM end moved"
        endif
