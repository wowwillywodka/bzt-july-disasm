; $01CD1C..$01CD71 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Zone FireEffect tile01; size=(2*D5)>>ExplosionScaleShifts[EffectCounter], shifts1,0,1,2,3,4. Tick-parity mirror. Drawing does not advance life; no table index guard.
        ifne *-$1CD1C
        fail "ROM start moved"
        endif

DrawProjectileExplosion:
; Zone FireEffect tile01; size=(2*D5)>>ExplosionScaleShifts[EffectCounter], shifts1,0,1,2,3,4. Tick-parity mirror. Drawing does not advance life; no table index guard.
        move.w       d5, -$6f26(a6)                                ; $01CD1C
        move.w       d5, d2                                        ; $01CD20
        move.w       -$71d8(a6), d3                                ; $01CD22
        sub.w        -$6e4c(a6), d3                                ; $01CD26
        sub.w        ActorZ(a0), d3                                ; $01CD2A
        muls.w       d3, d2                                        ; $01CD2E
        asr.l        #$6, d2                                       ; $01CD30
        addi.w       #$28, d2                                      ; $01CD32
        movea.l      rZoneObjectTiles(a6), a1                      ; $01CD36
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01CD3A
        move.w       rGameTick(a6), d0                             ; $01CD3E
        andi.w       #$1, d0                                       ; $01CD42
        move.w       d0, -$6f32(a6)                                ; $01CD46
        clr.w        d0                                            ; $01CD4A
        move.b       ActorEffectCounter(a0), d0                    ; $01CD4C
        move.b       ExplosionScaleShifts(pc, d0.w), d4            ; $01CD50
        move.w       d5, d0                                        ; $01CD54
        add.w        d5, d0                                        ; $01CD56
        asr.w        d4, d0                                        ; $01CD58
        move.w       d0, d4                                        ; $01CD5A
        asr.w        #$1, d4                                       ; $01CD5C
        sub.w        d4, d2                                        ; $01CD5E
        move.w       d4, d3                                        ; $01CD60
        asr.w        #$1, d3                                       ; $01CD62
        sub.w        d3, d1                                        ; $01CD64
        move.l       a0, -(a7)                                     ; $01CD66
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01CD68
        movea.l      (a7)+, a0                                     ; $01CD6E
        rts                                                        ; $01CD70
        ifne *-$1CD72
        fail "ROM end moved"
        endif
