; $01898A..$0189F3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1898A
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_01898A:
        move.b       ActorStateCounter(a0), d7                     ; $01898A
        cmpi.b       #$5, d7                                       ; $01898E
        beq.b        loc_0189AE                                    ; $018992
        cmpi.b       #$4, d7                                       ; $018994
        beq.b        loc_0189BC                                    ; $018998
        cmpi.b       #$3, d7                                       ; $01899A
        beq.b        loc_0189CA                                    ; $01899E
        cmpi.b       #$2, d7                                       ; $0189A0
        beq.b        loc_0189D8                                    ; $0189A4
        cmpi.b       #$1, d7                                       ; $0189A6
        beq.b        loc_0189E6                                    ; $0189AA
        rts                                                        ; $0189AC

loc_0189AE:
        move.w       #$5, d0                                       ; $0189AE
        move.w       #$1, d2                                       ; $0189B2
        jmp          DrawActorAnimation.l                          ; $0189B6

loc_0189BC:
        move.w       #$5, d0                                       ; $0189BC
        move.w       #$2, d2                                       ; $0189C0
        jmp          DrawActorAnimation.l                          ; $0189C4

loc_0189CA:
        move.w       #$5, d0                                       ; $0189CA
        move.w       #$3, d2                                       ; $0189CE
        jmp          DrawActorAnimation.l                          ; $0189D2

loc_0189D8:
        move.w       #$5, d0                                       ; $0189D8
        move.w       #$4, d2                                       ; $0189DC
        jmp          DrawActorAnimation.l                          ; $0189E0

loc_0189E6:
        move.w       #$5, d0                                       ; $0189E6
        move.w       #$5, d2                                       ; $0189EA
        jmp          DrawActorAnimation.l                          ; $0189EE
        ifne *-$189F4
        fail "ROM end moved"
        endif
