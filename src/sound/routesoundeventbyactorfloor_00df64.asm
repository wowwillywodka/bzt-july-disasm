; $00DF64..$00DF83 | m68k
; Maintained assembly input; no extraction occurs during build.
; D0=event ID, A0=actor. Play locally only on current floor. If link is
; active, also send command $08 when this actor and the FIRST pool slot
; have the same floor. The second comparison is literal July ROM behavior.
        ifne *-$DF64
        fail "ROM start moved"
        endif

RouteSoundEventByActorFloor:
        move.w       d1, -(a7)                                     ; $00DF64
        move.b       ActorFloor(a0), d1                             ; $00DF66
        cmp.b        rCurrentFloorLow(a6), d1                      ; $00DF6A
        bne.b        loc_00DF72                                    ; $00DF6E
        bsr.b        DispatchSoundEventWithIrqMask                           ; $00DF70

loc_00DF72:
        tst.w        rLinkRole(a6)                                 ; $00DF72
        beq.b        loc_00DF80                                    ; $00DF76
        cmp.b        rActorPool+ActorFloor(a6), d1                 ; $00DF78
        bne.b        loc_00DF80                                    ; $00DF7C
        bsr.b        QueueSoundEventLinkCommand                           ; $00DF7E

loc_00DF80:
        move.w       (a7)+, d1                                     ; $00DF80
        rts                                                        ; $00DF82
        ifne *-$DF84
        fail "ROM end moved"
        endif
