; $01E0DC..$01E1AD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Главный тик летящего снаряда: клампит высоту $28 [-$1c..$1c], сдвиг X/Y по скорости $2e/$30 с коллизией $1c76c, поиск цели $1e59e; при сближении вызывает hit-вектор цели $a(a3) (нанесение урона), звук $2a и эффект попадания
        ifne *-$1E0DC
        fail "ROM start moved"
        endif

WeaponsRoutine_01E0DC:
        clr.b        ActorUpdateDelay(a0)                          ; $01E0DC
        move.w       ActorZ(a0), d0                                ; $01E0E0
        add.w        ActorVelocityZ(a0), d0                        ; $01E0E4
        cmpi.w       #$ffe4, d0                                    ; $01E0E8
        bge.b        loc_01E0F4                                    ; $01E0EC
        move.w       #$ffe4, d0                                    ; $01E0EE
        bra.b        loc_01E0FE                                    ; $01E0F2

loc_01E0F4:
        cmpi.w       #$1c, d0                                      ; $01E0F4
        ble.b        loc_01E0FE                                    ; $01E0F8
        move.w       #$1c, d0                                      ; $01E0FA

loc_01E0FE:
        move.w       d0, ActorZ(a0)                                ; $01E0FE
        move.w       ActorX(a0), d0                                ; $01E102
        add.w        ActorMotionX(a0), d0                          ; $01E106
        move.w       ActorY(a0), d1                                ; $01E10A
        add.w        ActorMotionY(a0), d1                          ; $01E10E
        bsr.w        TestProjectilePointInActiveWindow             ; $01E112
        bne.w        RemoveActorAndSendLink                        ; $01E116
        move.w       d0, ActorX(a0)                                ; $01E11A
        move.w       d1, ActorY(a0)                                ; $01E11E
        bsr.w        SelectEnemyPlayerTarget                       ; $01E122
        cmpa.l       #$0, a1                                       ; $01E126
        beq.w        RemoveActorAndSendLink                        ; $01E12C
        movea.l      a1, a3                                        ; $01E130
        move.w       $24(a3), d0                                   ; $01E132
        sub.w        ActorX(a0), d0                                ; $01E136
        move.w       $26(a3), d1                                   ; $01E13A
        sub.w        ActorY(a0), d1                                ; $01E13E
        jsr          OctagonalDistance.l                           ; $01E142
        cmpi.w       #$40, d0                                      ; $01E148
        bhi.b        loc_01E1AC                                    ; $01E14C
        move.w       ActorX(a0), d3                                ; $01E14E
        move.w       ActorY(a0), d4                                ; $01E152
        sub.w        $24(a3), d3                                   ; $01E156
        sub.w        $26(a3), d4                                   ; $01E15A
        move.w       #$1f4, d0                                     ; $01E15E
        cmpi.w       #$fff8, ActorZ(a0)                            ; $01E162
        blt.b        loc_01E17A                                    ; $01E168
        cmpi.w       #$8, ActorZ(a0)                               ; $01E16A
        ble.b        loc_01E182                                    ; $01E170
        tst.w        -$71d8(a6)                                    ; $01E172
        bmi.b        loc_01E1AC                                    ; $01E176
        bra.b        loc_01E182                                    ; $01E178

loc_01E17A:
        tst.w        -$71d8(a6)                                    ; $01E17A
        beq.b        loc_01E182                                    ; $01E17E
        bpl.b        loc_01E1AC                                    ; $01E180

loc_01E182:
        move.l       a0, -(a7)                                     ; $01E182
        movea.l      a3, a0                                        ; $01E184
        movea.l      ActorHitCallback(a0), a1                      ; $01E186
        jsr          (a1)                                          ; $01E18A
        clr.w        -$55a0(a6)                                    ; $01E18C
        clr.w        -$559e(a6)                                    ; $01E190
        movea.l      (a7), a0                                      ; $01E194
        move.w       #$2a, d0                                      ; $01E196
        jsr          SoundRoutine_00DF64.l                         ; $01E19A
        movea.l      (a7)+, a0                                     ; $01E1A0
        move.w       #$f, -$559e(a6)                               ; $01E1A2
        bra.w        RemoveActorAndSendLink                        ; $01E1A8

loc_01E1AC:
        rts                                                        ; $01E1AC
        ifne *-$1E1AE
        fail "ROM end moved"
        endif
