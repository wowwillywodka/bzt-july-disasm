; $018F10..$018F43 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Movement decrements counter, zero ->state1/counter10 and immediate tick9. Zero-on-entry wraps255. Completion/rejected LOS chooses next40-tick delay.
        ifne *-$18F10
        fail "ROM start moved"
        endif

TickLarvaCreatureAttack:
; Movement decrements counter, zero ->state1/counter10 and immediate tick9. Zero-on-entry wraps255. Completion/rejected LOS chooses next40-tick delay.
        cmpi.b       #$1, ActorState(a0)                           ; $018F10
        beq.b        LarvaCreatureAttackCountdown                  ; $018F16
        subq.b       #$1, ActorStateCounter(a0)                    ; $018F18
        beq.b        loc_018F20                                    ; $018F1C
        rts                                                        ; $018F1E

loc_018F20:
        move.b       #$1, ActorState(a0)                           ; $018F20
        move.b       #$a, ActorStateCounter(a0)                    ; $018F26
        rts                                                        ; $018F2C

LarvaCreatureAttackCountdown:
        subq.b       #$1, ActorStateCounter(a0)                    ; $018F2E
        bne.b        DispatchLarvaCreatureAttackEvent              ; $018F32
        move.b       #$5, ActorStateCounter(a0)                    ; $018F34

loc_018F3A:
        move.b       #$0, ActorState(a0)                           ; $018F3A
        jmp          ChooseLarvaCreatureGoalOrDie(pc)              ; $018F40
        ifne *-$18F44
        fail "ROM end moved"
        endif
