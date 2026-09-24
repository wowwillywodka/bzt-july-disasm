; $0199EE..$019A1B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; ACTIVE melee events after preceding retained exit branch.
        ifne *-$199EE
        fail "ROM start moved"
        endif

DispatchBeatressMeleeEvent:
; ACTIVE melee events after preceding retained exit branch.
        cmpi.b       #$2, ActorStateCounter(a0)                    ; $0199EE
        beq.b        ApplyBeatressMeleeHit                         ; $0199F4
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $0199F6
        beq.b        loc_019A08                                    ; $0199FC
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $0199FE
        beq.b        loc_019A08                                    ; $019A04
        rts                                                        ; $019A06

loc_019A08:
        move.w       #$5f, d0                                      ; $019A08
        jsr          RouteSoundEventByActorFloor.l                         ; $019A0C
        move.w       #$83, d0                                      ; $019A12
        jmp          RouteSoundEventByActorFloor.l                         ; $019A16
        ifne *-$19A1C
        fail "ROM end moved"
        endif
