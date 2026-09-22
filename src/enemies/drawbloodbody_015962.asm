; $015962..$015AF7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Selects animations 0/2/3/5/6/7; state-specific frame lookup is documented and tested. Animation 1 is not selected by this callback.
        ifne *-$15962
        fail "ROM start moved"
        endif

DrawBloodBody:
; Selects animations 0/2/3/5/6/7; state-specific frame lookup is documented and tested. Animation 1 is not selected by this callback.
        move.b       ActorState(a0), d7                            ; $015962
        cmpi.b       #$2, d7                                       ; $015966
        beq.b        loc_015990                                    ; $01596A
        cmpi.b       #$1, d7                                       ; $01596C
        beq.w        loc_015A92                                    ; $015970
        cmpi.b       #$5, d7                                       ; $015974
        beq.b        loc_0159B2                                    ; $015978
        cmpi.b       #$6, d7                                       ; $01597A
        beq.w        loc_015A28                                    ; $01597E
        move.w       #$0, d0                                       ; $015982
        move.w       #$ffff, d2                                    ; $015986
        jmp          DrawActorAnimation.l                          ; $01598A

loc_015990:
        tst.w        ActorHealth(a0)                               ; $015990
        bmi.b        loc_0159A4                                    ; $015994
        move.w       #$7, d0                                       ; $015996
        move.w       #$1, d2                                       ; $01599A
        jmp          DrawActorAnimation.l                          ; $01599E

loc_0159A4:
        move.w       #$5, d0                                       ; $0159A4
        move.w       #$1, d2                                       ; $0159A8
        jmp          DrawActorAnimation.l                          ; $0159AC

loc_0159B2:
        move.b       ActorStateCounter(a0), d7                     ; $0159B2
        cmpi.b       #$7, d7                                       ; $0159B6
        beq.b        loc_0159E2                                    ; $0159BA
        cmpi.b       #$6, d7                                       ; $0159BC
        beq.b        loc_0159E2                                    ; $0159C0
        cmpi.b       #$5, d7                                       ; $0159C2
        beq.b        loc_0159F0                                    ; $0159C6
        cmpi.b       #$4, d7                                       ; $0159C8
        beq.b        loc_0159F0                                    ; $0159CC
        cmpi.b       #$3, d7                                       ; $0159CE
        beq.b        loc_0159FE                                    ; $0159D2
        cmpi.b       #$2, d7                                       ; $0159D4
        beq.b        loc_015A0C                                    ; $0159D8
        cmpi.b       #$1, d7                                       ; $0159DA
        beq.b        loc_015A1A                                    ; $0159DE
        rts                                                        ; $0159E0

loc_0159E2:
        move.w       #$7, d0                                       ; $0159E2
        move.w       #$1, d2                                       ; $0159E6
        jmp          DrawActorAnimation.l                          ; $0159EA

loc_0159F0:
        move.w       #$6, d0                                       ; $0159F0
        move.w       #$1, d2                                       ; $0159F4
        jmp          DrawActorAnimation.l                          ; $0159F8

loc_0159FE:
        move.w       #$6, d0                                       ; $0159FE
        move.w       #$2, d2                                       ; $015A02
        jmp          DrawActorAnimation.l                          ; $015A06

loc_015A0C:
        move.w       #$6, d0                                       ; $015A0C
        move.w       #$3, d2                                       ; $015A10
        jmp          DrawActorAnimation.l                          ; $015A14

loc_015A1A:
        move.w       #$6, d0                                       ; $015A1A
        move.w       #$4, d2                                       ; $015A1E
        jmp          DrawActorAnimation.l                          ; $015A22

loc_015A28:
        move.b       ActorStateCounter(a0), d7                     ; $015A28
        cmpi.b       #$5, d7                                       ; $015A2C
        beq.b        loc_015A4C                                    ; $015A30
        cmpi.b       #$4, d7                                       ; $015A32
        beq.b        loc_015A5A                                    ; $015A36
        cmpi.b       #$3, d7                                       ; $015A38
        beq.b        loc_015A68                                    ; $015A3C
        cmpi.b       #$2, d7                                       ; $015A3E
        beq.b        loc_015A76                                    ; $015A42
        cmpi.b       #$1, d7                                       ; $015A44
        beq.b        loc_015A84                                    ; $015A48
        rts                                                        ; $015A4A

loc_015A4C:
        move.w       #$3, d0                                       ; $015A4C
        move.w       #$1, d2                                       ; $015A50
        jmp          DrawActorAnimation.l                          ; $015A54

loc_015A5A:
        move.w       #$3, d0                                       ; $015A5A
        move.w       #$2, d2                                       ; $015A5E
        jmp          DrawActorAnimation.l                          ; $015A62

loc_015A68:
        move.w       #$3, d0                                       ; $015A68
        move.w       #$3, d2                                       ; $015A6C
        jmp          DrawActorAnimation.l                          ; $015A70

loc_015A76:
        move.w       #$3, d0                                       ; $015A76
        move.w       #$4, d2                                       ; $015A7A
        jmp          DrawActorAnimation.l                          ; $015A7E

loc_015A84:
        move.w       #$3, d0                                       ; $015A84
        move.w       #$5, d2                                       ; $015A88
        jmp          DrawActorAnimation.l                          ; $015A8C

loc_015A92:
        move.b       ActorStateCounter(a0), d7                     ; $015A92
        cmpi.b       #$9, d7                                       ; $015A96
        beq.b        loc_015ACE                                    ; $015A9A
        cmpi.b       #$8, d7                                       ; $015A9C
        beq.b        loc_015ACE                                    ; $015AA0
        cmpi.b       #$7, d7                                       ; $015AA2
        beq.b        loc_015ADC                                    ; $015AA6
        cmpi.b       #$6, d7                                       ; $015AA8
        beq.b        loc_015ADC                                    ; $015AAC
        cmpi.b       #$5, d7                                       ; $015AAE
        beq.b        loc_015AEA                                    ; $015AB2
        cmpi.b       #$4, d7                                       ; $015AB4
        beq.b        loc_015ADC                                    ; $015AB8
        cmpi.b       #$3, d7                                       ; $015ABA
        beq.b        loc_015ADC                                    ; $015ABE
        cmpi.b       #$2, d7                                       ; $015AC0
        beq.b        loc_015ACE                                    ; $015AC4
        cmpi.b       #$1, d7                                       ; $015AC6
        beq.b        loc_015ACE                                    ; $015ACA
        rts                                                        ; $015ACC

loc_015ACE:
        move.w       #$2, d0                                       ; $015ACE
        move.w       #$1, d2                                       ; $015AD2
        jmp          DrawActorAnimation.l                          ; $015AD6

loc_015ADC:
        move.w       #$2, d0                                       ; $015ADC
        move.w       #$2, d2                                       ; $015AE0
        jmp          DrawActorAnimation.l                          ; $015AE4

loc_015AEA:
        move.w       #$2, d0                                       ; $015AEA
        move.w       #$3, d2                                       ; $015AEE
        jmp          DrawActorAnimation.l                          ; $015AF2
        ifne *-$15AF8
        fail "ROM end moved"
        endif
