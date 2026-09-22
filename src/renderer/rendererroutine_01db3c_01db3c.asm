; $01DB3C..$01DC31 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Update entry immediately branches to RemoveActorAndSendLink (after an optional decrement). The separately installed draw callback starts at $01DB4C, not here.
        ifne *-$1DB3C
        fail "ROM start moved"
        endif

RendererRoutine_01DB3C:
; Update entry immediately branches to RemoveActorAndSendLink (after an optional decrement). The separately installed draw callback starts at $01DB4C, not here.
        tst.w        -$6fe0(a6)                                    ; $01DB3C
        beq.w        RemoveActorAndSendLink                        ; $01DB40
        subq.w       #$1, -$6fe0(a6)                               ; $01DB44
        bra.w        RemoveActorAndSendLink                        ; $01DB48
; Independent draw callback installed at $01D95E: actor state 0 chooses tile 61; states 1/other choose tile 62 with different size formulas.
        move.w       d5, -$6f26(a6)                                ; $01DB4C
        move.w       d5, d2                                        ; $01DB50
        move.w       -$71d8(a6), d3                                ; $01DB52
        sub.w        -$6e4c(a6), d3                                ; $01DB56
        sub.w        ActorZ(a0), d3                                ; $01DB5A
        muls.w       d3, d2                                        ; $01DB5E
        asr.l        #$6, d2                                       ; $01DB60
        addi.w       #$28, d2                                      ; $01DB62
        clr.w        d7                                            ; $01DB66
        move.b       ActorStateCounter(a0), d7                     ; $01DB68
        move.w       d7, d6                                        ; $01DB6C
        move.b       ActorState(a0), d0                            ; $01DB6E
        beq.w        loc_01DBF6                                    ; $01DB72
        cmpi.b       #$1, d0                                       ; $01DB76
        beq.b        loc_01DBBC                                    ; $01DB7A
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DB7C
        adda.w       #ObjectTileOffset62_ProjectilePhases12, a1    ; $01DB80
        move.b       ActorLinkId(a0), d0                           ; $01DB84
        andi.w       #$1, d0                                       ; $01DB88
        move.w       d0, -$6f32(a6)                                ; $01DB8C
        move.w       d5, d0                                        ; $01DB90
        move.w       d5, d4                                        ; $01DB92
        addi.w       #$80, d7                                      ; $01DB94
        mulu.w       d7, d4                                        ; $01DB98
        asr.l        #$7, d4                                       ; $01DB9A
        neg.w        d6                                            ; $01DB9C
        addi.w       #$100, d6                                     ; $01DB9E
        mulu.w       d6, d0                                        ; $01DBA2
        asr.l        #$8, d0                                       ; $01DBA4
        asr.w        #$4, d0                                       ; $01DBA6
        asr.w        #$3, d4                                       ; $01DBA8
        move.w       d0, d3                                        ; $01DBAA
        asr.w        #$1, d3                                       ; $01DBAC
        sub.w        d3, d2                                        ; $01DBAE
        move.w       d4, d3                                        ; $01DBB0
        asr.w        #$1, d3                                       ; $01DBB2
        sub.w        d3, d1                                        ; $01DBB4
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DBB6

loc_01DBBC:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DBBC
        adda.w       #ObjectTileOffset62_ProjectilePhases12, a1    ; $01DBC0
        move.b       ActorLinkId(a0), d0                           ; $01DBC4
        andi.w       #$1, d0                                       ; $01DBC8
        move.w       d0, -$6f32(a6)                                ; $01DBCC
        move.w       d5, d0                                        ; $01DBD0
        move.w       d5, d4                                        ; $01DBD2
        addi.w       #$100, d7                                     ; $01DBD4
        mulu.w       d7, d0                                        ; $01DBD8
        asr.l        #$8, d0                                       ; $01DBDA
        neg.w        d6                                            ; $01DBDC
        addi.w       #$100, d6                                     ; $01DBDE
        mulu.w       d6, d4                                        ; $01DBE2
        asr.l        #$8, d4                                       ; $01DBE4
        asr.w        #$3, d0                                       ; $01DBE6
        asr.w        #$4, d4                                       ; $01DBE8
        move.w       d4, d3                                        ; $01DBEA
        asr.w        #$1, d3                                       ; $01DBEC
        sub.w        d3, d1                                        ; $01DBEE
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DBF0

loc_01DBF6:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01DBF6
        adda.w       #ObjectTileOffset61_ProjectilePhase0, a1      ; $01DBFA
        move.b       ActorLinkId(a0), d0                           ; $01DBFE
        andi.w       #$1, d0                                       ; $01DC02
        move.w       d0, -$6f32(a6)                                ; $01DC06
        move.w       d5, d0                                        ; $01DC0A
        asr.w        #$2, d0                                       ; $01DC0C
        move.w       d0, d4                                        ; $01DC0E
        asr.w        #$1, d4                                       ; $01DC10
        sub.w        d4, d2                                        ; $01DC12
        move.w       d4, d3                                        ; $01DC14
        asr.w        #$1, d3                                       ; $01DC16
        sub.w        d3, d1                                        ; $01DC18
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01DC1A
        clr.b        ActorUpdateDelay(a0)                          ; $01DC20
        subq.b       #$1, ActorState(a0)                           ; $01DC24
        bmi.w        RemoveActorAndSendLink                        ; $01DC28
        addq.w       #$2, ActorZ(a0)                               ; $01DC2C
        rts                                                        ; $01DC30
        ifne *-$1DC32
        fail "ROM end moved"
        endif
