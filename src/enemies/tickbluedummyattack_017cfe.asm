; $017CFE..$017D31 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Decrement BYTE counter; 0 on entry wraps255. Reaching0 enters state1/counter10; movement caller immediately ticks it to9.
        ifne *-$17CFE
        fail "ROM start moved"
        endif

TickBlueDummyAttack:
; Decrement BYTE counter; 0 on entry wraps255. Reaching0 enters state1/counter10; movement caller immediately ticks it to9.
        cmpi.b       #$1, ActorState(a0)                           ; $017CFE
        beq.b        BlueDummyAttackCountdown                      ; $017D04
        subq.b       #$1, ActorStateCounter(a0)                    ; $017D06
        beq.b        loc_017D0E                                    ; $017D0A
        rts                                                        ; $017D0C

loc_017D0E:
        move.b       #$1, ActorState(a0)                           ; $017D0E
        move.b       #$a, ActorStateCounter(a0)                    ; $017D14
        rts                                                        ; $017D1A

BlueDummyAttackCountdown:
        subq.b       #$1, ActorStateCounter(a0)                    ; $017D1C
        bne.b        DispatchBlueDummyAttackEvent                  ; $017D20
        move.b       #$5, ActorStateCounter(a0)                    ; $017D22

loc_017D28:
        move.b       #$0, ActorState(a0)                           ; $017D28
        jmp          ChooseBlueDummyGoalOrDie(pc)                  ; $017D2E
        ifne *-$17D32
        fail "ROM end moved"
        endif
