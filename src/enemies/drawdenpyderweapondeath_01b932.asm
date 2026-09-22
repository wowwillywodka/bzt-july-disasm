; $01B932..$01B9BB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; State5 frames2/1 then3/1..3; draw writes Z=0 at counter3 and -$20 at2/1. State6 returns before retained animation7 code; Denpyder bank only has0..4.
        ifne *-$1B932
        fail "ROM start moved"
        endif

DrawDenpyderWeaponDeath:
; State5 frames2/1 then3/1..3; draw writes Z=0 at counter3 and -$20 at2/1. State6 returns before retained animation7 code; Denpyder bank only has0..4.
        move.b       ActorStateCounter(a0), d7                     ; $01B932
        cmpi.b       #$7, d7                                       ; $01B936
        beq.b        loc_01B962                                    ; $01B93A
        cmpi.b       #$6, d7                                       ; $01B93C
        beq.b        loc_01B962                                    ; $01B940
        cmpi.b       #$5, d7                                       ; $01B942
        beq.b        loc_01B970                                    ; $01B946
        cmpi.b       #$4, d7                                       ; $01B948
        beq.b        loc_01B970                                    ; $01B94C
        cmpi.b       #$3, d7                                       ; $01B94E
        beq.b        loc_01B97E                                    ; $01B952
        cmpi.b       #$2, d7                                       ; $01B954
        beq.b        loc_01B992                                    ; $01B958
        cmpi.b       #$1, d7                                       ; $01B95A
        beq.b        loc_01B9A6                                    ; $01B95E
        rts                                                        ; $01B960

loc_01B962:
        move.w       #$2, d0                                       ; $01B962
        move.w       #$1, d2                                       ; $01B966
        jmp          DrawActorAnimation.l                          ; $01B96A

loc_01B970:
        move.w       #$3, d0                                       ; $01B970
        move.w       #$1, d2                                       ; $01B974
        jmp          DrawActorAnimation.l                          ; $01B978

loc_01B97E:
        move.w       #$3, d0                                       ; $01B97E
        move.w       #$2, d2                                       ; $01B982
        move.w       #$0, ActorZ(a0)                               ; $01B986
        jmp          DrawActorAnimation.l                          ; $01B98C

loc_01B992:
        move.w       #$3, d0                                       ; $01B992
        move.w       #$3, d2                                       ; $01B996
        move.w       #$ffe0, ActorZ(a0)                            ; $01B99A
        jmp          DrawActorAnimation.l                          ; $01B9A0

loc_01B9A6:
        move.w       #$3, d0                                       ; $01B9A6
        move.w       #$3, d2                                       ; $01B9AA
        move.w       #$ffe0, ActorZ(a0)                            ; $01B9AE
        jmp          DrawActorAnimation.l                          ; $01B9B4

DenpyderSkipStateSixDrawing:
        rts                                                        ; $01B9BA
        ifne *-$1B9BC
        fail "ROM end moved"
        endif
