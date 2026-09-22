; $01D92C..$01DA19 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Спавнер вспышки осколков: цикл 8 раз, выделяет слоты актёров через $1c090, ставит vfunc'ы 0x1da1a/0x1db4c/0x1db3c, случайный разброс скорости/угла через $a46, шлёт спавн-событие сети (cmd 4) через $1ffcc
        ifne *-$1D92C
        fail "ROM start moved"
        endif

ActorsRoutine_01D92C:
        movem.l      d0-d4/d7/a0-a2, -(a7)                         ; $01D92C
        moveq        #$7, d7                                       ; $01D930
        movea.l      a0, a2                                        ; $01D932

loc_01D934:
        cmpi.w       #$10, -$6fe0(a6)                              ; $01D934
        beq.w        loc_01DA14                                    ; $01D93A
        bsr.w        AllocateActor                                 ; $01D93E
        beq.w        loc_01DA14                                    ; $01D942
        addq.w       #$1, -$6fe0(a6)                               ; $01D946
        move.w       $24(a2), ActorX(a0)                           ; $01D94A
        move.w       $26(a2), ActorY(a0)                           ; $01D950
        move.l       #ActorsRoutine_01DA1A, ActorUpdateCallback(a0) ; $01D956
        move.l       #$1db4c, ActorDrawCallback(a0)                ; $01D95E
        move.l       #RendererRoutine_01DB3C, ActorExitCallback(a0) ; $01D966
        move.w       d3, ActorMotionX(a0)                          ; $01D96E
        move.w       d4, ActorMotionY(a0)                          ; $01D972
        jsr          NextRandom.l                                  ; $01D976
        asr.l        #$5, d2                                       ; $01D97C
        move.w       d2, d0                                        ; $01D97E
        andi.w       #$7f, d0                                      ; $01D980
        subi.w       #$40, d0                                      ; $01D984
        add.w        d0, ActorMotionX(a0)                          ; $01D988
        asr.l        #$7, d2                                       ; $01D98C
        move.w       d2, d0                                        ; $01D98E
        andi.w       #$7f, d0                                      ; $01D990
        subi.w       #$40, d0                                      ; $01D994
        add.w        d0, ActorMotionY(a0)                          ; $01D998
        asr.l        #$7, d2                                       ; $01D99C
        move.w       d2, d0                                        ; $01D99E
        andi.w       #$f, d0                                       ; $01D9A0
        subi.w       #$9, d0                                       ; $01D9A4
        move.w       d0, ActorVelocityZ(a0)                        ; $01D9A8
        asr.l        #$4, d2                                       ; $01D9AC
        move.w       d2, d0                                        ; $01D9AE
        andi.w       #$f, d0                                       ; $01D9B0
        subq.w       #$8, d0                                       ; $01D9B4
        move.w       d0, ActorZ(a0)                                ; $01D9B6
        clr.b        ActorState(a0)                                ; $01D9BA
        tst.w        rLinkRole(a6)                                 ; $01D9BE
        beq.b        loc_01DA10                                    ; $01D9C2
        movem.l      d0-d4/d7/a0-a1, -(a7)                         ; $01D9C4
        move.l       #$1eec8, ActorLinkCallback(a0)                ; $01D9C8
        lea.l        -$6fdc(a6), a1                                ; $01D9D0
        move.b       #$4, (a1)+                                    ; $01D9D4
        move.b       ActorLinkId(a0), (a1)+                        ; $01D9D8
        move.w       ActorX(a0), (a1)+                             ; $01D9DC
        move.w       ActorY(a0), (a1)+                             ; $01D9E0
        move.b       ActorZLow(a0), (a1)+                          ; $01D9E4
        move.b       ActorFlagsLow(a0), d0                         ; $01D9E8
        ori.w        #$20, d0                                      ; $01D9EC
        move.b       d0, (a1)+                                     ; $01D9F0
        move.b       ActorFloor(a0), (a1)+                         ; $01D9F2
        move.b       #$9, (a1)+                                    ; $01D9F6
        move.w       ActorMotionX(a0), (a1)+                       ; $01D9FA
        move.w       ActorMotionY(a0), (a1)+                       ; $01D9FE
        lea.l        -$6fdc(a6), a0                                ; $01DA02
        jsr          QueueLinkCommand.l                            ; $01DA06
        movem.l      (a7)+, d0-d4/d7/a0-a1                         ; $01DA0C

loc_01DA10:
        dbra         d7, loc_01D934                                ; $01DA10

loc_01DA14:
        movem.l      (a7)+, d0-d4/d7/a0-a2                         ; $01DA14
        rts                                                        ; $01DA18
        ifne *-$1DA1A
        fail "ROM end moved"
        endif
