; $0189F4..$018A59 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Dog state1 draw selector has no assigning writer in the direct-flow closure of its live callbacks. Corpse states and remote presentation selectors are different contexts. Forced state1 is only a synthetic witness.
        ifne *-$189F4
        fail "ROM start moved"
        endif

DrawDogUnassignedAttack:
; Dog state1 draw selector has no assigning writer in the direct-flow closure of its live callbacks. Corpse states and remote presentation selectors are different contexts. Forced state1 is only a synthetic witness.
        move.b       ActorStateCounter(a0), d7                     ; $0189F4
        cmpi.b       #$9, d7                                       ; $0189F8
        beq.b        loc_018A30                                    ; $0189FC
        cmpi.b       #$8, d7                                       ; $0189FE
        beq.b        loc_018A30                                    ; $018A02
        cmpi.b       #$7, d7                                       ; $018A04
        beq.b        loc_018A3E                                    ; $018A08
        cmpi.b       #$6, d7                                       ; $018A0A
        beq.b        loc_018A3E                                    ; $018A0E
        cmpi.b       #$5, d7                                       ; $018A10
        beq.b        loc_018A4C                                    ; $018A14
        cmpi.b       #$4, d7                                       ; $018A16
        beq.b        loc_018A3E                                    ; $018A1A
        cmpi.b       #$3, d7                                       ; $018A1C
        beq.b        loc_018A3E                                    ; $018A20
        cmpi.b       #$2, d7                                       ; $018A22
        beq.b        loc_018A30                                    ; $018A26
        cmpi.b       #$1, d7                                       ; $018A28
        beq.b        loc_018A30                                    ; $018A2C
        rts                                                        ; $018A2E

loc_018A30:
        move.w       #$1, d0                                       ; $018A30
        move.w       #$1, d2                                       ; $018A34
        jmp          DrawActorAnimation.l                          ; $018A38

loc_018A3E:
        move.w       #$1, d0                                       ; $018A3E
        move.w       #$2, d2                                       ; $018A42
        jmp          DrawActorAnimation.l                          ; $018A46

loc_018A4C:
        move.w       #$1, d0                                       ; $018A4C
        move.w       #$3, d2                                       ; $018A50
        jmp          DrawActorAnimation.l                          ; $018A54
        ifne *-$18A5A
        fail "ROM end moved"
        endif
