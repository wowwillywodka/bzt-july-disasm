; $019470..$0194BF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Выбор реакции врага на столкновение: clr 0x23, диспетчер по байту контакта 0x3e (0xCB/0xCC/0xC9/0xC8/0xCE/0xCA) — ставит 0x3e=0xCC либо проваливается в обработчик тарана 0x194d6
        ifne *-$19470
        fail "ROM start moved"
        endif

UpdateLarvaCreatureCorpse:
        clr.b        ActorUpdateDelay(a0)                          ; $019470
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $019474
        beq.w        loc_0194B8                                    ; $01947A
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01947E
        beq.w        WaitLarvaCreatureCorpseDrawing                ; $019484
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019488
        beq.w        loc_0194B4                                    ; $01948E
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019492
        beq.w        loc_0194B4                                    ; $019498
        cmpi.b       #$ce, ActorDeathMode(a0)                      ; $01949C
        beq.w        loc_0194B4                                    ; $0194A2
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $0194A6
        beq.w        MoveLarvaCreatureCorpseAndTryPickup           ; $0194AC
        bra.w        MoveLarvaCreatureCorpseAndTryPickup           ; $0194B0

loc_0194B4:
        bra.w        MoveLarvaCreatureCorpseAndTryPickup           ; $0194B4

loc_0194B8:
        move.b       #$cc, ActorDeathMode(a0)                      ; $0194B8
        rts                                                        ; $0194BE
        ifne *-$194C0
        fail "ROM end moved"
        endif
