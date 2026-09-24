; $01EE9E..$01EF45 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; Four independent ActorLinkCallback entries. Each sends command $10 with
; actor ID, XY, Z and a state/counter byte followed by remote kind $C/9/A/B.
; The tail jumps to QueueLinkCommand, not to the local renderer.
        ifne *-$1EE9E
        fail "ROM start moved"
        endif

QueueActorLinkCommand10Variants:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EE9E
        move.b       #$10, (a1)+                                   ; $01EEA2
        move.b       ActorLinkId(a0), (a1)+                        ; $01EEA6
        move.w       ActorX(a0), (a1)+                             ; $01EEAA
        move.w       ActorY(a0), (a1)+                             ; $01EEAE
        move.b       ActorZLow(a0), (a1)+                          ; $01EEB2
        move.b       ActorState(a0), (a1)+                         ; $01EEB6
        move.b       #$c, (a1)+                                    ; $01EEBA
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EEBE
        jmp          QueueLinkCommand.l                            ; $01EEC2
QueueActorLinkCommand10StateCounter09:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EEC8
        move.b       #$10, (a1)+                                   ; $01EECC
        move.b       ActorLinkId(a0), (a1)+                        ; $01EED0
        move.w       ActorX(a0), (a1)+                             ; $01EED4
        move.w       ActorY(a0), (a1)+                             ; $01EED8
        move.b       ActorZLow(a0), (a1)+                          ; $01EEDC
        move.b       ActorStateCounter(a0), (a1)+                  ; $01EEE0
        move.b       #$9, (a1)+                                    ; $01EEE4
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EEE8
        jmp          QueueLinkCommand.l                            ; $01EEEC
QueueActorLinkCommand10StateCounter0A:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EEF2
        move.b       #$10, (a1)+                                   ; $01EEF6
        move.b       ActorLinkId(a0), (a1)+                        ; $01EEFA
        move.w       ActorX(a0), (a1)+                             ; $01EEFE
        move.w       ActorY(a0), (a1)+                             ; $01EF02
        move.b       ActorZLow(a0), (a1)+                          ; $01EF06
        move.b       ActorStateCounter(a0), (a1)+                  ; $01EF0A
        move.b       #$a, (a1)+                                    ; $01EF0E
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EF12
        jmp          QueueLinkCommand.l                            ; $01EF16
QueueActorLinkCommand10StateCounter0B:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EF1C
        move.b       #$10, (a1)+                                   ; $01EF20
        move.b       ActorLinkId(a0), (a1)+                        ; $01EF24
        move.w       ActorX(a0), (a1)+                             ; $01EF28
        move.w       ActorY(a0), (a1)+                             ; $01EF2C
        move.b       ActorZLow(a0), (a1)+                          ; $01EF30
        move.b       ActorStateCounter(a0), (a1)+                  ; $01EF34
        move.b       #$b, (a1)+                                    ; $01EF38
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EF3C
        jmp          QueueLinkCommand.l                            ; $01EF40
        ifne *-$1EF46
        fail "ROM end moved"
        endif
