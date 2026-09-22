; $01EDB4..$01EE23 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка позиционного события/SFX в очередь GEMS: пакует в буфер (-0x6fdc,A6) код события (0xe или 0xf), id объекта (0x42,A0), координаты (0x24/0x26,A0) и параметр, затем jmp 0x1ffcc (диспетчер очереди)
        ifne *-$1EDB4
        fail "ROM start moved"
        endif

SoundRoutine_01EDB4:
        lea.l        -$6fdc(a6), a1                                ; $01EDB4
        move.b       #$e, (a1)+                                    ; $01EDB8
        move.b       ActorLinkId(a0), (a1)+                        ; $01EDBC
        move.w       ActorX(a0), (a1)+                             ; $01EDC0
        move.w       ActorY(a0), (a1)+                             ; $01EDC4
        move.b       ActorZLow(a0), (a1)+                          ; $01EDC8
        move.b       #$0, (a1)+                                    ; $01EDCC
        lea.l        -$6fdc(a6), a0                                ; $01EDD0
        jmp          QueueLinkCommand.l                            ; $01EDD4
        lea.l        -$6fdc(a6), a1                                ; $01EDDA
        move.b       #$f, (a1)+                                    ; $01EDDE
        move.b       ActorLinkId(a0), (a1)+                        ; $01EDE2
        move.w       ActorX(a0), (a1)+                             ; $01EDE6
        move.w       ActorY(a0), (a1)+                             ; $01EDEA
        move.b       #$1, (a1)+                                    ; $01EDEE
        lea.l        -$6fdc(a6), a0                                ; $01EDF2
        jmp          QueueLinkCommand.l                            ; $01EDF6
        rts                                                        ; $01EDFC
        lea.l        -$6fdc(a6), a1                                ; $01EDFE
        move.b       #$e, (a1)+                                    ; $01EE02
        move.b       ActorLinkId(a0), (a1)+                        ; $01EE06
        move.w       ActorX(a0), (a1)+                             ; $01EE0A
        move.w       ActorY(a0), (a1)+                             ; $01EE0E
        move.b       ActorZLow(a0), (a1)+                          ; $01EE12
        move.b       #$4, (a1)+                                    ; $01EE16
        lea.l        -$6fdc(a6), a0                                ; $01EE1A
        jmp          QueueLinkCommand.l                            ; $01EE1E
        ifne *-$1EE24
        fail "ROM end moved"
        endif
