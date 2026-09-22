; $0191E0..$01921B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Walk0, recoil2/1 even for negative HP, attack1. State5 draws2 then5; state6 returns before retained sequence.
        ifne *-$191E0
        fail "ROM start moved"
        endif

DrawLarvaCreature:
; Walk0, recoil2/1 even for negative HP, attack1. State5 draws2 then5; state6 returns before retained sequence.
        move.b       ActorState(a0), d7                            ; $0191E0
        cmpi.b       #$2, d7                                       ; $0191E4
        beq.b        loc_01920E                                    ; $0191E8
        cmpi.b       #$1, d7                                       ; $0191EA
        beq.w        DrawLarvaCreatureAttack                       ; $0191EE
        cmpi.b       #$5, d7                                       ; $0191F2
        beq.b        DrawLarvaCreatureWeaponDeath                  ; $0191F6
        cmpi.b       #$6, d7                                       ; $0191F8
        beq.w        LarvaCreatureSkipStateSixDrawing              ; $0191FC
        move.w       #$0, d0                                       ; $019200
        move.w       #$ffff, d2                                    ; $019204
        jmp          DrawActorAnimation.l                          ; $019208

loc_01920E:
        move.w       #$2, d0                                       ; $01920E
        move.w       #$1, d2                                       ; $019212
        jmp          DrawActorAnimation.l                          ; $019216
        ifne *-$1921C
        fail "ROM end moved"
        endif
