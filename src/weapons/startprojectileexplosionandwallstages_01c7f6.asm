; $01C7F6..$01C87F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Common explosion setup: sound$18, shake30, callbacks Draw/UpdateProjectileExplosion, hit=RTS, Flags AND$FF37, effect counter0. 5x5 wall-stage activation. Area hit occurs later at counter2, NOT here.
        ifne *-$1C7F6
        fail "ROM start moved"
        endif

StartProjectileExplosionAndWallStages:
; Enter projectile explosion render/update state, sound $18 and shake; activate staged walls in a 5x5 square around actor X/Y. Separate from charge-driven type-6/7 wall opening.
; Common explosion setup: sound$18, shake30, callbacks Draw/UpdateProjectileExplosion, hit=RTS, Flags AND$FF37, effect counter0. 5x5 wall-stage activation. Area hit occurs later at counter2, NOT here.
        clr.w        rStatusSoundScriptActive(a6)                                    ; $01C7F6
        clr.w        rSoundEffectCooldown(a6)                                    ; $01C7FA
        move.w       #$18, d0                                      ; $01C7FE
        move.l       a0, -(a7)                                     ; $01C802
        jsr          RouteSoundEventByActorFloor.l                         ; $01C804
        movea.l      (a7)+, a0                                     ; $01C80A
        move.w       #$1e, rSoundEffectCooldown(a6)                              ; $01C80C

loc_01C812:
        move.l       #DrawProjectileExplosion, ActorDrawCallback(a0) ; $01C812
        move.l       #UpdateProjectileExplosion, ActorUpdateCallback(a0) ; $01C81A
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C822
        andi.w       #$ff37, ActorFlags(a0)                        ; $01C82A
        clr.b        ActorUpdateDelay(a0)                          ; $01C830
        clr.b        ActorEffectCounter(a0)                        ; $01C834
        tst.w        rLinkRole(a6)                                 ; $01C838
        beq.b        loc_01C86E                                    ; $01C83C
        move.l       a0, -(a7)                                     ; $01C83E
        move.l       #QueueActorLinkStateCommands10And11, ActorLinkCallback(a0)  ; $01C840
        lea.l        rSharedScratchBuffer(a6), a1                                ; $01C848
        move.b       #$12, (a1)+                                   ; $01C84C
        move.b       ActorLinkId(a0), (a1)+                        ; $01C850
        move.w       ActorFlags(a0), d0                            ; $01C854
        ori.w        #$20, d0                                      ; $01C858
        move.b       d0, (a1)+                                     ; $01C85C
        move.b       ActorFloor(a0), (a1)+                         ; $01C85E
        lea.l        rSharedScratchBuffer(a6), a0                                ; $01C862
        jsr          QueueLinkCommand.l                            ; $01C866
        movea.l      (a7)+, a0                                     ; $01C86C

loc_01C86E:
        move.w       #$2, d0                                       ; $01C86E
        move.w       ActorX(a0), d1                                ; $01C872
        move.w       ActorY(a0), d2                                ; $01C876
        bsr.w        ActivateEpisode1WallStages                    ; $01C87A
        rts                                                        ; $01C87E
        ifne *-$1C880
        fail "ROM end moved"
        endif
