; $01EF46..$01EFCF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1EF46
        fail "ROM start moved"
        endif

RetainedSendActorCommand0E:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EF46
        move.b       #$e, (a1)+                                    ; $01EF4A
        move.b       ActorLinkId(a0), (a1)+                        ; $01EF4E
        move.w       ActorX(a0), (a1)+                             ; $01EF52
        move.w       ActorY(a0), (a1)+                             ; $01EF56
        move.b       ActorZLow(a0), (a1)+                          ; $01EF5A
        move.b       #$6, (a1)+                                    ; $01EF5E
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EF62
        jmp          QueueLinkCommand.l                            ; $01EF66
        move.b       #$e, d0                                       ; $01EF6C
        bra.b        loc_01EFAC                                    ; $01EF70
        move.b       #$10, d0                                      ; $01EF72
        bra.b        loc_01EFAC                                    ; $01EF76
        move.b       #$12, d0                                      ; $01EF78
        bra.b        loc_01EFAC                                    ; $01EF7C
        move.b       #$14, d0                                      ; $01EF7E
        bra.b        loc_01EFAC                                    ; $01EF82
        move.b       #$16, d0                                      ; $01EF84
        bra.b        loc_01EFAC                                    ; $01EF88
        move.b       #$18, d0                                      ; $01EF8A
        bra.b        loc_01EFAC                                    ; $01EF8E
        move.b       #$1a, d0                                      ; $01EF90
        bra.b        loc_01EFAC                                    ; $01EF94
        move.b       #$1c, d0                                      ; $01EF96
        bra.b        loc_01EFAC                                    ; $01EF9A
        move.b       #$1e, d0                                      ; $01EF9C
        bra.b        loc_01EFAC                                    ; $01EFA0
        move.b       #$20, d0                                      ; $01EFA2
        bra.b        loc_01EFAC                                    ; $01EFA6
        move.b       #$22, d0                                      ; $01EFA8

loc_01EFAC:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01EFAC
        move.b       #$11, (a1)+                                   ; $01EFB0
        move.b       ActorLinkId(a0), (a1)+                        ; $01EFB4
        move.w       ActorX(a0), (a1)+                             ; $01EFB8
        move.w       ActorY(a0), (a1)+                             ; $01EFBC
        move.b       ActorStateCounter(a0), (a1)+                  ; $01EFC0
        move.b       d0, (a1)+                                     ; $01EFC4
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01EFC6
        jmp          QueueLinkCommand.l                            ; $01EFCA
        ifne *-$1EFD0
        fail "ROM end moved"
        endif
