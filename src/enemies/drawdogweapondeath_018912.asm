; $018912..$018989 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State5: counters7/6 ->2/1;5/4 ->5/1;3,2,1 ->5/2,3,4. These frames exist.
        ifne *-$18912
        fail "ROM start moved"
        endif

DrawDogWeaponDeath:
; State5: counters7/6 ->2/1;5/4 ->5/1;3,2,1 ->5/2,3,4. These frames exist.
        move.b       ActorStateCounter(a0), d7                     ; $018912
        cmpi.b       #$7, d7                                       ; $018916
        beq.b        loc_018942                                    ; $01891A
        cmpi.b       #$6, d7                                       ; $01891C
        beq.b        loc_018942                                    ; $018920
        cmpi.b       #$5, d7                                       ; $018922
        beq.b        loc_018950                                    ; $018926
        cmpi.b       #$4, d7                                       ; $018928
        beq.b        loc_018950                                    ; $01892C
        cmpi.b       #$3, d7                                       ; $01892E
        beq.b        loc_01895E                                    ; $018932
        cmpi.b       #$2, d7                                       ; $018934
        beq.b        loc_01896C                                    ; $018938
        cmpi.b       #$1, d7                                       ; $01893A
        beq.b        loc_01897A                                    ; $01893E
        rts                                                        ; $018940

loc_018942:
        move.w       #$2, d0                                       ; $018942
        move.w       #$1, d2                                       ; $018946
        jmp          DrawActorAnimation.l                          ; $01894A

loc_018950:
        move.w       #$5, d0                                       ; $018950
        move.w       #$1, d2                                       ; $018954
        jmp          DrawActorAnimation.l                          ; $018958

loc_01895E:
        move.w       #$5, d0                                       ; $01895E
        move.w       #$2, d2                                       ; $018962
        jmp          DrawActorAnimation.l                          ; $018966

loc_01896C:
        move.w       #$5, d0                                       ; $01896C
        move.w       #$3, d2                                       ; $018970
        jmp          DrawActorAnimation.l                          ; $018974

loc_01897A:
        move.w       #$5, d0                                       ; $01897A
        move.w       #$4, d2                                       ; $01897E
        jmp          DrawActorAnimation.l                          ; $018982

DogSkipStateSixDrawing:
        rts                                                        ; $018988
        ifne *-$1898A
        fail "ROM end moved"
        endif
