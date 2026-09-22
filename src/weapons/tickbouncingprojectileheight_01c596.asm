; $01C596..$01C60D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Z+=VelocityZ. Above -24: VelocityZ-=3. At/below -24 clamp Z; nonzero old velocity bounces as (-(v-3)) ASR2, then UNSIGNED compare<3 zeroes tiny results.
        ifne *-$1C596
        fail "ROM start moved"
        endif

TickBouncingProjectileHeight:
; Z+=VelocityZ. Above -24: VelocityZ-=3. At/below -24 clamp Z; nonzero old velocity bounces as (-(v-3)) ASR2, then UNSIGNED compare<3 zeroes tiny results.
        move.w       ActorVelocityZ(a0), d0                        ; $01C596
        add.w        d0, ActorZ(a0)                                ; $01C59A
        cmpi.w       #$ffe8, ActorZ(a0)                            ; $01C59E
        bgt.w        loc_01C5B6                                    ; $01C5A4
        move.w       #$ffe8, ActorZ(a0)                            ; $01C5A8
        tst.w        d0                                            ; $01C5AE
        beq.w        DampGroundedProjectileMotion                  ; $01C5B0
        bra.b        BounceProjectileFromGround                    ; $01C5B4

loc_01C5B6:
        subq.w       #$3, d0                                       ; $01C5B6
        move.w       d0, ActorVelocityZ(a0)                        ; $01C5B8
        bra.b        TickBouncingProjectileFuse                    ; $01C5BC

BounceProjectileFromGround:
        subq.w       #$3, d0                                       ; $01C5BE
        neg.w        d0                                            ; $01C5C0
        asr.w        #$2, d0                                       ; $01C5C2
        cmpi.w       #$3, d0                                       ; $01C5C4
        bcc.b        loc_01C5CC                                    ; $01C5C8
        clr.w        d0                                            ; $01C5CA

loc_01C5CC:
        move.w       d0, ActorVelocityZ(a0)                        ; $01C5CC
        move.w       #$63, d0                                      ; $01C5D0
        move.l       a0, -(a7)                                     ; $01C5D4
        jsr          SoundRoutine_00DF64.l                         ; $01C5D6
        movea.l      (a7)+, a0                                     ; $01C5DC

DampGroundedProjectileMotion:
; At Z=-24 halve each horizontal component toward zero, AFTER this tick XY was committed. Ground sound may repeat on nonzero vertical velocity.
        cmpi.w       #$ffe8, ActorZ(a0)                            ; $01C5DE
        bne.b        TickBouncingProjectileFuse                    ; $01C5E4
        move.w       ActorMotionX(a0), d0                          ; $01C5E6
        bpl.b        loc_01C5F4                                    ; $01C5EA
        neg.w        d0                                            ; $01C5EC
        asr.w        #$1, d0                                       ; $01C5EE
        neg.w        d0                                            ; $01C5F0
        bra.b        loc_01C5F6                                    ; $01C5F2

loc_01C5F4:
        asr.w        #$1, d0                                       ; $01C5F4

loc_01C5F6:
        move.w       d0, ActorMotionX(a0)                          ; $01C5F6
        move.w       ActorMotionY(a0), d0                          ; $01C5FA
        bpl.b        loc_01C608                                    ; $01C5FE
        neg.w        d0                                            ; $01C600
        asr.w        #$1, d0                                       ; $01C602
        neg.w        d0                                            ; $01C604
        bra.b        loc_01C60A                                    ; $01C606

loc_01C608:
        asr.w        #$1, d0                                       ; $01C608

loc_01C60A:
        move.w       d0, ActorMotionY(a0)                          ; $01C60A
        ifne *-$1C60E
        fail "ROM end moved"
        endif
