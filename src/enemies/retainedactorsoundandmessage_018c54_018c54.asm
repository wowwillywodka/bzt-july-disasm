; $018C54..$018C6F | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained local pickup completion behind RTS $18C52; no item grant precedes it. Remote branch at $18C70 is live and separately named.
        ifne *-$18C54
        fail "ROM start moved"
        endif

RetainedActorSoundAndMessage_018C54:
; Retained local pickup completion behind RTS $18C52; no item grant precedes it. Remote branch at $18C70 is live and separately named.
        move.b       #$4, ActorState(a0)                           ; $018C54
        move.w       #$60, d0                                      ; $018C5A
        jsr          SoundRoutine_00DF64.l                         ; $018C5E
        movea.l      #StatusMessageBuligunCollected, a0            ; $018C64
        jmp          QueueStatusMessage.l                          ; $018C6A
        ifne *-$18C70
        fail "ROM end moved"
        endif
