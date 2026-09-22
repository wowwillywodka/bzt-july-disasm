; $01AD62..$01AE2B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Sound$1B; installs corpse callbacks and ALWAYS overwrites mode with CB/counter11, including state5/6 special-death entries. Exit delay is armed later by drawing, not here.
        ifne *-$1AD62
        fail "ROM start moved"
        endif

EnterGunnerDeath:
; Sound$1B; installs corpse callbacks and ALWAYS overwrites mode with CB/counter11, including state5/6 special-death entries. Exit delay is armed later by drawing, not here.
        move.l       a0, -(a7)                                     ; $01AD62
        move.w       #$1b, d0                                      ; $01AD64
        jsr          SoundRoutine_00DF64.l                         ; $01AD68
        movea.l      (a7)+, a0                                     ; $01AD6E
        tst.b        ActorAlternateDeathSignal(a0)                 ; $01AD70
        bne.w        EnterLegacyEnemyDeathEffect                   ; $01AD74
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01AD78
        move.l       #UpdateGunnerCorpse, ActorUpdateCallback(a0)  ; $01AD7E
        addq.w       #$1, -$71c8(a6)                               ; $01AD86
        clr.b        ActorUpdateDelay(a0)                          ; $01AD8A
        move.l       #HitGunnerCorpse, ActorHitCallback(a0)        ; $01AD8E
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $01AD96
        tst.b        ActorMarkerTracked(a0)                        ; $01AD9E
        beq.b        loc_01ADAC                                    ; $01ADA2
        move.l       #EnvironmentRoutine_097964, ActorExitCallback(a0) ; $01ADA4

loc_01ADAC:
        move.l       #DrawGunnerCorpse, ActorDrawCallback(a0)      ; $01ADAC
        clr.w        ActorMotionX(a0)                              ; $01ADB4
        clr.w        ActorMotionY(a0)                              ; $01ADB8
        move.b       #$3, ActorState(a0)                           ; $01ADBC
        move.b       #$cb, ActorDeathMode(a0)                      ; $01ADC2
        move.b       #$b, ActorStateCounter(a0)                    ; $01ADC8
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $01ADCE
        tst.w        rLinkRole(a6)                                 ; $01ADD4
        bne.b        loc_01ADDC                                    ; $01ADD8
        rts                                                        ; $01ADDA

loc_01ADDC:
        move.l       #$1ef78, ActorLinkCallback(a0)                ; $01ADDC
        lea.l        -$6fdc(a6), a1                                ; $01ADE4
        move.b       #$12, (a1)+                                   ; $01ADE8
        move.b       ActorLinkId(a0), (a1)+                        ; $01ADEC
        move.w       ActorFlags(a0), d0                            ; $01ADF0
        ori.w        #$20, d0                                      ; $01ADF4
        move.b       d0, (a1)+                                     ; $01ADF8
        move.b       ActorFloor(a0), (a1)+                         ; $01ADFA
        lea.l        -$6fdc(a6), a0                                ; $01ADFE
        jmp          QueueLinkCommand.l                            ; $01AE02

GunnerTickWeaponDeath:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01AE08
        bne.w        loc_01AE1A                                    ; $01AE0C
        move.b       #$c8, ActorDeathMode(a0)                      ; $01AE10
        bra.w        EnterGunnerDeath                              ; $01AE16

loc_01AE1A:
        rts                                                        ; $01AE1A

GunnerTickUnassignedStateSix:
        subq.b       #$1, ActorStateCounter(a0)                    ; $01AE1C
        bne.b        loc_01AE1A                                    ; $01AE20
        move.b       #$c9, ActorDeathMode(a0)                      ; $01AE22
        bra.w        EnterGunnerDeath                              ; $01AE28
        ifne *-$1AE2C
        fail "ROM end moved"
        endif
