; $01A3BE..$01A3F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Attack10 immediately ticks9 on transition. Hit5, sounds4/3. Counter0 and failed LOS reselect goal immediately, overwriting temporary counter5 with RNG and resetting state0.
        ifne *-$1A3BE
        fail "ROM start moved"
        endif

TickWhiteDummyAttack:
; Attack10 immediately ticks9 on transition. Hit5, sounds4/3. Counter0 and failed LOS reselect goal immediately, overwriting temporary counter5 with RNG and resetting state0.
        cmpi.b       #$1, ActorState(a0)                           ; $01A3BE
        beq.b        loc_01A3DC                                    ; $01A3C4
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A3C6
        beq.b        loc_01A3CE                                    ; $01A3CA
        rts                                                        ; $01A3CC

loc_01A3CE:
        move.b       #$1, ActorState(a0)                           ; $01A3CE
        move.b       #$a, ActorStateCounter(a0)                    ; $01A3D4
        rts                                                        ; $01A3DA

loc_01A3DC:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A3DC
        bne.b        DispatchWhiteDummyAttackEvent                 ; $01A3E0
        move.b       #$5, ActorStateCounter(a0)                    ; $01A3E2
        move.b       #$0, ActorState(a0)                           ; $01A3E8
        jmp          ChooseWhiteDummyGoalOrDie(pc)                 ; $01A3EE
        ifne *-$1A3F2
        fail "ROM end moved"
        endif
