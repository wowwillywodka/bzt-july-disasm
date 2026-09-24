; $01DC32..$01DC7D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Impact reader: tile 63 + signed_word(((2 - state) & $FF) << 9)/512. Nominal state 3..0 selects 62,63,64,65; no native bounds clamp.
        ifne *-$1DC32
        fail "ROM start moved"
        endif

DrawImpactObjectTile:
; Impact reader: tile 63 + signed_word(((2 - state) & $FF) << 9)/512. Nominal state 3..0 selects 62,63,64,65; no native bounds clamp.
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $01DC32
        move.w       d5, d2                                        ; $01DC36
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $01DC38
        sub.w        rTransitHeightOffset(a6), d3                                ; $01DC3C
        sub.w        ActorZ(a0), d3                                ; $01DC40
        muls.w       d3, d2                                        ; $01DC44
        asr.l        #$6, d2                                       ; $01DC46
        addi.w       #$28, d2                                      ; $01DC48
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DC4C
        adda.w       #ObjectTileOffset63_ImpactFrame0, a1          ; $01DC50
        move.w       #$2, d0                                       ; $01DC54
        sub.b        ActorState(a0), d0                            ; $01DC58
        beq.b        loc_01DC64                                    ; $01DC5C
        lsl.w        #$8, d0                                       ; $01DC5E
        lsl.w        #$1, d0                                       ; $01DC60
        adda.w       d0, a1                                        ; $01DC62

loc_01DC64:
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $01DC64
        move.w       d5, d0                                        ; $01DC68
        asr.w        #$2, d0                                       ; $01DC6A
        move.w       d0, d4                                        ; $01DC6C
        asr.w        #$1, d4                                       ; $01DC6E
        sub.w        d4, d2                                        ; $01DC70
        move.w       d4, d3                                        ; $01DC72
        asr.w        #$1, d3                                       ; $01DC74
        sub.w        d3, d1                                        ; $01DC76
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DC78
        ifne *-$1DC7E
        fail "ROM end moved"
        endif
