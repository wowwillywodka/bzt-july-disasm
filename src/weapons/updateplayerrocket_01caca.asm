; $01CACA..$01CBED | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Rocket: decrement byte fuse, sample next XY; blocked/expired path damages one panel and starts explosion tail. No general actor overlap scan in flight; hit callback can trigger explosion externally.
        ifne *-$1CACA
        fail "ROM start moved"
        endif

UpdatePlayerRocket:
; Rocket: decrement byte fuse, sample next XY; blocked/expired path damages one panel and starts explosion tail. No general actor overlap scan in flight; hit callback can trigger explosion externally.
        clr.b        ActorUpdateDelay(a0)                          ; $01CACA
        subq.b       #$1, ActorState(a0)                           ; $01CACE
        beq.b        loc_01CAF0                                    ; $01CAD2
        bsr.w        GetVisibleMapBase                             ; $01CAD4
        move.w       ActorX(a0), d0                                ; $01CAD8
        add.w        ActorMotionX(a0), d0                          ; $01CADC
        move.w       ActorY(a0), d1                                ; $01CAE0
        add.w        ActorMotionY(a0), d1                          ; $01CAE4
        bsr.w        TestProjectilePointInActiveWindow             ; $01CAE8
        beq.w        loc_01CB9A                                    ; $01CAEC

loc_01CAF0:
        move.w       ActorX(a0), d0                                ; $01CAF0
        add.w        ActorMotionX(a0), d0                          ; $01CAF4
        cmpi.w       #$1f00, d0                                    ; $01CAF8
        bcs.b        loc_01CB48                                    ; $01CAFC
        bsr.w        GetVisibleMapBase                             ; $01CAFE
        move.w       ActorX(a0), d0                                ; $01CB02
        asr.w        #$8, d0                                       ; $01CB06
        adda.w       d0, a1                                        ; $01CB08
        move.w       ActorY(a0), d0                                ; $01CB0A
        clr.b        d0                                            ; $01CB0E
        asr.w        #$3, d0                                       ; $01CB10
        adda.w       d0, a1                                        ; $01CB12
        clr.w        d0                                            ; $01CB14
        move.b       (a1, d0.w), d0                                ; $01CB16
        lea.l        rCellTypeByIndex(a6), a1                      ; $01CB1A
        move.b       (a1, d0.w), d0                                ; $01CB1E
        cmpi.b       #$28, d0                                      ; $01CB22
        beq.b        loc_01CB36                                    ; $01CB26
        cmpi.b       #$27, d0                                      ; $01CB28
        bne.b        loc_01CB48                                    ; $01CB2C
        tst.w        ActorZ(a0)                                    ; $01CB2E
        beq.b        loc_01CB48                                    ; $01CB32
        bmi.b        loc_01CB48                                    ; $01CB34

loc_01CB36:
        move.w       #$120, d0                                     ; $01CB36
        move.l       a0, -(a7)                                     ; $01CB3A
        jsr          UiRoutine_00279E.l                            ; $01CB3C
        movea.l      (a7)+, a0                                     ; $01CB42
        bra.w        RemoveActorAndSendLink                        ; $01CB44

loc_01CB48:
        bsr.w        GetVisibleMapBase                             ; $01CB48
        move.w       ActorX(a0), d0                                ; $01CB4C
        add.w        ActorMotionX(a0), d0                          ; $01CB50
        move.w       ActorY(a0), d1                                ; $01CB54
        add.w        ActorMotionY(a0), d1                          ; $01CB58
        bsr.w        DisabledActorProjectileSurfaceTest            ; $01CB5C
        bne.w        RemoveActorAndSendLink                        ; $01CB60
        movem.l      d0-d1/a0, -(a7)                               ; $01CB64
        jsr          DamagePanelCellAtPoint.l                      ; $01CB68
        movem.l      (a7)+, d0-d1/a0                               ; $01CB6E
        clr.w        ActorMotionX(a0)                              ; $01CB72
        clr.w        ActorMotionY(a0)                              ; $01CB76
        clr.w        -$55a0(a6)                                    ; $01CB7A
        clr.w        -$559e(a6)                                    ; $01CB7E
        move.w       #$e, d0                                       ; $01CB82
        move.l       a0, -(a7)                                     ; $01CB86
        jsr          SoundRoutine_00DF64.l                         ; $01CB88
        movea.l      (a7)+, a0                                     ; $01CB8E
        move.w       #$32, -$559e(a6)                              ; $01CB90
        bra.w        loc_01C812                                    ; $01CB96

loc_01CB9A:
        move.w       d0, ActorX(a0)                                ; $01CB9A
        move.w       d1, ActorY(a0)                                ; $01CB9E
        rts                                                        ; $01CBA2

loc_01CBA4:
        move.w       d5, -$6f26(a6)                                ; $01CBA4
        move.w       d5, d2                                        ; $01CBA8
        move.w       -$71d8(a6), d3                                ; $01CBAA
        sub.w        -$6e4c(a6), d3                                ; $01CBAE
        sub.w        ActorZ(a0), d3                                ; $01CBB2
        muls.w       d3, d2                                        ; $01CBB6
        asr.l        #$6, d2                                       ; $01CBB8
        addi.w       #$28, d2                                      ; $01CBBA
        movea.l      rZoneObjectTiles(a6), a1                      ; $01CBBE
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01CBC2
        move.w       rGameTick(a6), d0                             ; $01CBC6
        andi.w       #$1, d0                                       ; $01CBCA
        move.w       d0, -$6f32(a6)                                ; $01CBCE
        move.w       d5, d0                                        ; $01CBD2
        asr.w        #$1, d0                                       ; $01CBD4
        move.w       d0, d4                                        ; $01CBD6
        asr.w        #$1, d4                                       ; $01CBD8
        sub.w        d4, d2                                        ; $01CBDA
        move.w       d4, d3                                        ; $01CBDC
        asr.w        #$1, d3                                       ; $01CBDE
        sub.w        d3, d1                                        ; $01CBE0
        move.l       a0, -(a7)                                     ; $01CBE2
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01CBE4
        movea.l      (a7)+, a0                                     ; $01CBEA
        rts                                                        ; $01CBEC
        ifne *-$1CBEE
        fail "ROM end moved"
        endif
