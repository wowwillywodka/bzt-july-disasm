; $01DDA6..$01DDD3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проверка дальности до ближайшей цели ($1e59e + $dfe4): если расстояние >$c00 — деспавн снаряда через $1e040, иначе продолжить наведение
        ifne *-$1DDA6
        fail "ROM start moved"
        endif

WeaponsRoutine_01DDA6:
        bsr.w        SelectEnemyPlayerTarget                       ; $01DDA6
        cmpa.l       #$0, a1                                       ; $01DDAA
        beq.w        EnvironmentRoutine_01E040                     ; $01DDB0
        move.w       ActorX(a0), d0                                ; $01DDB4
        sub.w        $24(a1), d0                                   ; $01DDB8
        move.w       ActorY(a0), d1                                ; $01DDBC
        sub.w        $26(a1), d1                                   ; $01DDC0
        jsr          OctagonalDistance.l                           ; $01DDC4
        cmpi.w       #$c00, d0                                     ; $01DDCA
        bhi.w        EnvironmentRoutine_01E040                     ; $01DDCE
        rts                                                        ; $01DDD2
        ifne *-$1DDD4
        fail "ROM end moved"
        endif
