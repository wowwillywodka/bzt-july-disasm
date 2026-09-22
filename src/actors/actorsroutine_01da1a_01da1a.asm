; $01DA1A..$01DAB1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Тик физики снаряда/частицы: шаг позиции в 16 подшагов с проверкой коллизии $1c76c/$1c6e0, при ударе о стену снап к клетке и смена vfunc на $1eef2 (стена) либо $1ef1c (пол по гравитации), иначе гравитация ($32→$28) и затухание скорости ($2e/$30 *3/4)
        ifne *-$1DA1A
        fail "ROM start moved"
        endif

ActorsRoutine_01DA1A:
        clr.b        ActorUpdateDelay(a0)                          ; $01DA1A
        tst.b        ActorState(a0)                                ; $01DA1E
        bne.w        CollisionRoutine_01DB14                       ; $01DA22
        move.w       ActorMotionX(a0), d0                          ; $01DA26
        or.w         ActorMotionY(a0), d0                          ; $01DA2A
        beq.w        CollisionRoutine_01DAD2                       ; $01DA2E
        move.w       ActorX(a0), d3                                ; $01DA32
        move.w       ActorY(a0), d4                                ; $01DA36
        ext.l        d3                                            ; $01DA3A
        ext.l        d4                                            ; $01DA3C
        lsl.l        #$4, d3                                       ; $01DA3E
        lsl.l        #$4, d4                                       ; $01DA40
        move.w       ActorMotionX(a0), d5                          ; $01DA42
        move.w       ActorMotionY(a0), d6                          ; $01DA46
        ext.l        d5                                            ; $01DA4A
        ext.l        d6                                            ; $01DA4C
        move.w       #$f, d7                                       ; $01DA4E

loc_01DA52:
        move.l       d3, d0                                        ; $01DA52
        move.l       d4, d1                                        ; $01DA54
        add.l        d5, d0                                        ; $01DA56
        add.l        d6, d1                                        ; $01DA58
        asr.l        #$4, d0                                       ; $01DA5A
        asr.l        #$4, d1                                       ; $01DA5C
        move.l       d3, -(a7)                                     ; $01DA5E
        bsr.w        TestProjectilePointInActiveWindow             ; $01DA60
        bne.b        loc_01DA72                                    ; $01DA64
        move.l       (a7)+, d3                                     ; $01DA66
        add.l        d5, d3                                        ; $01DA68
        add.l        d6, d4                                        ; $01DA6A
        dbra         d7, loc_01DA52                                ; $01DA6C
        bra.b        CollisionRoutine_01DAB2                       ; $01DA70

loc_01DA72:
        cmpi.b       #$6, d3                                       ; $01DA72
        bcs.b        loc_01DA7E                                    ; $01DA76

loc_01DA78:
        addq.w       #$4, a7                                       ; $01DA78
        bra.w        RendererRoutine_01DB3C                        ; $01DA7A

loc_01DA7E:
        bsr.w        DisabledActorProjectileSurfaceTest            ; $01DA7E
        bne.b        loc_01DA78                                    ; $01DA82
        move.l       (a7)+, d3                                     ; $01DA84
        move.l       #$1eef2, ActorLinkCallback(a0)                ; $01DA86
        asr.l        #$4, d3                                       ; $01DA8E
        asr.l        #$4, d4                                       ; $01DA90
        move.w       d3, ActorX(a0)                                ; $01DA92
        move.w       d4, ActorY(a0)                                ; $01DA96
        clr.w        ActorVelocityZ(a0)                            ; $01DA9A
        clr.w        ActorMotionX(a0)                              ; $01DA9E
        clr.w        ActorMotionY(a0)                              ; $01DAA2
        move.b       #$1, ActorState(a0)                           ; $01DAA6
        clr.b        ActorStateCounter(a0)                         ; $01DAAC
        rts                                                        ; $01DAB0
        ifne *-$1DAB2
        fail "ROM end moved"
        endif
