; $0192A2..$01930B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$192A2
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_0192A2:
        move.b       ActorStateCounter(a0), d7                     ; $0192A2
        cmpi.b       #$5, d7                                       ; $0192A6
        beq.b        loc_0192C6                                    ; $0192AA
        cmpi.b       #$4, d7                                       ; $0192AC
        beq.b        loc_0192D4                                    ; $0192B0
        cmpi.b       #$3, d7                                       ; $0192B2
        beq.b        loc_0192E2                                    ; $0192B6
        cmpi.b       #$2, d7                                       ; $0192B8
        beq.b        loc_0192F0                                    ; $0192BC
        cmpi.b       #$1, d7                                       ; $0192BE
        beq.b        loc_0192FE                                    ; $0192C2
        rts                                                        ; $0192C4

loc_0192C6:
        move.w       #$5, d0                                       ; $0192C6
        move.w       #$1, d2                                       ; $0192CA
        jmp          DrawActorAnimation.l                          ; $0192CE

loc_0192D4:
        move.w       #$5, d0                                       ; $0192D4
        move.w       #$2, d2                                       ; $0192D8
        jmp          DrawActorAnimation.l                          ; $0192DC

loc_0192E2:
        move.w       #$5, d0                                       ; $0192E2
        move.w       #$3, d2                                       ; $0192E6
        jmp          DrawActorAnimation.l                          ; $0192EA

loc_0192F0:
        move.w       #$5, d0                                       ; $0192F0
        move.w       #$4, d2                                       ; $0192F4
        jmp          DrawActorAnimation.l                          ; $0192F8

loc_0192FE:
        move.w       #$5, d0                                       ; $0192FE
        move.w       #$5, d2                                       ; $019302
        jmp          DrawActorAnimation.l                          ; $019306
        ifne *-$1930C
        fail "ROM end moved"
        endif
