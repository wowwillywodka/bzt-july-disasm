; $01C46C..$01C4EF | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1C46C
        fail "ROM start moved"
        endif

LoadActorDeathDefinition:
; A0=existing actor, A1=death ROM definition ($1A bytes); sets Z=-32, does not read definition+$1A.
        clr.b        ActorState(a0)                                ; $01C46C
        clr.b        ActorStateCounter(a0)                         ; $01C470
        clr.b        ActorUpdateDelay(a0)                          ; $01C474
        move.l       (a1), ActorUpdateCallback(a0)                 ; $01C478
        move.l       ActorDefDraw(a1), ActorDrawCallback(a0)       ; $01C47C
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $01C482
        move.l       ActorDefExit(a1), ActorExitCallback(a0)       ; $01C488
        move.w       ActorDefFlags(a1), d0                         ; $01C48E
        ori.w        #$1, d0                                       ; $01C492
        move.w       d0, ActorFlags(a0)                            ; $01C496
        move.w       ActorDefHealth(a1), ActorHealth(a0)           ; $01C49A
        move.w       #$ffe0, ActorZ(a0)                            ; $01C4A0
        move.w       ActorX(a0), ActorGoalX(a0)                    ; $01C4A6
        move.w       ActorY(a0), ActorGoalY(a0)                    ; $01C4AC
        move.w       ActorX(a0), ActorPreviousX(a0)                ; $01C4B2
        move.w       ActorY(a0), ActorPreviousY(a0)                ; $01C4B8
        clr.w        ActorMotionX(a0)                              ; $01C4BE
        clr.w        ActorMotionY(a0)                              ; $01C4C2
        clr.b        ActorState(a0)                                ; $01C4C6
        move.b       #$14, ActorStateCounter(a0)                   ; $01C4CA
        clr.b        ActorUnknown45(a0)                            ; $01C4D0
        move.l       ActorDefSpriteBank(a1), ActorSpriteBank(a0)   ; $01C4D4
        move.b       ActorDefExitCellProfile(a1), ActorExitCellProfile(a0) ; $01C4DA
        move.b       ActorDefCorpseCellProfile(a1), ActorCorpseCellProfile(a0) ; $01C4E0
        move.l       #ramPlayerActorProxy, ActorTarget(a0)         ; $01C4E6
        rts                                                        ; $01C4EE
        ifne *-$1C4F0
        fail "ROM end moved"
        endif
