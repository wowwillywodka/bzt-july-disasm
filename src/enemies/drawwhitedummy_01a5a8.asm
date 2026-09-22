; $01A5A8..$01A5E3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Walk0; recoil2 regardless of HP; attack1. State5 selects2 then5. State6 branches to RTS $1A668; sequence at $1A66A is skipped.
        ifne *-$1A5A8
        fail "ROM start moved"
        endif

DrawWhiteDummy:
; Walk0; recoil2 regardless of HP; attack1. State5 selects2 then5. State6 branches to RTS $1A668; sequence at $1A66A is skipped.
        move.b       ActorState(a0), d7                            ; $01A5A8
        cmpi.b       #$2, d7                                       ; $01A5AC
        beq.b        loc_01A5D6                                    ; $01A5B0
        cmpi.b       #$1, d7                                       ; $01A5B2
        beq.w        DrawWhiteDummyAttack                          ; $01A5B6
        cmpi.b       #$5, d7                                       ; $01A5BA
        beq.b        DrawWhiteDummyWeaponDeath                     ; $01A5BE
        cmpi.b       #$6, d7                                       ; $01A5C0
        beq.w        WhiteDummySkipStateSixDrawing                 ; $01A5C4
        move.w       #$0, d0                                       ; $01A5C8
        move.w       #$ffff, d2                                    ; $01A5CC
        jmp          DrawActorAnimation.l                          ; $01A5D0

loc_01A5D6:
        move.w       #$2, d0                                       ; $01A5D6
        move.w       #$1, d2                                       ; $01A5DA
        jmp          DrawActorAnimation.l                          ; $01A5DE
        ifne *-$1A5E4
        fail "ROM end moved"
        endif
