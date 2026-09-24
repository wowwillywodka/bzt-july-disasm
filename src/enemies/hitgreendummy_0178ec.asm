; $0178EC..$017997 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Same hit/recoil and weapon-forced death contract as Grey Dummy; statistics precede distance rejection.
        ifne *-$178EC
        fail "ROM start moved"
        endif

HitGreenDummy:
; Same hit/recoil and weapon-forced death contract as Grey Dummy; statistics precede distance rejection.
        cmpi.b       #$2, ActorState(a0)                           ; $0178EC
        beq.w        loc_01790E                                    ; $0178F2
        cmpi.b       #$5, ActorState(a0)                           ; $0178F6
        beq.w        loc_01790E                                    ; $0178FC
        cmpi.b       #$6, ActorState(a0)                           ; $017900
        beq.w        loc_01790E                                    ; $017906
        bra.w        loc_017910                                    ; $01790A

loc_01790E:
        rts                                                        ; $01790E

loc_017910:
        addq.w       #$1, rEnemyHitCallbacksRecorded(a6)                               ; $017910
        clr.b        ActorStateCounter(a0)                         ; $017914
        clr.w        ActorMotionX(a0)                              ; $017918
        clr.w        ActorMotionY(a0)                              ; $01791C
        neg.w        d3                                            ; $017920
        neg.w        d4                                            ; $017922
        move.w       d0, -(a7)                                     ; $017924
        move.w       d3, d0                                        ; $017926
        move.w       d4, d1                                        ; $017928
        jsr          OctagonalDistance.l                           ; $01792A
        ext.l        d3                                            ; $017930
        ext.l        d4                                            ; $017932
        lsl.l        #$8, d3                                       ; $017934
        lsl.l        #$8, d4                                       ; $017936
        addq.w       #$1, d0                                       ; $017938
        beq.b        loc_017940                                    ; $01793A
        divs.w       d0, d3                                        ; $01793C
        divs.w       d0, d4                                        ; $01793E

loc_017940:
        move.w       #$400, d0                                     ; $017940
        sub.w        (a7)+, d0                                     ; $017944
        bmi.b        loc_01797A                                    ; $017946
        sub.w        d0, ActorHealth(a0)                           ; $017948
        bsr.w        SpawnHitParticles                          ; $01794C
        asr.w        #$3, d0                                       ; $017950
        muls.w       d0, d3                                        ; $017952
        muls.w       d0, d4                                        ; $017954
        asr.l        #$8, d3                                       ; $017956
        asr.l        #$8, d4                                       ; $017958
        move.w       d3, ActorMotionX(a0)                          ; $01795A
        move.w       d4, ActorMotionY(a0)                          ; $01795E
        cmpi.b       #$d, rCurrentWeaponId(a6)                     ; $017962
        beq.b        loc_01797C                                    ; $017968
        cmpi.b       #$b, rCurrentWeaponId(a6)                     ; $01796A
        beq.w        loc_01798A                                    ; $017970
        move.b       #$2, ActorState(a0)                           ; $017974

loc_01797A:
        rts                                                        ; $01797A

loc_01797C:
        move.b       #$5, ActorState(a0)                           ; $01797C
        move.b       #$8, ActorStateCounter(a0)                    ; $017982
        rts                                                        ; $017988

loc_01798A:
        move.b       #$6, ActorState(a0)                           ; $01798A
        move.b       #$6, ActorStateCounter(a0)                    ; $017990
        rts                                                        ; $017996
        ifne *-$17998
        fail "ROM end moved"
        endif
