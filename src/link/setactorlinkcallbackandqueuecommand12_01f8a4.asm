; $01F8A4..$01F8CF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Installs QueueActorLinkCommand0F as the actor's link callback, then emits
; link command $12 containing actor ID, flags OR $20, and floor.
        ifne *-$1F8A4
        fail "ROM start moved"
        endif

SetActorLinkCallbackAndQueueCommand12:
        move.l       #QueueActorLinkCommand0F, ActorLinkCallback(a0) ; $01F8A4
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01F8AC
        move.b       #$12, (a1)+                                   ; $01F8B0
        move.b       ActorLinkId(a0), (a1)+                        ; $01F8B4
        move.w       ActorFlags(a0), d0                            ; $01F8B8
        ori.w        #$20, d0                                      ; $01F8BC
        move.b       d0, (a1)+                                     ; $01F8C0
        move.b       ActorFloor(a0), (a1)+                         ; $01F8C2
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01F8C6
        jmp          QueueLinkCommand.l                            ; $01F8CA
        ifne *-$1F8D0
        fail "ROM end moved"
        endif
