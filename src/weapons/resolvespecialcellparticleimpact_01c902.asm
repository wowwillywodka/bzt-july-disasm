; $01C902..$01C983 | m68k
; Maintained assembly input; no extraction occurs during build.
; Class-1 player cell for Flamethrower/Snowman: sound $38, routed player
; distance hit (or inventory-slot effect), then the same short explosion.
        ifne *-$1C902
        fail "ROM start moved"
        endif

ResolveSpecialCellParticleImpact:
        clr.w        rStatusSoundScriptActive(a6)                                    ; $01C902
        clr.w        rSoundEffectCooldown(a6)                                    ; $01C906
        move.w       #$38, d0                                      ; $01C90A
        move.l       a0, -(a7)                                     ; $01C90E
        jsr          RouteSoundEventByActorFloor.l                         ; $01C910
        movea.l      (a7)+, a0                                     ; $01C916
        move.w       #$1e, rSoundEffectCooldown(a6)                              ; $01C918
        move.l       a0, -(a7)                                     ; $01C91E
        move.w       rPlayerHitImpulseX(a6), -(a7)                             ; $01C920
        move.w       rPlayerHitImpulseY(a6), -(a7)                             ; $01C924
        move.w       ActorX(a0), d0                                ; $01C928
        move.w       ActorY(a0), d1                                ; $01C92C
        sub.w        rPlayerX(a6), d0                              ; $01C930
        sub.w        rPlayerY(a6), d1                              ; $01C934
        move.w       d0, d3                                        ; $01C938
        move.w       d1, d4                                        ; $01C93A
        jsr          OctagonalDistance.l                           ; $01C93C
; Route through inventory-slot drain or forced HP-damage mode.
        jsr          ResolvePlayerHitOrConsumeAlternateSlot.l                            ; $01C942
        move.w       (a7)+, rPlayerHitImpulseY(a6)                             ; $01C948
        move.w       (a7)+, rPlayerHitImpulseX(a6)                             ; $01C94C
        movea.l      (a7)+, a0                                     ; $01C950
; Discard the computed player impulse, then turn the actor into an explosion.
        move.l       #DrawProjectileExplosion, ActorDrawCallback(a0) ; $01C952
        move.l       #UpdateProjectileExplosion, ActorUpdateCallback(a0) ; $01C95A
        move.l       #QueueActorLinkStateCommands10And11, ActorLinkCallback(a0)  ; $01C962
        ori.w        #$ff37, ActorFlags(a0)                        ; $01C96A
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C970
        clr.b        ActorUpdateDelay(a0)                          ; $01C978
; Next explosion update increments 2 to 3, skipping its area-hit tick at 2.
        move.b       #$2, ActorEffectCounter(a0)                   ; $01C97C
        rts                                                        ; $01C982
        ifne *-$1C984
        fail "ROM end moved"
        endif
