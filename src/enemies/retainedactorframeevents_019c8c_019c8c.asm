; $019C8C..$019CF5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$19C8C
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_019C8C:
        move.b       ActorStateCounter(a0), d7                     ; $019C8C
        cmpi.b       #$5, d7                                       ; $019C90
        beq.b        loc_019CB0                                    ; $019C94
        cmpi.b       #$4, d7                                       ; $019C96
        beq.b        loc_019CBE                                    ; $019C9A
        cmpi.b       #$3, d7                                       ; $019C9C
        beq.b        loc_019CCC                                    ; $019CA0
        cmpi.b       #$2, d7                                       ; $019CA2
        beq.b        loc_019CDA                                    ; $019CA6
        cmpi.b       #$1, d7                                       ; $019CA8
        beq.b        loc_019CE8                                    ; $019CAC
        rts                                                        ; $019CAE

loc_019CB0:
        move.w       #$5, d0                                       ; $019CB0
        move.w       #$1, d2                                       ; $019CB4
        jmp          DrawActorAnimation.l                          ; $019CB8

loc_019CBE:
        move.w       #$5, d0                                       ; $019CBE
        move.w       #$2, d2                                       ; $019CC2
        jmp          DrawActorAnimation.l                          ; $019CC6

loc_019CCC:
        move.w       #$5, d0                                       ; $019CCC
        move.w       #$3, d2                                       ; $019CD0
        jmp          DrawActorAnimation.l                          ; $019CD4

loc_019CDA:
        move.w       #$5, d0                                       ; $019CDA
        move.w       #$4, d2                                       ; $019CDE
        jmp          DrawActorAnimation.l                          ; $019CE2

loc_019CE8:
        move.w       #$5, d0                                       ; $019CE8
        move.w       #$5, d2                                       ; $019CEC
        jmp          DrawActorAnimation.l                          ; $019CF0
        ifne *-$19CF6
        fail "ROM end moved"
        endif
