; $018098..$018101 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$18098
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_018098:
        move.b       ActorStateCounter(a0), d7                     ; $018098
        cmpi.b       #$5, d7                                       ; $01809C
        beq.b        loc_0180BC                                    ; $0180A0
        cmpi.b       #$4, d7                                       ; $0180A2
        beq.b        loc_0180CA                                    ; $0180A6
        cmpi.b       #$3, d7                                       ; $0180A8
        beq.b        loc_0180D8                                    ; $0180AC
        cmpi.b       #$2, d7                                       ; $0180AE
        beq.b        loc_0180E6                                    ; $0180B2
        cmpi.b       #$1, d7                                       ; $0180B4
        beq.b        loc_0180F4                                    ; $0180B8
        rts                                                        ; $0180BA

loc_0180BC:
        move.w       #$4, d0                                       ; $0180BC
        move.w       #$1, d2                                       ; $0180C0
        jmp          DrawActorAnimation.l                          ; $0180C4

loc_0180CA:
        move.w       #$4, d0                                       ; $0180CA
        move.w       #$2, d2                                       ; $0180CE
        jmp          DrawActorAnimation.l                          ; $0180D2

loc_0180D8:
        move.w       #$4, d0                                       ; $0180D8
        move.w       #$3, d2                                       ; $0180DC
        jmp          DrawActorAnimation.l                          ; $0180E0

loc_0180E6:
        move.w       #$4, d0                                       ; $0180E6
        move.w       #$4, d2                                       ; $0180EA
        jmp          DrawActorAnimation.l                          ; $0180EE

loc_0180F4:
        move.w       #$4, d0                                       ; $0180F4
        move.w       #$5, d2                                       ; $0180F8
        jmp          DrawActorAnimation.l                          ; $0180FC
        ifne *-$18102
        fail "ROM end moved"
        endif
