; $01BCE8..$01BDC3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Dormant7 hit only increments statistic, clears motion, sets8/counter12; ignores input distance/weapon and causes no HP loss. State8 ignores hits. Other ordinary states take half damage; both special weapons force5/8.
        ifne *-$1BCE8
        fail "ROM start moved"
        endif

HitDenpyder:
; Dormant7 hit only increments statistic, clears motion, sets8/counter12; ignores input distance/weapon and causes no HP loss. State8 ignores hits. Other ordinary states take half damage; both special weapons force5/8.
        cmpi.b       #$2, ActorState(a0)                           ; $01BCE8
        beq.w        loc_01BD1E                                    ; $01BCEE
        cmpi.b       #$5, ActorState(a0)                           ; $01BCF2
        beq.w        loc_01BD1E                                    ; $01BCF8
        cmpi.b       #$6, ActorState(a0)                           ; $01BCFC
        beq.w        loc_01BD1E                                    ; $01BD02
        cmpi.b       #$7, ActorState(a0)                           ; $01BD06
        beq.w        WakeDenpyderWithoutDamage                     ; $01BD0C
        cmpi.b       #$8, ActorState(a0)                           ; $01BD10
        beq.w        loc_01BD1E                                    ; $01BD16
        bra.w        loc_01BD3A                                    ; $01BD1A

loc_01BD1E:
        rts                                                        ; $01BD1E

WakeDenpyderWithoutDamage:
; Wake only, no damage/particles/range rejection; not normal recoil.
        addq.w       #$1, -$71c2(a6)                               ; $01BD20
        move.b       #$c, ActorStateCounter(a0)                    ; $01BD24
        clr.w        ActorMotionX(a0)                              ; $01BD2A
        clr.w        ActorMotionY(a0)                              ; $01BD2E
        move.b       #$8, ActorState(a0)                           ; $01BD32
        rts                                                        ; $01BD38

loc_01BD3A:
        addq.w       #$1, -$71c2(a6)                               ; $01BD3A
        clr.b        ActorStateCounter(a0)                         ; $01BD3E
        clr.w        ActorMotionX(a0)                              ; $01BD42
        clr.w        ActorMotionY(a0)                              ; $01BD46
        neg.w        d3                                            ; $01BD4A
        neg.w        d4                                            ; $01BD4C
        move.w       d0, -(a7)                                     ; $01BD4E
        move.w       d3, d0                                        ; $01BD50
        move.w       d4, d1                                        ; $01BD52
        jsr          OctagonalDistance.l                           ; $01BD54
        ext.l        d3                                            ; $01BD5A
        ext.l        d4                                            ; $01BD5C
        lsl.l        #$8, d3                                       ; $01BD5E
        lsl.l        #$8, d4                                       ; $01BD60
        addq.w       #$1, d0                                       ; $01BD62
        beq.b        loc_01BD6A                                    ; $01BD64
        divs.w       d0, d3                                        ; $01BD66
        divs.w       d0, d4                                        ; $01BD68

loc_01BD6A:
        move.w       #$400, d0                                     ; $01BD6A
        sub.w        (a7)+, d0                                     ; $01BD6E
        bmi.b        loc_01BDA6                                    ; $01BD70
        asr.w        #$1, d0                                       ; $01BD72
        sub.w        d0, ActorHealth(a0)                           ; $01BD74
        bsr.w        ActorsRoutine_01D92C                          ; $01BD78
        asr.w        #$3, d0                                       ; $01BD7C
        muls.w       d0, d3                                        ; $01BD7E
        muls.w       d0, d4                                        ; $01BD80
        asr.l        #$8, d3                                       ; $01BD82
        asr.l        #$8, d4                                       ; $01BD84
        move.w       d3, ActorMotionX(a0)                          ; $01BD86
        move.w       d4, ActorMotionY(a0)                          ; $01BD8A
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $01BD8E
        beq.b        loc_01BDA8                                    ; $01BD94
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $01BD96
        beq.w        loc_01BDB6                                    ; $01BD9C
        move.b       #$2, ActorState(a0)                           ; $01BDA0

loc_01BDA6:
        rts                                                        ; $01BDA6

loc_01BDA8:
        move.b       #$5, ActorState(a0)                           ; $01BDA8
        move.b       #$8, ActorStateCounter(a0)                    ; $01BDAE
        rts                                                        ; $01BDB4

loc_01BDB6:
        move.b       #$5, ActorState(a0)                           ; $01BDB6
        move.b       #$8, ActorStateCounter(a0)                    ; $01BDBC
        rts                                                        ; $01BDC2
        ifne *-$1BDC4
        fail "ROM end moved"
        endif
