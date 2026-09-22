; $01DD82..$01DDA5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Перевод снаряда в фазу наведения: ставит аним-параметр $39=$21 или $31 (по режиму игры -$6fa6) и state $38=1
        ifne *-$1DD82
        fail "ROM start moved"
        endif

WeaponsRoutine_01DD82:
        cmpi.w       #$4, rSelectedCharacter(a6)                   ; $01DD82
        beq.b        loc_01DD98                                    ; $01DD88
        move.b       #$21, ActorStateCounter(a0)                   ; $01DD8A
        move.b       #$1, ActorState(a0)                           ; $01DD90
        rts                                                        ; $01DD96

loc_01DD98:
        move.b       #$31, ActorStateCounter(a0)                   ; $01DD98
        move.b       #$1, ActorState(a0)                           ; $01DD9E
        rts                                                        ; $01DDA4
        ifne *-$1DDA6
        fail "ROM end moved"
        endif
