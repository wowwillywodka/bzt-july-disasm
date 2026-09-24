; $00DF84..$00DF9D | m68k
; Maintained assembly input; no extraction occurs during build.
; D0=event ID. Local playback always happens. With link active, mirror it
; as command $08 only if the first pool slot's floor equals current floor.
; $FF1270 is ActorFloor of pool slot zero, not a sound-event ID.
        ifne *-$DF84
        fail "ROM start moved"
        endif

PlaySoundEventAndMaybeSendLink:
        tst.w        rLinkRole(a6)                                 ; $00DF84
        beq.b        DispatchSoundEventWithIrqMask                           ; $00DF88
        move.w       d1, -(a7)                                     ; $00DF8A
        move.b       rActorPool+ActorFloor(a6), d1                 ; $00DF8C
        cmp.b        rCurrentFloorLow(a6), d1                      ; $00DF90
        beq.b        loc_00DF9A                                    ; $00DF94
        move.w       (a7)+, d1                                     ; $00DF96
        bra.b        DispatchSoundEventWithIrqMask                           ; $00DF98

loc_00DF9A:
        move.w       (a7)+, d1                                     ; $00DF9A
        bsr.b        DispatchSoundEventWithIrqMask                           ; $00DF9C
; Fall through: queue the same event for the link peer.
        ifne *-$DF9E
        fail "ROM end moved"
        endif
