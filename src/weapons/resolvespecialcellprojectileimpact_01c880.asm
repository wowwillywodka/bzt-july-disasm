; $01C880..$01C901 | m68k
; Maintained assembly input; no extraction occurs during build.
; Class-1 player cell: sound $18, direct distance hit, then a short explosion.
; Saves/restores player impulse; actor starts the explosion at effect count 2.
        ifne *-$1C880
        fail "ROM start moved"
        endif

ResolveSpecialCellProjectileImpact:
        clr.w        rStatusSoundScriptActive(a6)                                    ; $01C880
        clr.w        rSoundEffectCooldown(a6)                                    ; $01C884
        move.w       #$18, d0                                      ; $01C888
        move.l       a0, -(a7)                                     ; $01C88C
        jsr          RouteSoundEventByActorFloor.l                         ; $01C88E
        movea.l      (a7)+, a0                                     ; $01C894
        move.w       #$1e, rSoundEffectCooldown(a6)                              ; $01C896
        move.l       a0, -(a7)                                     ; $01C89C
        move.w       rPlayerHitImpulseX(a6), -(a7)                             ; $01C89E
        move.w       rPlayerHitImpulseY(a6), -(a7)                             ; $01C8A2
        move.w       ActorX(a0), d0                                ; $01C8A6
        move.w       ActorY(a0), d1                                ; $01C8AA
        sub.w        rPlayerX(a6), d0                              ; $01C8AE
        sub.w        rPlayerY(a6), d1                              ; $01C8B2
        move.w       d0, d3                                        ; $01C8B6
        move.w       d1, d4                                        ; $01C8B8
        jsr          OctagonalDistance.l                           ; $01C8BA
; Direct distance hit: HP depends on the receiver's signed mode word.
        jsr          ApplyPlayerDistanceHit.l                      ; $01C8C0
        move.w       (a7)+, rPlayerHitImpulseY(a6)                             ; $01C8C6
        move.w       (a7)+, rPlayerHitImpulseX(a6)                             ; $01C8CA
        movea.l      (a7)+, a0                                     ; $01C8CE
; Discard the computed player impulse, then turn the actor into an explosion.
        move.l       #DrawProjectileExplosion, ActorDrawCallback(a0) ; $01C8D0
        move.l       #UpdateProjectileExplosion, ActorUpdateCallback(a0) ; $01C8D8
        move.l       #QueueActorLinkStateCommands10And11, ActorLinkCallback(a0)  ; $01C8E0
        ori.w        #$ff37, ActorFlags(a0)                        ; $01C8E8
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C8EE
        clr.b        ActorUpdateDelay(a0)                          ; $01C8F6
; Next explosion update increments 2 to 3, skipping its area-hit tick at 2.
        move.b       #$2, ActorEffectCounter(a0)                   ; $01C8FA
        rts                                                        ; $01C900
        ifne *-$1C902
        fail "ROM end moved"
        endif
