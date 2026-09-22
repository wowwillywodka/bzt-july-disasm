; $01AC6A..$01AC9D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Same 10->9 attack start, hit5 and sounds4/3. Completion and failed LOS immediately choose a new goal and random1..15 move counter.
        ifne *-$1AC6A
        fail "ROM start moved"
        endif

TickGunnerAttack:
; Same 10->9 attack start, hit5 and sounds4/3. Completion and failed LOS immediately choose a new goal and random1..15 move counter.
        cmpi.b       #$1, ActorState(a0)                           ; $01AC6A
        beq.b        loc_01AC88                                    ; $01AC70
        subq.b       #$1, ActorStateCounter(a0)                    ; $01AC72
        beq.b        loc_01AC7A                                    ; $01AC76
        rts                                                        ; $01AC78

loc_01AC7A:
        move.b       #$1, ActorState(a0)                           ; $01AC7A
        move.b       #$a, ActorStateCounter(a0)                    ; $01AC80
        rts                                                        ; $01AC86

loc_01AC88:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01AC88
        bne.b        DispatchGunnerAttackEvent                     ; $01AC8C
        move.b       #$5, ActorStateCounter(a0)                    ; $01AC8E
        move.b       #$0, ActorState(a0)                           ; $01AC94
        jmp          ChooseGunnerGoalOrDie(pc)                     ; $01AC9A
        ifne *-$1AC9E
        fail "ROM end moved"
        endif
