; $01C880..$01C983 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запуск наводящегося снаряда: вычитает позицию игрока (-0x7206/-0x7204,A6) из координат цели, jsr 0xdfe4/0xe024 (вектор/угол наведения), ставит vtable снаряда (0x1cd1c/0x1ccd0/0x1ee24), скорость 0x22(a0)=2
        ifne *-$1C880
        fail "ROM start moved"
        endif

WeaponsRoutine_01C880:
        clr.w        -$55a0(a6)                                    ; $01C880
        clr.w        -$559e(a6)                                    ; $01C884
        move.w       #$18, d0                                      ; $01C888
        move.l       a0, -(a7)                                     ; $01C88C
        jsr          SoundRoutine_00DF64.l                         ; $01C88E
        movea.l      (a7)+, a0                                     ; $01C894
        move.w       #$1e, -$559e(a6)                              ; $01C896
        move.l       a0, -(a7)                                     ; $01C89C
        move.w       -$7202(a6), -(a7)                             ; $01C89E
        move.w       -$7200(a6), -(a7)                             ; $01C8A2
        move.w       ActorX(a0), d0                                ; $01C8A6
        move.w       ActorY(a0), d1                                ; $01C8AA
        sub.w        rPlayerX(a6), d0                              ; $01C8AE
        sub.w        rPlayerY(a6), d1                              ; $01C8B2
        move.w       d0, d3                                        ; $01C8B6
        move.w       d1, d4                                        ; $01C8B8
        jsr          OctagonalDistance.l                           ; $01C8BA
        jsr          ApplyPlayerDistanceHit.l                      ; $01C8C0
        move.w       (a7)+, -$7200(a6)                             ; $01C8C6
        move.w       (a7)+, -$7202(a6)                             ; $01C8CA
        movea.l      (a7)+, a0                                     ; $01C8CE
        move.l       #DrawProjectileExplosion, ActorDrawCallback(a0) ; $01C8D0
        move.l       #UpdateProjectileExplosion, ActorUpdateCallback(a0) ; $01C8D8
        move.l       #ActorsRoutine_01EE24, ActorLinkCallback(a0)  ; $01C8E0
        ori.w        #$ff37, ActorFlags(a0)                        ; $01C8E8
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C8EE
        clr.b        ActorUpdateDelay(a0)                          ; $01C8F6
        move.b       #$2, ActorEffectCounter(a0)                   ; $01C8FA
        rts                                                        ; $01C900
        clr.w        -$55a0(a6)                                    ; $01C902
        clr.w        -$559e(a6)                                    ; $01C906
        move.w       #$38, d0                                      ; $01C90A
        move.l       a0, -(a7)                                     ; $01C90E
        jsr          SoundRoutine_00DF64.l                         ; $01C910
        movea.l      (a7)+, a0                                     ; $01C916
        move.w       #$1e, -$559e(a6)                              ; $01C918
        move.l       a0, -(a7)                                     ; $01C91E
        move.w       -$7202(a6), -(a7)                             ; $01C920
        move.w       -$7200(a6), -(a7)                             ; $01C924
        move.w       ActorX(a0), d0                                ; $01C928
        move.w       ActorY(a0), d1                                ; $01C92C
        sub.w        rPlayerX(a6), d0                              ; $01C930
        sub.w        rPlayerY(a6), d1                              ; $01C934
        move.w       d0, d3                                        ; $01C938
        move.w       d1, d4                                        ; $01C93A
        jsr          OctagonalDistance.l                           ; $01C93C
        jsr          UiRoutine_00E000.l                            ; $01C942
        move.w       (a7)+, -$7200(a6)                             ; $01C948
        move.w       (a7)+, -$7202(a6)                             ; $01C94C
        movea.l      (a7)+, a0                                     ; $01C950
        move.l       #DrawProjectileExplosion, ActorDrawCallback(a0) ; $01C952
        move.l       #UpdateProjectileExplosion, ActorUpdateCallback(a0) ; $01C95A
        move.l       #ActorsRoutine_01EE24, ActorLinkCallback(a0)  ; $01C962
        ori.w        #$ff37, ActorFlags(a0)                        ; $01C96A
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C970
        clr.b        ActorUpdateDelay(a0)                          ; $01C978
        move.b       #$2, ActorEffectCounter(a0)                   ; $01C97C
        rts                                                        ; $01C982
        ifne *-$1C984
        fail "ROM end moved"
        endif
