; $01F822..$01F843 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Entry $01F822 emits link command $0F from actor ID and XY, with kind $23.
; The independent frame-selection tail starts at $01F844.
        ifne *-$1F822
        fail "ROM start moved"
        endif

QueueActorLinkCommand0F:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F822
        move.b       #$f, (a1)+                                    ; $01F826
        move.b       ActorLinkId(a0), (a1)+                        ; $01F82A
        move.w       ActorX(a0), (a1)+                             ; $01F82E
        move.w       ActorY(a0), (a1)+                             ; $01F832
        move.b       #$23, (a1)+                                   ; $01F836
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F83A
        jmp          QueueLinkCommand.l                            ; $01F83E

        ifne *-$1F844
        fail "ROM end moved"
        endif
