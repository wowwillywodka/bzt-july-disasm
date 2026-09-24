; $01C4F0..$01C4F9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Unsigned D0<$200 starts common explosion immediately; equality or larger returns. Shared by Blue/Larva projectiles and other player weapon actors.
        ifne *-$1C4F0
        fail "ROM start moved"
        endif

ExplodeProjectileOnNearHit:
; Unsigned D0<$200 starts common explosion immediately; equality or larger returns. Shared by Blue/Larva projectiles and other player weapon actors.
; Projectile hit callback: D0 is an unsigned proximity parameter, not HP damage.
        cmpi.w       #$200, d0                                     ; $01C4F0
        bcs.w        StartProjectileExplosionAndWallStages         ; $01C4F4
        rts                                                        ; $01C4F8
        ifne *-$1C4FA
        fail "ROM end moved"
        endif
