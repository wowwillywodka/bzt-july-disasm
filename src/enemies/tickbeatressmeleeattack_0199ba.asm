; $0199BA..$0199E9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Attack state1/counter7, caller immediately ticks6. Sounds4/3, hit2, completion chooses new goal. Existing state1 does NOT recheck range/flag/LOS.
        ifne *-$199BA
        fail "ROM start moved"
        endif

TickBeatressMeleeAttack:
; Attack state1/counter7, caller immediately ticks6. Sounds4/3, hit2, completion chooses new goal. Existing state1 does NOT recheck range/flag/LOS.
        cmpi.b       #$1, ActorState(a0)                           ; $0199BA
        beq.b        loc_0199D4                                    ; $0199C0
        bra.b        BeatressBeginMeleeAttack                      ; $0199C2

loc_0199C4:
        rts                                                        ; $0199C4

BeatressBeginMeleeAttack:
        move.b       #$1, ActorState(a0)                           ; $0199C6
        move.b       #$7, ActorStateCounter(a0)                    ; $0199CC
        rts                                                        ; $0199D2

loc_0199D4:
        subq.b       #$1, ActorStateCounter(a0)                    ; $0199D4
        bne.b        DispatchBeatressMeleeEvent                    ; $0199D8
        move.b       #$5, ActorStateCounter(a0)                    ; $0199DA
        move.b       #$0, ActorState(a0)                           ; $0199E0
        jmp          ChooseBeatressGoalOrDie(pc)                   ; $0199E6
        ifne *-$199EA
        fail "ROM end moved"
        endif
