; $01EDB4..$01EE23 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Three callback entries package actor ID and position into link commands
; $0E/$0F, then tail-call QueueLinkCommand. No GEMS call occurs here.
        ifne *-$1EDB4
        fail "ROM start moved"
        endif

QueueActorPositionLinkCommand:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EDB4
        move.b       #$e, (a1)+                                    ; $01EDB8
        move.b       ActorLinkId(a0), (a1)+                        ; $01EDBC
        move.w       ActorX(a0), (a1)+                             ; $01EDC0
        move.w       ActorY(a0), (a1)+                             ; $01EDC4
        move.b       ActorZLow(a0), (a1)+                          ; $01EDC8
        move.b       #$0, (a1)+                                    ; $01EDCC
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EDD0
        jmp          QueueLinkCommand.l                            ; $01EDD4
QueueActorPositionLinkCommand0F:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EDDA
        move.b       #$f, (a1)+                                    ; $01EDDE
        move.b       ActorLinkId(a0), (a1)+                        ; $01EDE2
        move.w       ActorX(a0), (a1)+                             ; $01EDE6
        move.w       ActorY(a0), (a1)+                             ; $01EDEA
        move.b       #$1, (a1)+                                    ; $01EDEE
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EDF2
        jmp          QueueLinkCommand.l                            ; $01EDF6
ActorLinkNoOp:
        rts                                                        ; $01EDFC
QueueActorPositionLinkCommand0EFlag04:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EDFE
        move.b       #$e, (a1)+                                    ; $01EE02
        move.b       ActorLinkId(a0), (a1)+                        ; $01EE06
        move.w       ActorX(a0), (a1)+                             ; $01EE0A
        move.w       ActorY(a0), (a1)+                             ; $01EE0E
        move.b       ActorZLow(a0), (a1)+                          ; $01EE12
        move.b       #$4, (a1)+                                    ; $01EE16
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EE1A
        jmp          QueueLinkCommand.l                            ; $01EE1E
        ifne *-$1EE24
        fail "ROM end moved"
        endif
