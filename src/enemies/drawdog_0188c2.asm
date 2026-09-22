; $0188C2..$018911 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Walk0 covers wander7/charge8/return9. Recoil2/1 or4/1 if HP<0. State1 attack selector exists but no local state1 writer. State6 draw immediately RTS.
        ifne *-$188C2
        fail "ROM start moved"
        endif

DrawDog:
; Walk0 covers wander7/charge8/return9. Recoil2/1 or4/1 if HP<0. State1 attack selector exists but no local state1 writer. State6 draw immediately RTS.
        move.b       ActorState(a0), d7                            ; $0188C2
        cmpi.b       #$2, d7                                       ; $0188C6
        beq.b        loc_0188F0                                    ; $0188CA
        cmpi.b       #$1, d7                                       ; $0188CC
        beq.w        DrawDogUnassignedAttack                       ; $0188D0
        cmpi.b       #$5, d7                                       ; $0188D4
        beq.b        DrawDogWeaponDeath                            ; $0188D8
        cmpi.b       #$6, d7                                       ; $0188DA
        beq.w        DogSkipStateSixDrawing                        ; $0188DE
        move.w       #$0, d0                                       ; $0188E2
        move.w       #$ffff, d2                                    ; $0188E6
        jmp          DrawActorAnimation.l                          ; $0188EA

loc_0188F0:
        tst.w        ActorHealth(a0)                               ; $0188F0
        bmi.b        loc_018904                                    ; $0188F4
        move.w       #$2, d0                                       ; $0188F6
        move.w       #$1, d2                                       ; $0188FA
        jmp          DrawActorAnimation.l                          ; $0188FE

loc_018904:
        move.w       #$4, d0                                       ; $018904
        move.w       #$1, d2                                       ; $018908
        jmp          DrawActorAnimation.l                          ; $01890C
        ifne *-$18912
        fail "ROM end moved"
        endif
