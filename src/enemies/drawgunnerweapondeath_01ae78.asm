; $01AE78..$01AEEF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active state5: counters7/6 ->2/1; 5/4 ->7/1; 3 ->7/2; 2/1 ->7/3. Animation7 is out of range for GunnerSpriteBank and returns without drawing.
        ifne *-$1AE78
        fail "ROM start moved"
        endif

DrawGunnerWeaponDeath:
; Active state5: counters7/6 ->2/1; 5/4 ->7/1; 3 ->7/2; 2/1 ->7/3. Animation7 is out of range for GunnerSpriteBank and returns without drawing.
        move.b       ActorStateCounter(a0), d7                     ; $01AE78
        cmpi.b       #$7, d7                                       ; $01AE7C
        beq.b        loc_01AEA8                                    ; $01AE80
        cmpi.b       #$6, d7                                       ; $01AE82
        beq.b        loc_01AEA8                                    ; $01AE86
        cmpi.b       #$5, d7                                       ; $01AE88
        beq.b        loc_01AEB6                                    ; $01AE8C
        cmpi.b       #$4, d7                                       ; $01AE8E
        beq.b        loc_01AEB6                                    ; $01AE92
        cmpi.b       #$3, d7                                       ; $01AE94
        beq.b        loc_01AEC4                                    ; $01AE98
        cmpi.b       #$2, d7                                       ; $01AE9A
        beq.b        loc_01AED2                                    ; $01AE9E
        cmpi.b       #$1, d7                                       ; $01AEA0
        beq.b        loc_01AEE0                                    ; $01AEA4
        rts                                                        ; $01AEA6

loc_01AEA8:
        move.w       #$2, d0                                       ; $01AEA8
        move.w       #$1, d2                                       ; $01AEAC
        jmp          DrawActorAnimation.l                          ; $01AEB0

loc_01AEB6:
        move.w       #$7, d0                                       ; $01AEB6
        move.w       #$1, d2                                       ; $01AEBA
        jmp          DrawActorAnimation.l                          ; $01AEBE

loc_01AEC4:
        move.w       #$7, d0                                       ; $01AEC4
        move.w       #$2, d2                                       ; $01AEC8
        jmp          DrawActorAnimation.l                          ; $01AECC

loc_01AED2:
        move.w       #$7, d0                                       ; $01AED2
        move.w       #$3, d2                                       ; $01AED6
        jmp          DrawActorAnimation.l                          ; $01AEDA

loc_01AEE0:
        move.w       #$7, d0                                       ; $01AEE0
        move.w       #$3, d2                                       ; $01AEE4
        jmp          DrawActorAnimation.l                          ; $01AEE8

GunnerSkipStateSixDrawing:
        rts                                                        ; $01AEEE
        ifne *-$1AEF0
        fail "ROM end moved"
        endif
