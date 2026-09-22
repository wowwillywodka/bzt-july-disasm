; $01C3E8..$01C46B | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1C3E8
        fail "ROM start moved"
        endif

LoadActorDefinition:
; A0=existing actor, A1=main ROM definition ($26 bytes); this is not a full slot reset.
        clr.b        ActorState(a0)                                ; $01C3E8
        clr.b        ActorStateCounter(a0)                         ; $01C3EC
        clr.b        ActorUpdateDelay(a0)                          ; $01C3F0
        move.l       (a1), ActorUpdateCallback(a0)                 ; $01C3F4
        move.l       ActorDefDraw(a1), ActorDrawCallback(a0)       ; $01C3F8
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $01C3FE
        move.l       ActorDefExit(a1), ActorExitCallback(a0)       ; $01C404
        move.w       ActorDefFlags(a1), d0                         ; $01C40A
        ori.w        #$1, d0                                       ; $01C40E
        move.w       d0, ActorFlags(a0)                            ; $01C412
        move.w       ActorDefHealth(a1), ActorHealth(a0)           ; $01C416
        move.w       ActorDefZ(a1), ActorZ(a0)                     ; $01C41C
        move.w       ActorX(a0), ActorGoalX(a0)                    ; $01C422
        move.w       ActorY(a0), ActorGoalY(a0)                    ; $01C428
        move.w       ActorX(a0), ActorPreviousX(a0)                ; $01C42E
        move.w       ActorY(a0), ActorPreviousY(a0)                ; $01C434
        clr.w        ActorMotionX(a0)                              ; $01C43A
        clr.w        ActorMotionY(a0)                              ; $01C43E
        clr.b        ActorState(a0)                                ; $01C442
        move.b       #$14, ActorStateCounter(a0)                   ; $01C446
        clr.b        ActorUnknown45(a0)                            ; $01C44C
        move.l       ActorDefSpriteBank(a1), ActorSpriteBank(a0)   ; $01C450
        move.b       ActorDefExitCellProfile(a1), ActorExitCellProfile(a0) ; $01C456
        move.b       ActorDefCorpseCellProfile(a1), ActorCorpseCellProfile(a0) ; $01C45C
        move.l       #ramPlayerActorProxy, ActorTarget(a0)         ; $01C462
        rts                                                        ; $01C46A
        ifne *-$1C46C
        fail "ROM end moved"
        endif
