; $016EE4..$017051 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse CB->CC; state countdown then CA/state3. C8/C9 skip pickup. Local item0C, quantity2/3, BULIGUN message; remote command13 uses item08.
        ifne *-$16EE4
        fail "ROM start moved"
        endif

UpdateGreyDummyCorpse:
; Corpse CB->CC; state countdown then CA/state3. C8/C9 skip pickup. Local item0C, quantity2/3, BULIGUN message; remote command13 uses item08.
        clr.b        ActorUpdateDelay(a0)                          ; $016EE4
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $016EE8
        beq.w        loc_016F22                                    ; $016EEE
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $016EF2
        beq.w        loc_016F30                                    ; $016EF8
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $016EFC
        beq.w        loc_016F1E                                    ; $016F02
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016F06
        beq.w        loc_016F1E                                    ; $016F0C
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $016F10
        beq.w        loc_016F46                                    ; $016F16
        bra.w        loc_016F46                                    ; $016F1A

loc_016F1E:
        bra.w        loc_016F46                                    ; $016F1E

loc_016F22:
        move.b       #$cc, ActorDeathMode(a0)                      ; $016F22
        move.b       #$1, ActorStateCounter(a0)                    ; $016F28
        rts                                                        ; $016F2E

loc_016F30:
        subq.b       #$1, ActorState(a0)                           ; $016F30
        bne.w        loc_016F44                                    ; $016F34
        move.b       #$ca, ActorDeathMode(a0)                      ; $016F38
        move.b       #$3, ActorState(a0)                           ; $016F3E

loc_016F44:
        rts                                                        ; $016F44

loc_016F46:
        move.w       ActorMotionX(a0), d0                          ; $016F46
        bmi.b        loc_016F50                                    ; $016F4A
        asr.w        #$1, d0                                       ; $016F4C
        bra.b        loc_016F56                                    ; $016F4E

loc_016F50:
        neg.w        d0                                            ; $016F50
        asr.w        #$1, d0                                       ; $016F52
        neg.w        d0                                            ; $016F54

loc_016F56:
        move.w       d0, ActorMotionX(a0)                          ; $016F56
        move.w       ActorMotionY(a0), d1                          ; $016F5A
        bmi.b        loc_016F64                                    ; $016F5E
        asr.w        #$1, d1                                       ; $016F60
        bra.b        loc_016F6A                                    ; $016F62

loc_016F64:
        neg.w        d1                                            ; $016F64
        asr.w        #$1, d1                                       ; $016F66
        neg.w        d1                                            ; $016F68

loc_016F6A:
        move.w       d1, ActorMotionY(a0)                          ; $016F6A
        move.w       d0, d2                                        ; $016F6E
        or.w         d1, d2                                        ; $016F70
        beq.b        loc_016F80                                    ; $016F72
        move.w       d0, ActorMotionX(a0)                          ; $016F74
        move.w       d1, ActorMotionY(a0)                          ; $016F78
        bsr.w        MoveActorWithWallMargin32                     ; $016F7C

loc_016F80:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $016F80
        beq.b        loc_016F92                                    ; $016F86
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $016F88
        beq.b        loc_016F92                                    ; $016F8E
        bra.b        loc_016F96                                    ; $016F90

loc_016F92:
        bra.w        EnemiesRoutine_01E25A                         ; $016F92

loc_016F96:
        movea.l      ActorTarget(a0), a3                           ; $016F96
        move.w       ActorX(a0), d0                                ; $016F9A
        sub.w        ActorX(a3), d0                                ; $016F9E
        move.w       ActorY(a0), d1                                ; $016FA2
        sub.w        ActorY(a3), d1                                ; $016FA6
        move.w       d0, d3                                        ; $016FAA
        move.w       d1, d4                                        ; $016FAC
        jsr          OctagonalDistance.l                           ; $016FAE
        cmpi.w       #$60, d0                                      ; $016FB4
        bcs.b        loc_016FBE                                    ; $016FB8
        bra.w        EnemiesRoutine_01E25A                         ; $016FBA

loc_016FBE:
        tst.b        ActorMarkerTracked(a0)                        ; $016FBE
        beq.b        loc_016FCE                                    ; $016FC2
        move.w       #$1, rWallOpeningPermit(a6)                   ; $016FC4
        clr.b        ActorMarkerTracked(a0)                        ; $016FCA

loc_016FCE:
        cmpi.b       #$3, ActorState(a0)                           ; $016FCE
        bne.b        loc_017050                                    ; $016FD4
        cmpa.l       #$ff11e2, a3                                  ; $016FD6
        bne.b        loc_017024                                    ; $016FDC
        jsr          NextRandom.l                                  ; $016FDE
        asr.w        #$8, d2                                       ; $016FE4
        andi.w       #$1, d2                                       ; $016FE6
        addq.w       #$2, d2                                       ; $016FEA
        lsl.w        #$8, d2                                       ; $016FEC
        move.w       d2, -$6fa2(a6)                                ; $016FEE
        move.w       #$c, d0                                       ; $016FF2
        move.l       a0, -(a7)                                     ; $016FF6
        jsr          UiRoutine_011C78(pc)                          ; $016FF8
        movea.l      (a7)+, a0                                     ; $016FFC
        clr.w        -$6fa2(a6)                                    ; $016FFE
        cmpi.w       #$ffff, d7                                    ; $017002
        beq.b        loc_017050                                    ; $017006
        move.b       #$4, ActorState(a0)                           ; $017008
        move.w       #$60, d0                                      ; $01700E
        jsr          SoundRoutine_00DF64.l                         ; $017012
        movea.l      #StatusMessageBuligunCollected, a0            ; $017018
        jmp          QueueStatusMessage.l                          ; $01701E

loc_017024:
        lea.l        -$6fdc(a6), a1                                ; $017024
        move.b       #$4, ActorState(a0)                           ; $017028
        move.b       #$13, (a1)+                                   ; $01702E
        move.b       #$8, (a1)+                                    ; $017032
        jsr          NextRandom.l                                  ; $017036
        asr.w        #$8, d2                                       ; $01703C
        andi.w       #$1, d2                                       ; $01703E
        addq.w       #$2, d2                                       ; $017042
        move.b       d2, (a1)+                                     ; $017044
        lea.l        -$6fdc(a6), a0                                ; $017046
        jmp          QueueLinkCommand.l                            ; $01704A

loc_017050:
        rts                                                        ; $017050
        ifne *-$17052
        fail "ROM end moved"
        endif
