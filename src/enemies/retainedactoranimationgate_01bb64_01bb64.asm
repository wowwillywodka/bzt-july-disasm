; $01BB64..$01BB7D | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1BB64
        fail "ROM start moved"
        endif

RetainedActorAnimationGate_01BB64:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $01BB64
        beq.w        loc_01BB70                                    ; $01BB6A
        rts                                                        ; $01BB6E

loc_01BB70:
        move.w       #$1, d0                                       ; $01BB70
        move.w       #$3, d2                                       ; $01BB74
        jmp          DrawActorAnimation.l                          ; $01BB78
        ifne *-$1BB7E
        fail "ROM end moved"
        endif
