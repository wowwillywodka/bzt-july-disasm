; $01AF5A..$01AFBF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active attack1 frame selection, reached from $1AE3A.
        ifne *-$1AF5A
        fail "ROM start moved"
        endif

DrawGunnerAttack:
; Active attack1 frame selection, reached from $1AE3A.
        move.b       ActorStateCounter(a0), d7                     ; $01AF5A
        cmpi.b       #$9, d7                                       ; $01AF5E
        beq.b        loc_01AF96                                    ; $01AF62
        cmpi.b       #$8, d7                                       ; $01AF64
        beq.b        loc_01AF96                                    ; $01AF68
        cmpi.b       #$7, d7                                       ; $01AF6A
        beq.b        loc_01AFA4                                    ; $01AF6E
        cmpi.b       #$6, d7                                       ; $01AF70
        beq.b        loc_01AFA4                                    ; $01AF74
        cmpi.b       #$5, d7                                       ; $01AF76
        beq.b        loc_01AFB2                                    ; $01AF7A
        cmpi.b       #$4, d7                                       ; $01AF7C
        beq.b        loc_01AFA4                                    ; $01AF80
        cmpi.b       #$3, d7                                       ; $01AF82
        beq.b        loc_01AFA4                                    ; $01AF86
        cmpi.b       #$2, d7                                       ; $01AF88
        beq.b        loc_01AF96                                    ; $01AF8C
        cmpi.b       #$1, d7                                       ; $01AF8E
        beq.b        loc_01AF96                                    ; $01AF92
        rts                                                        ; $01AF94

loc_01AF96:
        move.w       #$1, d0                                       ; $01AF96
        move.w       #$1, d2                                       ; $01AF9A
        jmp          DrawActorAnimation.l                          ; $01AF9E

loc_01AFA4:
        move.w       #$1, d0                                       ; $01AFA4
        move.w       #$2, d2                                       ; $01AFA8
        jmp          DrawActorAnimation.l                          ; $01AFAC

loc_01AFB2:
        move.w       #$1, d0                                       ; $01AFB2
        move.w       #$3, d2                                       ; $01AFB6
        jmp          DrawActorAnimation.l                          ; $01AFBA
        ifne *-$1AFC0
        fail "ROM end moved"
        endif
