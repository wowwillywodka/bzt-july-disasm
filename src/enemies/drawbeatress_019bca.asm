; $019BCA..$019C05 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Walk0, recoil6 regardless of HP, melee1. State5 uses6 then4; state6 returns before retained animation5 sequence.
        ifne *-$19BCA
        fail "ROM start moved"
        endif

DrawBeatress:
; Walk0, recoil6 regardless of HP, melee1. State5 uses6 then4; state6 returns before retained animation5 sequence.
        move.b       ActorState(a0), d7                            ; $019BCA
        cmpi.b       #$2, d7                                       ; $019BCE
        beq.b        loc_019BF8                                    ; $019BD2
        cmpi.b       #$1, d7                                       ; $019BD4
        beq.w        DrawBeatressMeleeAttack                       ; $019BD8
        cmpi.b       #$5, d7                                       ; $019BDC
        beq.b        DrawBeatressWeaponDeath                       ; $019BE0
        cmpi.b       #$6, d7                                       ; $019BE2
        beq.w        BeatressSkipStateSixDrawing                   ; $019BE6
        move.w       #$0, d0                                       ; $019BEA
        move.w       #$ffff, d2                                    ; $019BEE
        jmp          DrawActorAnimation.l                          ; $019BF2

loc_019BF8:
        move.w       #$6, d0                                       ; $019BF8
        move.w       #$1, d2                                       ; $019BFC
        jmp          DrawActorAnimation.l                          ; $019C00
        ifne *-$19C06
        fail "ROM end moved"
        endif
