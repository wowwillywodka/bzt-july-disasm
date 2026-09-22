; $01AFC0..$01B0B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB/CC counter11..1 is decremented by drawing. Default corpse3/6 arms Byte52=20/counter80 only if Byte52==0. C8/C9 branches switch to Dog bank but normal death always sets CB.
        ifne *-$1AFC0
        fail "ROM start moved"
        endif

DrawGunnerCorpse:
; Type03 death render can arm ActorBehaviorByte52=20; its death update decrements this byte and requests scene exit at zero. Do not infer completion solely from total enemies.
; CB/CC counter11..1 is decremented by drawing. Default corpse3/6 arms Byte52=20/counter80 only if Byte52==0. C8/C9 branches switch to Dog bank but normal death always sets CB.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01AFC0
        beq.w        loc_01B010                                    ; $01AFC6
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01AFCA
        beq.w        loc_01B038                                    ; $01AFD0
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01AFD4
        beq.w        loc_01B126                                    ; $01AFDA
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01AFDE
        beq.w        loc_01B060                                    ; $01AFE4
        cmpi.l       #$1a35a4, ActorSpriteBank(a0)                 ; $01AFE8
        tst.b        ActorBehaviorByte52(a0)                       ; $01AFF0
        bne.b        loc_01B002                                    ; $01AFF4

GunnerArmSceneExitFromCorpseDrawing:
        move.b       #$14, ActorBehaviorByte52(a0)                 ; $01AFF6
        move.b       #$50, ActorStateCounter(a0)                   ; $01AFFC

loc_01B002:
        move.w       #$3, d0                                       ; $01B002
        move.w       #$6, d2                                       ; $01B006
        jmp          DrawActorAnimation.l                          ; $01B00A

loc_01B010:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01B010
        move.w       #$5, d0                                       ; $01B018
        move.w       #$4, d2                                       ; $01B01C
        tst.b        ActorBehaviorByte52(a0)                       ; $01B020
        bne.b        loc_01B032                                    ; $01B024
        move.b       #$14, ActorBehaviorByte52(a0)                 ; $01B026
        move.b       #$50, ActorStateCounter(a0)                   ; $01B02C

loc_01B032:
        jmp          DrawActorAnimation.l                          ; $01B032

loc_01B038:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $01B038
        move.w       #$5, d0                                       ; $01B040
        move.w       #$4, d2                                       ; $01B044
        tst.b        ActorBehaviorByte52(a0)                       ; $01B048
        bne.b        loc_01B05A                                    ; $01B04C
        move.b       #$14, ActorBehaviorByte52(a0)                 ; $01B04E
        move.b       #$50, ActorStateCounter(a0)                   ; $01B054

loc_01B05A:
        jmp          DrawActorAnimation.l                          ; $01B05A

loc_01B060:
        cmpi.b       #$b, ActorStateCounter(a0)                    ; $01B060
        beq.b        DrawGunnerCorpseEarlyFrames                   ; $01B066
        cmpi.b       #$a, ActorStateCounter(a0)                    ; $01B068
        beq.b        DrawGunnerCorpseEarlyFrames                   ; $01B06E
        cmpi.b       #$9, ActorStateCounter(a0)                    ; $01B070
        beq.b        loc_01B0CC                                    ; $01B076
        cmpi.b       #$8, ActorStateCounter(a0)                    ; $01B078
        beq.b        loc_01B0CC                                    ; $01B07E
        cmpi.b       #$7, ActorStateCounter(a0)                    ; $01B080
        beq.b        loc_01B0DE                                    ; $01B086
        cmpi.b       #$6, ActorStateCounter(a0)                    ; $01B088
        beq.b        loc_01B0DE                                    ; $01B08E
        cmpi.b       #$5, ActorStateCounter(a0)                    ; $01B090
        beq.b        loc_01B0F0                                    ; $01B096
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $01B098
        beq.b        loc_01B0F0                                    ; $01B09E
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $01B0A0
        beq.b        DrawGunnerCorpseFrameFive                     ; $01B0A6
        cmpi.b       #$2, ActorStateCounter(a0)                    ; $01B0A8
        beq.b        DrawGunnerCorpseFrameFive                     ; $01B0AE
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $01B0B0
        beq.b        loc_01B0DE                                    ; $01B0B6
        rts                                                        ; $01B0B8
        ifne *-$1B0BA
        fail "ROM end moved"
        endif
