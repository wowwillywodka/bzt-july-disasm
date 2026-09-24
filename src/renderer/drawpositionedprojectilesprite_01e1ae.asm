; $01E1AE..$01E1F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Растеризация позиционированного спрайта снаряда/эффекта: из координат и угла объ(0x28/0x42,A0) считает масштабный сдвиг (muls/asr.l #6), берёт слот спрайт-буфера (-0x42bc,A6)+0x200, готовит D1/D2/D4 и jsr 0xf8bc (блиттер-масштабатор)
        ifne *-$1E1AE
        fail "ROM start moved"
        endif

DrawPositionedProjectileSprite:
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $01E1AE
        move.w       d5, d2                                        ; $01E1B2
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $01E1B4
        sub.w        rTransitHeightOffset(a6), d3                                ; $01E1B8
        sub.w        ActorZ(a0), d3                                ; $01E1BC
        muls.w       d3, d2                                        ; $01E1C0
        asr.l        #$6, d2                                       ; $01E1C2
        addi.w       #$28, d2                                      ; $01E1C4
        movea.l      rZoneObjectTiles(a6), a1                      ; $01E1C8
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01E1CC
        move.w       rGameTick(a6), d0                             ; $01E1D0
        add.b        ActorLinkId(a0), d0                           ; $01E1D4
        andi.w       #$1, d0                                       ; $01E1D8
        move.w       d0, rSoftwareSpriteMirrorFlag(a6)                                ; $01E1DC
        move.w       d5, d0                                        ; $01E1E0
        asr.w        #$2, d0                                       ; $01E1E2
        move.w       d0, d4                                        ; $01E1E4
        asr.w        #$1, d4                                       ; $01E1E6
        sub.w        d4, d2                                        ; $01E1E8
        move.w       d4, d3                                        ; $01E1EA
        asr.w        #$1, d3                                       ; $01E1EC
        sub.w        d3, d1                                        ; $01E1EE
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01E1F0
        ifne *-$1E1F6
        fail "ROM end moved"
        endif
