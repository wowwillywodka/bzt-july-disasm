; $01AE2C..$01AE69 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Gunner bank has only animations0..3. Active state5 later requests animation7, which DrawActorAnimation rejects; do not invent a hidden animation7.
        ifne *-$1AE2C
        fail "ROM start moved"
        endif

DrawGunner:
; Gunner bank has only animations0..3. Active state5 later requests animation7, which DrawActorAnimation rejects; do not invent a hidden animation7.
        move.b       ActorState(a0), d7                            ; $01AE2C
        cmpi.b       #$2, d7                                       ; $01AE30
        beq.b        loc_01AE5C                                    ; $01AE34
        cmpi.b       #$1, d7                                       ; $01AE36
        beq.w        DrawGunnerAttack                              ; $01AE3A
        cmpi.b       #$5, d7                                       ; $01AE3E
        beq.b        DrawGunnerWeaponDeath                         ; $01AE42
        cmpi.b       #$6, d7                                       ; $01AE44
        beq.w        GunnerSkipStateSixDrawing                     ; $01AE48
        move.w       #$0, d0                                       ; $01AE4C
        move.w       #$ffff, d2                                    ; $01AE50
        jsr          DrawActorAnimation.l                          ; $01AE54
        rts                                                        ; $01AE5A

loc_01AE5C:
        move.w       #$2, d0                                       ; $01AE5C
        move.w       #$1, d2                                       ; $01AE60
        jmp          DrawActorAnimation.l                          ; $01AE64
        ifne *-$1AE6A
        fail "ROM end moved"
        endif
