; $01DEE4..$01DF39 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1DEE4
        fail "ROM start moved"
        endif

DrawProximityWallChargeTile:
; Draw callback for the map-spawned wall charge; uses scene object tiles 19/20.
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $01DEE4
        move.w       d5, d2                                        ; $01DEE8
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $01DEEA
        sub.w        rTransitHeightOffset(a6), d3                                ; $01DEEE
        subi.w       #$20, d3                                      ; $01DEF2
        muls.w       d3, d2                                        ; $01DEF6
        asr.l        #$6, d2                                       ; $01DEF8
        addi.w       #$28, d2                                      ; $01DEFA
        move.w       d5, d0                                        ; $01DEFE
        asr.w        #$1, d0                                       ; $01DF00
        move.w       d0, d3                                        ; $01DF02
        asr.w        #$2, d3                                       ; $01DF04
        sub.w        d3, d0                                        ; $01DF06
        move.w       d0, d4                                        ; $01DF08
        asr.w        #$1, d4                                       ; $01DF0A
        move.w       d4, d3                                        ; $01DF0C
        asr.w        #$1, d3                                       ; $01DF0E
        sub.w        d3, d1                                        ; $01DF10
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $01DF12
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DF16
        adda.w       #ObjectTileOffset19_Cell26Frame0, a1          ; $01DF1A
        btst.b       #$1, rGameTickLow(a6)                               ; $01DF1E
        bne.b        loc_01DF2C                                    ; $01DF24
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DF26

loc_01DF2C:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DF2C
        adda.w       #ObjectTileOffset20_Cell26Frame1, a1          ; $01DF30
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DF34
        ifne *-$1DF3A
        fail "ROM end moved"
        endif
