; $01B88A..$01B931 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Wake counter12..1 selects animation4 frames1,1,2,2,3,3,4,4,5,5,6,6. Counter4/3 has draw-side Z=$20.
        ifne *-$1B88A
        fail "ROM start moved"
        endif

DrawDenpyderWake:
; Wake counter12..1 selects animation4 frames1,1,2,2,3,3,4,4,5,5,6,6. Counter4/3 has draw-side Z=$20.
        move.b       ActorStateCounter(a0), d7                     ; $01B88A
        cmpi.b       #$c, d7                                       ; $01B88E
        beq.b        loc_01B8D8                                    ; $01B892
        cmpi.b       #$b, d7                                       ; $01B894
        beq.b        loc_01B8D8                                    ; $01B898
        cmpi.b       #$a, d7                                       ; $01B89A
        beq.b        loc_01B8E6                                    ; $01B89E
        cmpi.b       #$9, d7                                       ; $01B8A0
        beq.b        loc_01B8E6                                    ; $01B8A4
        cmpi.b       #$8, d7                                       ; $01B8A6
        beq.b        loc_01B8F4                                    ; $01B8AA
        cmpi.b       #$7, d7                                       ; $01B8AC
        beq.b        loc_01B8F4                                    ; $01B8B0
        cmpi.b       #$6, d7                                       ; $01B8B2
        beq.b        loc_01B902                                    ; $01B8B6
        cmpi.b       #$5, d7                                       ; $01B8B8
        beq.b        loc_01B902                                    ; $01B8BC
        cmpi.b       #$4, d7                                       ; $01B8BE
        beq.b        loc_01B910                                    ; $01B8C2
        cmpi.b       #$3, d7                                       ; $01B8C4
        beq.b        loc_01B910                                    ; $01B8C8
        cmpi.b       #$2, d7                                       ; $01B8CA
        beq.b        loc_01B924                                    ; $01B8CE
        cmpi.b       #$1, d7                                       ; $01B8D0
        beq.b        loc_01B924                                    ; $01B8D4
        rts                                                        ; $01B8D6

loc_01B8D8:
        move.w       #$4, d0                                       ; $01B8D8
        move.w       #$1, d2                                       ; $01B8DC
        jmp          DrawActorAnimation.l                          ; $01B8E0

loc_01B8E6:
        move.w       #$4, d0                                       ; $01B8E6
        move.w       #$2, d2                                       ; $01B8EA
        jmp          DrawActorAnimation.l                          ; $01B8EE

loc_01B8F4:
        move.w       #$4, d0                                       ; $01B8F4
        move.w       #$3, d2                                       ; $01B8F8
        jmp          DrawActorAnimation.l                          ; $01B8FC

loc_01B902:
        move.w       #$4, d0                                       ; $01B902
        move.w       #$4, d2                                       ; $01B906
        jmp          DrawActorAnimation.l                          ; $01B90A

loc_01B910:
        move.w       #$4, d0                                       ; $01B910
        move.w       #$5, d2                                       ; $01B914
        move.w       #$20, ActorZ(a0)                              ; $01B918
        jmp          DrawActorAnimation.l                          ; $01B91E

loc_01B924:
        move.w       #$4, d0                                       ; $01B924
        move.w       #$6, d2                                       ; $01B928
        jmp          DrawActorAnimation.l                          ; $01B92C
        ifne *-$1B932
        fail "ROM end moved"
        endif
