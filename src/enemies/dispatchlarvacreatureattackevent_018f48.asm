; $018F48..$018F75 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active attack events after retained exit branch: spawn at5, sounds4/3. Unlike Blue Dummy no motion-word clearing in this tail.
        ifne *-$18F48
        fail "ROM start moved"
        endif

DispatchLarvaCreatureAttackEvent:
; Active attack events after retained exit branch: spawn at5, sounds4/3. Unlike Blue Dummy no motion-word clearing in this tail.
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $018F48
        beq.b        TrySpawnLarvaCreatureProjectile               ; $018F4E
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $018F50
        beq.b        loc_018F62                                    ; $018F56
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $018F58
        beq.b        loc_018F62                                    ; $018F5E
        rts                                                        ; $018F60

loc_018F62:
        move.w       #$5f, d0                                      ; $018F62
        jsr          RouteSoundEventByActorFloor.l                         ; $018F66
        move.w       #$83, d0                                      ; $018F6C
        jmp          RouteSoundEventByActorFloor.l                         ; $018F70
        ifne *-$18F76
        fail "ROM end moved"
        endif
