; $017D36..$017D6B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active attack events after retained exit branch. Clears motion; at5 LOS then allocation, sounds at4/3, at0 choose new goal immediately. LOS rejection also reselects.
        ifne *-$17D36
        fail "ROM start moved"
        endif

DispatchBlueDummyAttackEvent:
; Active attack events after retained exit branch. Clears motion; at5 LOS then allocation, sounds at4/3, at0 choose new goal immediately. LOS rejection also reselects.
        clr.w        ActorMotionX(a0)                              ; $017D36
        clr.w        ActorMotionY(a0)                              ; $017D3A
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $017D3E
        beq.b        TrySpawnBlueDummyProjectile                   ; $017D44
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $017D46
        beq.b        loc_017D58                                    ; $017D4C
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $017D4E
        beq.b        loc_017D58                                    ; $017D54
        rts                                                        ; $017D56

loc_017D58:
        move.w       #$5f, d0                                      ; $017D58
        jsr          RouteSoundEventByActorFloor.l                         ; $017D5C
        move.w       #$83, d0                                      ; $017D62
        jmp          RouteSoundEventByActorFloor.l                         ; $017D66
        ifne *-$17D6C
        fail "ROM end moved"
        endif
