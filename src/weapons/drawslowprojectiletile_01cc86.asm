; $01CC86..$01CCCF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shared slow-projectile draw: active zone tile01 (+$200), scale D5/2, tick parity mirror. Larva Creature and player weapon share the callback.
        ifne *-$1CC86
        fail "ROM start moved"
        endif

DrawSlowProjectileTile:
; Shared slow-projectile draw: active zone tile01 (+$200), scale D5/2, tick parity mirror. Larva Creature and player weapon share the callback.
        move.w       d5, -$6f26(a6)                                ; $01CC86
        move.w       d5, d2                                        ; $01CC8A
        move.w       -$71d8(a6), d3                                ; $01CC8C
        sub.w        -$6e4c(a6), d3                                ; $01CC90
        sub.w        ActorZ(a0), d3                                ; $01CC94
        muls.w       d3, d2                                        ; $01CC98
        asr.l        #$6, d2                                       ; $01CC9A
        addi.w       #$28, d2                                      ; $01CC9C
        movea.l      rZoneObjectTiles(a6), a1                      ; $01CCA0
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01CCA4
        move.w       rGameTick(a6), d0                             ; $01CCA8
        andi.w       #$1, d0                                       ; $01CCAC
        move.w       d0, -$6f32(a6)                                ; $01CCB0
        move.w       d5, d0                                        ; $01CCB4
        asr.w        #$1, d0                                       ; $01CCB6
        move.w       d0, d4                                        ; $01CCB8
        asr.w        #$1, d4                                       ; $01CCBA
        sub.w        d4, d2                                        ; $01CCBC
        move.w       d4, d3                                        ; $01CCBE
        asr.w        #$1, d3                                       ; $01CCC0
        sub.w        d3, d1                                        ; $01CCC2
        move.l       a0, -(a7)                                     ; $01CCC4
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01CCC6
        movea.l      (a7)+, a0                                     ; $01CCCC
        rts                                                        ; $01CCCE
        ifne *-$1CCD0
        fail "ROM end moved"
        endif
