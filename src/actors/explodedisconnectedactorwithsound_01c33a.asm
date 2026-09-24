; $01C33A..$01C35B | m68k
; Maintained assembly input; no extraction occurs during build.
; Remote kind $01: sound $0E, cooldown $1E, then explode.
        ifne *-$1C33A
        fail "ROM start moved"
        endif

ExplodeDisconnectedActorWithSound:
        clr.w        rStatusSoundScriptActive(a6)                                    ; $01C33A
        clr.w        rSoundEffectCooldown(a6)                                    ; $01C33E
        move.w       #$e, d0                                       ; $01C342
        move.l       a0, -(a7)                                     ; $01C346
        jsr          RouteSoundEventByActorFloor.l                         ; $01C348
        movea.l      (a7)+, a0                                     ; $01C34E
        move.w       #$1e, rSoundEffectCooldown(a6)                              ; $01C350
        jmp          StartProjectileExplosionAndWallStages.l       ; $01C356
        ifne *-$1C35C
        fail "ROM end moved"
        endif
