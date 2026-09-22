; $01C984..$01C9C5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shared projectile draw: active zone tile16 decimal (+$2000), scale D5/4, no horizontal mirror; Blue Dummy uses this callback. Simulation/explosion internals remain separate.
        ifne *-$1C984
        fail "ROM start moved"
        endif

DrawGunrockProjectileTile:
; Shared projectile draw: active zone tile16 decimal (+$2000), scale D5/4, no horizontal mirror; Blue Dummy uses this callback. Simulation/explosion internals remain separate.
        move.w       d5, -$6f26(a6)                                ; $01C984
        move.w       d5, d2                                        ; $01C988
        move.w       -$71d8(a6), d3                                ; $01C98A
        sub.w        -$6e4c(a6), d3                                ; $01C98E
        sub.w        ActorZ(a0), d3                                ; $01C992
        muls.w       d3, d2                                        ; $01C996
        asr.l        #$6, d2                                       ; $01C998
        addi.w       #$28, d2                                      ; $01C99A
        movea.l      rZoneObjectTiles(a6), a1                      ; $01C99E
        adda.w       #ObjectTileOffset16_GunrockPickup, a1         ; $01C9A2
        move.w       d5, d0                                        ; $01C9A6
        asr.w        #$2, d0                                       ; $01C9A8
        move.w       d0, d4                                        ; $01C9AA
        asr.w        #$1, d4                                       ; $01C9AC
        sub.w        d4, d2                                        ; $01C9AE
        move.w       d4, d3                                        ; $01C9B0
        asr.w        #$1, d3                                       ; $01C9B2
        sub.w        d3, d1                                        ; $01C9B4
        clr.w        -$6f32(a6)                                    ; $01C9B6
        move.l       a0, -(a7)                                     ; $01C9BA
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01C9BC
        movea.l      (a7)+, a0                                     ; $01C9C2
        rts                                                        ; $01C9C4
        ifne *-$1C9C6
        fail "ROM end moved"
        endif
