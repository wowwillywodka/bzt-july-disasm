; $00968E..$0096CB | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$968E
        fail "ROM start moved"
        endif

SendActorSpawnCommand:
        movem.l      d0-d7/a0-a3, -(a7)                            ; $00968E
        lea.l        rSharedScratchBuffer(a6), a1                                ; $009692
        move.b       #$4, (a1)+                                    ; $009696
        move.b       ActorLinkId(a0), (a1)+                        ; $00969A
        move.w       ActorX(a0), (a1)+                             ; $00969E
        move.w       ActorY(a0), (a1)+                             ; $0096A2
        move.b       ActorZLow(a0), (a1)+                          ; $0096A6
        move.b       #$fc, (a1)+                                   ; $0096AA
        move.b       rCurrentFloorLow(a6), (a1)+                   ; $0096AE
        move.b       d0, (a1)+                                     ; $0096B2
        move.w       ActorMotionX(a0), (a1)+                       ; $0096B4
        move.w       ActorMotionY(a0), (a1)+                       ; $0096B8
        lea.l        rSharedScratchBuffer(a6), a0                                ; $0096BC
        jsr          QueueLinkCommand.l                            ; $0096C0
        movem.l      (a7)+, d0-d7/a0-a3                            ; $0096C6
        rts                                                        ; $0096CA
        ifne *-$96CC
        fail "ROM end moved"
        endif
