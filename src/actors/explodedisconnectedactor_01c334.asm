; $01C334..$01C339 | m68k
; Maintained assembly input; no extraction occurs during build.
; Remote kind $00: tail-call the projectile explosion path.
        ifne *-$1C334
        fail "ROM start moved"
        endif

ExplodeDisconnectedActor:
        jmp          StartProjectileExplosionAndWallStages.l       ; $01C334
        ifne *-$1C33A
        fail "ROM end moved"
        endif
