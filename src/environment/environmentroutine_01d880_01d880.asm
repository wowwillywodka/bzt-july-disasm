; $01D880..$01D92B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Зонд стены у позиции актёра (клетка+8 соседей): на сплошной клетке пишет тайл 0x4a(a0) из таблицы $bea с клампом указателя, фиксирует через $20910 и шлёт звук $1ffcc
        ifne *-$1D880
        fail "ROM start moved"
        endif

EnvironmentRoutine_01D880:
        bsr.w        GetVisibleMapBase                             ; $01D880
        move.w       ActorX(a0), d0                                ; $01D884
        asr.w        #$8, d0                                       ; $01D888
        adda.w       d0, a1                                        ; $01D88A
        move.w       ActorY(a0), d0                                ; $01D88C
        asr.w        #$3, d0                                       ; $01D890
        andi.w       #$ffe0, d0                                    ; $01D892
        adda.w       d0, a1                                        ; $01D896
        tst.b        (a1)                                          ; $01D898
        beq.b        loc_01D8D2                                    ; $01D89A
        subq.w       #$1, a1                                       ; $01D89C
        tst.b        (a1)                                          ; $01D89E
        beq.b        loc_01D8D2                                    ; $01D8A0
        addq.w       #$2, a1                                       ; $01D8A2
        tst.b        (a1)                                          ; $01D8A4
        beq.b        loc_01D8D2                                    ; $01D8A6
        suba.w       #$21, a1                                      ; $01D8A8
        tst.b        (a1)                                          ; $01D8AC
        beq.b        loc_01D8D2                                    ; $01D8AE
        adda.w       #$40, a1                                      ; $01D8B0
        tst.b        (a1)                                          ; $01D8B4
        beq.b        loc_01D8D2                                    ; $01D8B6
        subq.w       #$1, a1                                       ; $01D8B8
        tst.b        (a1)                                          ; $01D8BA
        beq.b        loc_01D8D2                                    ; $01D8BC
        addq.w       #$2, a1                                       ; $01D8BE
        tst.b        (a1)                                          ; $01D8C0
        beq.b        loc_01D8D2                                    ; $01D8C2
        suba.w       #$40, a1                                      ; $01D8C4
        tst.b        (a1)                                          ; $01D8C8
        beq.b        loc_01D8D2                                    ; $01D8CA
        subq.w       #$2, a1                                       ; $01D8CC
        tst.b        (a1)                                          ; $01D8CE
        bne.b        loc_01D92A                                    ; $01D8D0

loc_01D8D2:
        lea.l        rCellIndexByType(a6), a2                      ; $01D8D2
        clr.w        d0                                            ; $01D8D6
        move.b       ActorExitCellProfile(a0), d0                  ; $01D8D8
        cmpa.l       #$ffa5fa, a1                                  ; $01D8DC
        bcs.b        loc_01D8EC                                    ; $01D8E2
        cmpa.l       #$ffe5fa, a1                                  ; $01D8E4
        bcs.b        loc_01D8F2                                    ; $01D8EA

loc_01D8EC:
        movea.l      #$ffa9fa, a1                                  ; $01D8EC

loc_01D8F2:
        move.b       (a2, d0.w), (a1)                              ; $01D8F2
        move.l       a0, -(a7)                                     ; $01D8F6
        movea.l      a1, a0                                        ; $01D8F8
        bsr.w        CommitMapCellAndSendLink                      ; $01D8FA
        movea.l      (a7)+, a0                                     ; $01D8FE
        tst.w        rLinkRole(a6)                                 ; $01D900
        beq.w        RemoveActor                                   ; $01D904
        lea.l        -$6fdc(a6), a1                                ; $01D908
        move.b       #$5, (a1)                                     ; $01D90C
        move.b       ActorLinkId(a0), $1(a1)                       ; $01D910
        movem.l      d0-d7/a0-a3, -(a7)                            ; $01D916
        movea.l      a1, a0                                        ; $01D91A
        jsr          QueueLinkCommand.l                            ; $01D91C
        movem.l      (a7)+, d0-d7/a0-a3                            ; $01D922
        bra.w        RemoveActor                                   ; $01D926

loc_01D92A:
        rts                                                        ; $01D92A
        ifne *-$1D92C
        fail "ROM end moved"
        endif
