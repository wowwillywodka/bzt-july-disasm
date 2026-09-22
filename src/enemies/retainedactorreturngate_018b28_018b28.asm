; $018B28..$018B35 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$18B28
        fail "ROM start moved"
        endif

RetainedActorReturnGate_018B28:
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $018B28
        beq.w        loc_018B34                                    ; $018B2E
        rts                                                        ; $018B32

loc_018B34:
        rts                                                        ; $018B34
        ifne *-$18B36
        fail "ROM end moved"
        endif
