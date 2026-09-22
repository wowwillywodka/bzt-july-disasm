; $01A7FE..$01A817 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1A7FE
        fail "ROM start moved"
        endif

RetainedActorAnimationGate_01A7FE:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $01A7FE
        beq.w        loc_01A80A                                    ; $01A804
        rts                                                        ; $01A808

loc_01A80A:
        move.w       #$4, d0                                       ; $01A80A
        move.w       #$3, d2                                       ; $01A80E
        jmp          DrawActorAnimation.l                          ; $01A812
        ifne *-$1A818
        fail "ROM end moved"
        endif
