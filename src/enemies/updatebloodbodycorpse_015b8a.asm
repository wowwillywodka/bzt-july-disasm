; $015B8A..$015CF9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Corpse death mode overlays ActorGoalY high byte: CB->CC, then decrements ActorState from 3 to 0 and sets CA/state3. Uses State, not StateCounter, for that countdown.
        ifne *-$15B8A
        fail "ROM start moved"
        endif

UpdateBloodBodyCorpse:
; Corpse death mode overlays ActorGoalY high byte: CB->CC, then decrements ActorState from 3 to 0 and sets CA/state3. Uses State, not StateCounter, for that countdown.
        clr.b        ActorUpdateDelay(a0)                          ; $015B8A
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $015B8E
        beq.w        loc_015BC8                                    ; $015B94
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $015B98
        beq.w        loc_015BD6                                    ; $015B9E
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $015BA2
        beq.w        loc_015BC4                                    ; $015BA8
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $015BAC
        beq.w        loc_015BC4                                    ; $015BB2
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $015BB6
        beq.w        loc_015BEC                                    ; $015BBC
        bra.w        loc_015BEC                                    ; $015BC0

loc_015BC4:
        bra.w        loc_015BEC                                    ; $015BC4

loc_015BC8:
        move.b       #$cc, ActorDeathMode(a0)                      ; $015BC8
        move.b       #$1, ActorStateCounter(a0)                    ; $015BCE
        rts                                                        ; $015BD4

loc_015BD6:
        subq.b       #$1, ActorState(a0)                           ; $015BD6
        bne.w        loc_015BEA                                    ; $015BDA
        move.b       #$ca, ActorDeathMode(a0)                      ; $015BDE
        move.b       #$3, ActorState(a0)                           ; $015BE4

loc_015BEA:
        rts                                                        ; $015BEA

loc_015BEC:
        move.w       ActorMotionX(a0), d0                          ; $015BEC
        bmi.b        loc_015BF6                                    ; $015BF0
        asr.w        #$1, d0                                       ; $015BF2
        bra.b        loc_015BFC                                    ; $015BF4

loc_015BF6:
        neg.w        d0                                            ; $015BF6
        asr.w        #$1, d0                                       ; $015BF8
        neg.w        d0                                            ; $015BFA

loc_015BFC:
        move.w       d0, ActorMotionX(a0)                          ; $015BFC
        move.w       ActorMotionY(a0), d1                          ; $015C00
        bmi.b        loc_015C0A                                    ; $015C04
        asr.w        #$1, d1                                       ; $015C06
        bra.b        loc_015C10                                    ; $015C08

loc_015C0A:
        neg.w        d1                                            ; $015C0A
        asr.w        #$1, d1                                       ; $015C0C
        neg.w        d1                                            ; $015C0E

loc_015C10:
        move.w       d1, ActorMotionY(a0)                          ; $015C10
        move.w       d0, d2                                        ; $015C14
        or.w         d1, d2                                        ; $015C16
        beq.b        loc_015C26                                    ; $015C18
        move.w       d0, ActorMotionX(a0)                          ; $015C1A
        move.w       d1, ActorMotionY(a0)                          ; $015C1E
        bsr.w        MoveActorWithWallMargin32                     ; $015C22

loc_015C26:
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $015C26
        beq.b        loc_015C38                                    ; $015C2C
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $015C2E
        beq.b        loc_015C38                                    ; $015C34
        bra.b        loc_015C3E                                    ; $015C36

loc_015C38:
        jmp          EnemiesRoutine_01E25A.l                       ; $015C38

loc_015C3E:
        movea.l      ActorTarget(a0), a3                           ; $015C3E
        move.w       ActorX(a0), d0                                ; $015C42
        sub.w        ActorX(a3), d0                                ; $015C46
        move.w       ActorY(a0), d1                                ; $015C4A
        sub.w        ActorY(a3), d1                                ; $015C4E
        move.w       d0, d3                                        ; $015C52
        move.w       d1, d4                                        ; $015C54
        jsr          OctagonalDistance(pc)                         ; $015C56
        cmpi.w       #$60, d0                                      ; $015C5A
        bcs.b        BloodBodyTryCorpsePickup                      ; $015C5E
        jmp          EnemiesRoutine_01E25A.l                       ; $015C60

BloodBodyTryCorpsePickup:
; Distance < $60 from current target. Tracked-marker permit is released before state/player checks. Normal corpse state3 can supply inventory item08 (BULIGUN), amount 2 or 3; failed inventory insertion remains retryable.
        tst.b        ActorMarkerTracked(a0)                        ; $015C66
        beq.b        loc_015C76                                    ; $015C6A
        move.w       #$1, rWallOpeningPermit(a6)                   ; $015C6C
        clr.b        ActorMarkerTracked(a0)                        ; $015C72

loc_015C76:
        cmpi.b       #$3, ActorState(a0)                           ; $015C76
        bne.b        loc_015CF8                                    ; $015C7C
        cmpa.l       #$ff11e2, a3                                  ; $015C7E
        bne.b        loc_015CCC                                    ; $015C84
        jsr          NextRandom.l                                  ; $015C86
        asr.w        #$8, d2                                       ; $015C8C
        andi.w       #$1, d2                                       ; $015C8E
        addq.w       #$2, d2                                       ; $015C92
        lsl.w        #$8, d2                                       ; $015C94
        move.w       d2, -$6fa2(a6)                                ; $015C96
        move.w       #$8, d0                                       ; $015C9A
        move.l       a0, -(a7)                                     ; $015C9E
        jsr          UiRoutine_011C78(pc)                          ; $015CA0
        movea.l      (a7)+, a0                                     ; $015CA4
        clr.w        -$6fa2(a6)                                    ; $015CA6
        cmpi.w       #$ffff, d7                                    ; $015CAA
        beq.b        loc_015CF8                                    ; $015CAE
        move.b       #$4, ActorState(a0)                           ; $015CB0
        move.w       #$60, d0                                      ; $015CB6
        jsr          SoundRoutine_00DF64.l                         ; $015CBA
        movea.l      #StatusMessageBuligunCollected, a0            ; $015CC0
        jmp          QueueStatusMessage.l                          ; $015CC6

loc_015CCC:
        lea.l        -$6fdc(a6), a1                                ; $015CCC
        move.b       #$4, ActorState(a0)                           ; $015CD0
        move.b       #$13, (a1)+                                   ; $015CD6
        move.b       #$8, (a1)+                                    ; $015CDA
        jsr          NextRandom.l                                  ; $015CDE
        asr.w        #$8, d2                                       ; $015CE4
        andi.w       #$1, d2                                       ; $015CE6
        addq.w       #$2, d2                                       ; $015CEA
        move.b       d2, (a1)+                                     ; $015CEC
        lea.l        -$6fdc(a6), a0                                ; $015CEE
        jmp          QueueLinkCommand.l                            ; $015CF2

loc_015CF8:
        rts                                                        ; $015CF8
        ifne *-$15CFA
        fail "ROM end moved"
        endif
