; $019C14..$019C8B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State5 counters7/6 ->6/1;5/4 ->4/1;3 ->4/2;2/1 ->4/3. All requested frames exist in Beatress bank.
        ifne *-$19C14
        fail "ROM start moved"
        endif

DrawBeatressWeaponDeath:
; State5 counters7/6 ->6/1;5/4 ->4/1;3 ->4/2;2/1 ->4/3. All requested frames exist in Beatress bank.
        move.b       ActorStateCounter(a0), d7                     ; $019C14
        cmpi.b       #$7, d7                                       ; $019C18
        beq.b        loc_019C44                                    ; $019C1C
        cmpi.b       #$6, d7                                       ; $019C1E
        beq.b        loc_019C44                                    ; $019C22
        cmpi.b       #$5, d7                                       ; $019C24
        beq.b        loc_019C52                                    ; $019C28
        cmpi.b       #$4, d7                                       ; $019C2A
        beq.b        loc_019C52                                    ; $019C2E
        cmpi.b       #$3, d7                                       ; $019C30
        beq.b        loc_019C60                                    ; $019C34
        cmpi.b       #$2, d7                                       ; $019C36
        beq.b        loc_019C6E                                    ; $019C3A
        cmpi.b       #$1, d7                                       ; $019C3C
        beq.b        loc_019C7C                                    ; $019C40
        rts                                                        ; $019C42

loc_019C44:
        move.w       #$6, d0                                       ; $019C44
        move.w       #$1, d2                                       ; $019C48
        jmp          DrawActorAnimation.l                          ; $019C4C

loc_019C52:
        move.w       #$4, d0                                       ; $019C52
        move.w       #$1, d2                                       ; $019C56
        jmp          DrawActorAnimation.l                          ; $019C5A

loc_019C60:
        move.w       #$4, d0                                       ; $019C60
        move.w       #$2, d2                                       ; $019C64
        jmp          DrawActorAnimation.l                          ; $019C68

loc_019C6E:
        move.w       #$4, d0                                       ; $019C6E
        move.w       #$3, d2                                       ; $019C72
        jmp          DrawActorAnimation.l                          ; $019C76

loc_019C7C:
        move.w       #$4, d0                                       ; $019C7C
        move.w       #$3, d2                                       ; $019C80
        jmp          DrawActorAnimation.l                          ; $019C84

BeatressSkipStateSixDrawing:
        rts                                                        ; $019C8A
        ifne *-$19C8C
        fail "ROM end moved"
        endif
