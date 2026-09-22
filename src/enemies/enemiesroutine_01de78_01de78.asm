; $01DE78..$01DFB5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; ⭐ПРОДЖЕКТАЙЛ-СПАВНЕР July (ВЫСТРЕЛ→ВРАГ; аналог June 0x186b6): снаряд сканирует клетки, спавн-маркер (двойной LUT A5→A4) → 0x9b86. «Стены, что спавнят врагов»: ниша-стены (cell-ID 0xE4-0xFF, метатекстуры 249-255 = враг в нише, кадры материализации; цвет→враг как June: красная→Red Robot, фиолет→Purple Robot) + невидимый маркер рядом — механизм идентичен June
        ifne *-$1DE78
        fail "ROM start moved"
        endif

EnemiesRoutine_01DE78:
        move.w       $26(a2), d0                                   ; $01DE78
        asr.w        #$8, d0                                       ; $01DE7C
        subq.w       #$6, d0                                       ; $01DE7E
        lea.l        -$a5(a0), a1                                  ; $01DE80
        move.w       #$a, d6                                       ; $01DE84

loc_01DE88:
        addq.w       #$1, d0                                       ; $01DE88
        bmi.b        loc_01DEDA                                    ; $01DE8A
        cmpi.w       #$20, d0                                      ; $01DE8C
        bcc.b        loc_01DEE2                                    ; $01DE90
        move.w       $24(a2), d1                                   ; $01DE92
        asr.w        #$8, d1                                       ; $01DE96
        subq.w       #$6, d1                                       ; $01DE98
        move.w       #$a, d7                                       ; $01DE9A

loc_01DE9E:
        addq.w       #$1, d1                                       ; $01DE9E
        bmi.b        loc_01DED0                                    ; $01DEA0
        cmpi.w       #$20, d1                                      ; $01DEA2
        bcc.b        loc_01DED0                                    ; $01DEA6
        move.b       (a1), d3                                      ; $01DEA8
        move.b       (a5, d3.w), d3                                ; $01DEAA
        move.b       (a4, d3.w), d3                                ; $01DEAE
        beq.b        loc_01DED0                                    ; $01DEB2
        movem.w      d1/d5-d6, -(a7)                               ; $01DEB4
        move.w       rCurrentFloor(a6), -(a7)                      ; $01DEB8
        move.b       $36(a2), rCurrentFloorLow(a6)                 ; $01DEBC
        jsr          SelectActorDefinitionFromCell.l               ; $01DEC2
        move.w       (a7)+, rCurrentFloor(a6)                      ; $01DEC8
        movem.w      (a7)+, d1/d5-d6                               ; $01DECC

loc_01DED0:
        addq.w       #$1, a1                                       ; $01DED0
        dbra         d7, loc_01DE9E                                ; $01DED2
        suba.w       #$b, a1                                       ; $01DED6

loc_01DEDA:
        adda.w       #$20, a1                                      ; $01DEDA
        dbra         d6, loc_01DE88                                ; $01DEDE

loc_01DEE2:
        rts                                                        ; $01DEE2

loc_01DEE4:
        move.w       d5, -$6f26(a6)                                ; $01DEE4
        move.w       d5, d2                                        ; $01DEE8
        move.w       -$71d8(a6), d3                                ; $01DEEA
        sub.w        -$6e4c(a6), d3                                ; $01DEEE
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
        clr.w        -$6f32(a6)                                    ; $01DF12
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DF16
        adda.w       #ObjectTileOffset19_Cell26Frame0, a1          ; $01DF1A
        btst.b       #$1, -$711f(a6)                               ; $01DF1E
        bne.b        loc_01DF2C                                    ; $01DF24
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DF26

loc_01DF2C:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DF2C
        adda.w       #ObjectTileOffset20_Cell26Frame1, a1          ; $01DF30
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DF34
        move.w       ActorVelocityZ(a0), d0                        ; $01DF3A
        sub.w        d0, ActorZ(a0)                                ; $01DF3E
        addq.w       #$1, d0                                       ; $01DF42
        move.w       d0, ActorVelocityZ(a0)                        ; $01DF44
        cmpi.w       #$ffe0, ActorZ(a0)                            ; $01DF48
        bge.b        loc_01DF56                                    ; $01DF4E
        move.w       #$ffe0, ActorZ(a0)                            ; $01DF50

loc_01DF56:
        addq.b       #$1, ActorStateCounter(a0)                    ; $01DF56
        cmpi.b       #$a, ActorStateCounter(a0)                    ; $01DF5A
        beq.w        RemoveActorAndSendLink                        ; $01DF60
        rts                                                        ; $01DF64
        move.w       d5, -$6f26(a6)                                ; $01DF66
        move.w       d5, d2                                        ; $01DF6A
        move.w       -$71d8(a6), d3                                ; $01DF6C
        sub.w        -$6e4c(a6), d3                                ; $01DF70
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
        move.w       d3, -$6f32(a6)                                ; $01DFA4
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DFA8
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01DFAC
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DFB0
        ifne *-$1DFB6
        fail "ROM end moved"
        endif
