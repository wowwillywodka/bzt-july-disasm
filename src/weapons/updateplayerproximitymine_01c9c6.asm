; $01C9C6..$01CAC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Mine: refresh nearest candidate every21 updates via timer byte22; proximity distance<$100 explodes. Character1 immunity is checked only for local/remote player candidates. See local bounds in docs/PLAYER_WEAPONS.md.
        ifne *-$1C9C6
        fail "ROM start moved"
        endif

UpdatePlayerProximityMine:
; Mine: refresh nearest candidate every21 updates via timer byte22; proximity distance<$100 explodes. Character1 immunity is checked only for local/remote player candidates. See local bounds in docs/PLAYER_WEAPONS.md.
        clr.b        ActorUpdateDelay(a0)                          ; $01C9C6
        subq.b       #$1, ActorEffectCounter(a0)                   ; $01C9CA
        bpl.b        loc_01C9E6                                    ; $01C9CE
        move.b       #$14, ActorEffectCounter(a0)                  ; $01C9D0
        move.w       #$10, d5                                      ; $01C9D6
        bsr.w        EnemiesRoutine_01E4FA                         ; $01C9DA
        move.l       a1, ActorTarget(a0)                           ; $01C9DE
        bmi.w        RemoveActorAndSendLink                        ; $01C9E2

loc_01C9E6:
        movea.l      ActorTarget(a0), a1                           ; $01C9E6
        cmpa.l       #$ffffffff, a1                                ; $01C9EA
        beq.b        loc_01CA2C                                    ; $01C9F0
        cmpa.l       #$0, a1                                       ; $01C9F2
        beq.b        loc_01CA2E                                    ; $01C9F8
        cmpa.l       #$ff11e2, a1                                  ; $01C9FA
        beq.b        loc_01CA56                                    ; $01CA00
        move.w       ActorFlags(a0), d0                            ; $01CA02
        andi.w       #$1, d0                                       ; $01CA06
        beq.w        RemoveActorAndSendLink                        ; $01CA0A
        move.w       ActorX(a0), d0                                ; $01CA0E
        sub.w        $24(a1), d0                                   ; $01CA12
        move.w       ActorY(a0), d1                                ; $01CA16
        sub.w        $26(a1), d1                                   ; $01CA1A
        jsr          OctagonalDistance.l                           ; $01CA1E
        cmpi.w       #$100, d0                                     ; $01CA24
        bcs.w        StartProjectileExplosionAndWallStages         ; $01CA28

loc_01CA2C:
        rts                                                        ; $01CA2C

loc_01CA2E:
        cmpi.w       #$1, rSelectedCharacter(a6)                   ; $01CA2E
        beq.b        loc_01CA2C                                    ; $01CA34
        move.w       ActorX(a0), d0                                ; $01CA36
        sub.w        rPlayerX(a6), d0                              ; $01CA3A
        move.w       ActorY(a0), d1                                ; $01CA3E
        sub.w        rPlayerY(a6), d1                              ; $01CA42
        jsr          OctagonalDistance.l                           ; $01CA46
        cmpi.w       #$100, d0                                     ; $01CA4C
        bcs.w        StartProjectileExplosionAndWallStages         ; $01CA50
        rts                                                        ; $01CA54

loc_01CA56:
        cmpi.w       #$1, rSelectedCharacter(a6)                   ; $01CA56
        beq.b        loc_01CA2C                                    ; $01CA5C
        move.w       ActorX(a0), d0                                ; $01CA5E
        sub.w        $24(a1), d0                                   ; $01CA62
        move.w       ActorY(a0), d1                                ; $01CA66
        sub.w        $26(a1), d1                                   ; $01CA6A
        jsr          OctagonalDistance.l                           ; $01CA6E
        cmpi.w       #$100, d0                                     ; $01CA74
        bcs.w        StartProjectileExplosionAndWallStages         ; $01CA78
        rts                                                        ; $01CA7C

loc_01CA7E:
        move.w       d5, -$6f26(a6)                                ; $01CA7E
        move.w       d5, d2                                        ; $01CA82
        move.w       -$71d8(a6), d3                                ; $01CA84
        sub.w        -$6e4c(a6), d3                                ; $01CA88
        sub.w        ActorZ(a0), d3                                ; $01CA8C
        muls.w       d3, d2                                        ; $01CA90
        asr.l        #$6, d2                                       ; $01CA92
        addi.w       #$28, d2                                      ; $01CA94
        clr.w        -$6f32(a6)                                    ; $01CA98
        movea.l      rZoneObjectTiles(a6), a1                      ; $01CA9C
        adda.w       #ObjectTileOffset08_MineFrame0, a1            ; $01CAA0
        btst.b       #$1, -$711f(a6)                               ; $01CAA4
        beq.b        loc_01CAB0                                    ; $01CAAA
        adda.w       #ObjectTileBytes, a1                          ; $01CAAC

loc_01CAB0:
        move.w       d5, d0                                        ; $01CAB0
        asr.w        #$2, d0                                       ; $01CAB2
        sub.w        d0, d2                                        ; $01CAB4
        move.w       d0, d4                                        ; $01CAB6
        move.w       d4, d3                                        ; $01CAB8
        asr.w        #$1, d3                                       ; $01CABA
        sub.w        d3, d1                                        ; $01CABC
        move.l       a0, -(a7)                                     ; $01CABE
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01CAC0
        movea.l      (a7)+, a0                                     ; $01CAC6
        rts                                                        ; $01CAC8
        ifne *-$1CACA
        fail "ROM end moved"
        endif
