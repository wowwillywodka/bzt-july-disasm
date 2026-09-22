; $01B9BC..$01BA8B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1B9BC
        fail "ROM start moved"
        endif

RetainedActorFrameEvents_01B9BC:
        move.b       ActorStateCounter(a0), d7                     ; $01B9BC
        cmpi.b       #$5, d7                                       ; $01B9C0
        beq.b        loc_01B9E0                                    ; $01B9C4
        cmpi.b       #$4, d7                                       ; $01B9C6
        beq.b        loc_01B9EE                                    ; $01B9CA
        cmpi.b       #$3, d7                                       ; $01B9CC
        beq.b        loc_01B9FC                                    ; $01B9D0
        cmpi.b       #$2, d7                                       ; $01B9D2
        beq.b        loc_01BA0A                                    ; $01B9D6
        cmpi.b       #$1, d7                                       ; $01B9D8
        beq.b        loc_01BA18                                    ; $01B9DC
        rts                                                        ; $01B9DE

loc_01B9E0:
        move.w       #$7, d0                                       ; $01B9E0
        move.w       #$1, d2                                       ; $01B9E4
        jmp          DrawActorAnimation.l                          ; $01B9E8

loc_01B9EE:
        move.w       #$7, d0                                       ; $01B9EE
        move.w       #$2, d2                                       ; $01B9F2
        jmp          DrawActorAnimation.l                          ; $01B9F6

loc_01B9FC:
        move.w       #$7, d0                                       ; $01B9FC
        move.w       #$3, d2                                       ; $01BA00
        jmp          DrawActorAnimation.l                          ; $01BA04

loc_01BA0A:
        move.w       #$7, d0                                       ; $01BA0A
        move.w       #$4, d2                                       ; $01BA0E
        jmp          DrawActorAnimation.l                          ; $01BA12

loc_01BA18:
        move.w       #$7, d0                                       ; $01BA18
        move.w       #$5, d2                                       ; $01BA1C
        jmp          DrawActorAnimation.l                          ; $01BA20
        move.b       ActorStateCounter(a0), d7                     ; $01BA26
        cmpi.b       #$9, d7                                       ; $01BA2A
        beq.b        loc_01BA62                                    ; $01BA2E
        cmpi.b       #$8, d7                                       ; $01BA30
        beq.b        loc_01BA62                                    ; $01BA34
        cmpi.b       #$7, d7                                       ; $01BA36
        beq.b        loc_01BA70                                    ; $01BA3A
        cmpi.b       #$6, d7                                       ; $01BA3C
        beq.b        loc_01BA70                                    ; $01BA40
        cmpi.b       #$5, d7                                       ; $01BA42
        beq.b        loc_01BA7E                                    ; $01BA46
        cmpi.b       #$4, d7                                       ; $01BA48
        beq.b        loc_01BA70                                    ; $01BA4C
        cmpi.b       #$3, d7                                       ; $01BA4E
        beq.b        loc_01BA70                                    ; $01BA52
        cmpi.b       #$2, d7                                       ; $01BA54
        beq.b        loc_01BA62                                    ; $01BA58
        cmpi.b       #$1, d7                                       ; $01BA5A
        beq.b        loc_01BA62                                    ; $01BA5E
        rts                                                        ; $01BA60

loc_01BA62:
        move.w       #$7, d0                                       ; $01BA62
        move.w       #$1, d2                                       ; $01BA66
        jmp          DrawActorAnimation.l                          ; $01BA6A

loc_01BA70:
        move.w       #$7, d0                                       ; $01BA70
        move.w       #$2, d2                                       ; $01BA74
        jmp          DrawActorAnimation.l                          ; $01BA78

loc_01BA7E:
        move.w       #$7, d0                                       ; $01BA7E
        move.w       #$3, d2                                       ; $01BA82
        jmp          DrawActorAnimation.l                          ; $01BA86
        ifne *-$1BA8C
        fail "ROM end moved"
        endif
