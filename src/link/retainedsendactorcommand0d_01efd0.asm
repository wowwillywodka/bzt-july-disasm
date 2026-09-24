; $01EFD0..$01EFF7 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1EFD0
        fail "ROM start moved"
        endif

RetainedSendActorCommand0D:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EFD0
        move.b       #$d, (a1)+                                    ; $01EFD4
        move.b       ActorLinkId(a0), (a1)+                        ; $01EFD8
        move.w       ActorX(a0), (a1)+                             ; $01EFDC
        move.w       ActorY(a0), (a1)+                             ; $01EFE0
        move.w       ActorMotionX(a0), (a1)+                       ; $01EFE4
        move.w       ActorMotionY(a0), (a1)+                       ; $01EFE8
        move.b       d0, (a1)+                                     ; $01EFEC
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EFEE
        jmp          QueueLinkCommand.l                            ; $01EFF2
        ifne *-$1EFF8
        fail "ROM end moved"
        endif
