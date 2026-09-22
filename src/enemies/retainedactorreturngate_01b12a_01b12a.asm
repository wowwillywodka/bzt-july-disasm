; $01B12A..$01B135 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1B12A
        fail "ROM start moved"
        endif

RetainedActorReturnGate_01B12A:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $01B12A
        beq.w        RetainedGunnerFinalCorpseAndArmExit           ; $01B130
        rts                                                        ; $01B134
        ifne *-$1B136
        fail "ROM end moved"
        endif
