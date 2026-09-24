; $01DD82..$01DDA5 | m68k
; Maintained assembly input; no extraction occurs during build.
; Set state 1 and countdown $21 or $31 according to selected character.
        ifne *-$1DD82
        fail "ROM start moved"
        endif

StartWallChargeCountdown:
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
