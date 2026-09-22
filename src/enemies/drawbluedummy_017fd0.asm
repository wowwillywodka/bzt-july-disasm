; $017FD0..$01801F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Walk0, recoil6/1 or3/1 if HP<0; attack1. Weapon0B actually enters state6 but draw returns immediately.
        ifne *-$17FD0
        fail "ROM start moved"
        endif

DrawBlueDummy:
; Walk0, recoil6/1 or3/1 if HP<0; attack1. Weapon0B actually enters state6 but draw returns immediately.
        move.b       ActorState(a0), d7                            ; $017FD0
        cmpi.b       #$2, d7                                       ; $017FD4
        beq.b        loc_017FFE                                    ; $017FD8
        cmpi.b       #$1, d7                                       ; $017FDA
        beq.w        DrawBlueDummyAttack                           ; $017FDE
        cmpi.b       #$5, d7                                       ; $017FE2
        beq.b        DrawBlueDummyWeaponDeath                      ; $017FE6
        cmpi.b       #$6, d7                                       ; $017FE8
        beq.w        BlueDummySkipStateSixDrawing                  ; $017FEC
        move.w       #$0, d0                                       ; $017FF0
        move.w       #$ffff, d2                                    ; $017FF4
        jmp          DrawActorAnimation.l                          ; $017FF8

loc_017FFE:
        tst.w        ActorHealth(a0)                               ; $017FFE
        bmi.b        loc_018012                                    ; $018002
        move.w       #$6, d0                                       ; $018004
        move.w       #$1, d2                                       ; $018008
        jmp          DrawActorAnimation.l                          ; $01800C

loc_018012:
        move.w       #$3, d0                                       ; $018012
        move.w       #$1, d2                                       ; $018016
        jmp          DrawActorAnimation.l                          ; $01801A
        ifne *-$18020
        fail "ROM end moved"
        endif
