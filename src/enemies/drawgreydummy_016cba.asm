; $016CBA..$016D81 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Walk0; recoil6 (negative HP:3); attack1; weapon0D uses6 then4. State6 returns at $16D80 WITHOUT drawing. See retained body $16D82.
        ifne *-$16CBA
        fail "ROM start moved"
        endif

DrawGreyDummy:
; Walk0; recoil6 (negative HP:3); attack1; weapon0D uses6 then4. State6 returns at $16D80 WITHOUT drawing. See retained body $16D82.
        move.b       ActorState(a0), d7                            ; $016CBA
        cmpi.b       #$2, d7                                       ; $016CBE
        beq.b        loc_016CE8                                    ; $016CC2
        cmpi.b       #$1, d7                                       ; $016CC4
        beq.w        DrawGreyDummyAttack                           ; $016CC8
        cmpi.b       #$5, d7                                       ; $016CCC
        beq.b        loc_016D0A                                    ; $016CD0
        cmpi.b       #$6, d7                                       ; $016CD2
        beq.w        GreyDummySkipWeapon0BDrawing                  ; $016CD6
        move.w       #$0, d0                                       ; $016CDA
        move.w       #$ffff, d2                                    ; $016CDE
        jmp          DrawActorAnimation.l                          ; $016CE2

loc_016CE8:
        tst.w        ActorHealth(a0)                               ; $016CE8
        bmi.b        loc_016CFC                                    ; $016CEC
        move.w       #$6, d0                                       ; $016CEE
        move.w       #$1, d2                                       ; $016CF2
        jmp          DrawActorAnimation.l                          ; $016CF6

loc_016CFC:
        move.w       #$3, d0                                       ; $016CFC
        move.w       #$1, d2                                       ; $016D00
        jmp          DrawActorAnimation.l                          ; $016D04

loc_016D0A:
        move.b       ActorStateCounter(a0), d7                     ; $016D0A
        cmpi.b       #$7, d7                                       ; $016D0E
        beq.b        loc_016D3A                                    ; $016D12
        cmpi.b       #$6, d7                                       ; $016D14
        beq.b        loc_016D3A                                    ; $016D18
        cmpi.b       #$5, d7                                       ; $016D1A
        beq.b        loc_016D48                                    ; $016D1E
        cmpi.b       #$4, d7                                       ; $016D20
        beq.b        loc_016D48                                    ; $016D24
        cmpi.b       #$3, d7                                       ; $016D26
        beq.b        loc_016D56                                    ; $016D2A
        cmpi.b       #$2, d7                                       ; $016D2C
        beq.b        loc_016D64                                    ; $016D30
        cmpi.b       #$1, d7                                       ; $016D32
        beq.b        loc_016D72                                    ; $016D36
        rts                                                        ; $016D38

loc_016D3A:
        move.w       #$6, d0                                       ; $016D3A
        move.w       #$1, d2                                       ; $016D3E
        jmp          DrawActorAnimation.l                          ; $016D42

loc_016D48:
        move.w       #$4, d0                                       ; $016D48
        move.w       #$1, d2                                       ; $016D4C
        jmp          DrawActorAnimation.l                          ; $016D50

loc_016D56:
        move.w       #$4, d0                                       ; $016D56
        move.w       #$2, d2                                       ; $016D5A
        jmp          DrawActorAnimation.l                          ; $016D5E

loc_016D64:
        move.w       #$4, d0                                       ; $016D64
        move.w       #$3, d2                                       ; $016D68
        jmp          DrawActorAnimation.l                          ; $016D6C

loc_016D72:
        move.w       #$4, d0                                       ; $016D72
        move.w       #$4, d2                                       ; $016D76
        jmp          DrawActorAnimation.l                          ; $016D7A

GreyDummySkipWeapon0BDrawing:
; Original RTS suppresses the weapon0B animation sequence immediately below; preserved byte for byte.
        rts                                                        ; $016D80
        ifne *-$16D82
        fail "ROM end moved"
        endif
