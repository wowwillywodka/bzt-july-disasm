; $01DF66..$01DFB5 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1DF66
        fail "ROM start moved"
        endif

DrawWallChargeHitFire:
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $01DF66
        move.w       d5, d2                                        ; $01DF6A
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $01DF6C
        sub.w        rTransitHeightOffset(a6), d3                                ; $01DF70
        sub.w        ActorZ(a0), d3                                ; $01DF74
        muls.w       d3, d2                                        ; $01DF78
        asr.l        #$6, d2                                       ; $01DF7A
        addi.w       #$28, d2                                      ; $01DF7C
        clr.w        d0                                            ; $01DF80
        move.b       ActorStateCounter(a0), d0                     ; $01DF82
        asr.w        #$1, d0                                       ; $01DF86
        move.b       ActorLocalFacingRemap(pc, d0.w), d0           ; $01DF88
        asr.w        d0, d5                                        ; $01DF8C
        move.w       d5, d0                                        ; $01DF8E
        move.w       d0, d4                                        ; $01DF90
        asr.w        #$1, d4                                       ; $01DF92
        sub.w        d4, d2                                        ; $01DF94
        move.w       d4, d3                                        ; $01DF96
        asr.w        #$1, d3                                       ; $01DF98
        sub.w        d3, d1                                        ; $01DF9A
        move.w       rGameTick(a6), d3                             ; $01DF9C
        andi.w       #$1, d3                                       ; $01DFA0
        move.w       d3, rSoftwareSpriteMirrorFlag(a6)                                ; $01DFA4
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DFA8
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01DFAC
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DFB0
        ifne *-$1DFB6
        fail "ROM end moved"
        endif
