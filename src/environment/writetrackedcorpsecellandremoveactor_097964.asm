; $097964..$0979DD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запись кода 0x8C в клетку грид-карты по позиции объекта ($FFA5FA-база, клипинг $FFA9FA), VDP-запись jsr $20910; ставит пакет-событие тип5 в очередь $1FFCC и переход к коллизии $1C150
        ifne *-$97964
        fail "ROM start moved"
        endif

WriteTrackedCorpseCellAndRemoveActor:
; Tracked corpse exit: overwrite the actor's own cell with profile 8C, then
; send link removal (if connected) and unlink the actor.
        jsr          GetVisibleMapBase.l                           ; $097964
        move.w       ActorX(a0), d0                                ; $09796A
        asr.w        #$8, d0                                       ; $09796E
        adda.w       d0, a1                                        ; $097970
        move.w       ActorY(a0), d0                                ; $097972
        asr.w        #$3, d0                                       ; $097976
        andi.w       #$ffe0, d0                                    ; $097978
        adda.w       d0, a1                                        ; $09797C
        lea.l        rCellIndexByType(a6), a2                      ; $09797E
        clr.w        d0                                            ; $097982
        move.b       #$8c, d0                                      ; $097984
        cmpa.l       #$ffa5fa, a1                                  ; $097988
        bcs.b        loc_097998                                    ; $09798E
        cmpa.l       #$ffe5fa, a1                                  ; $097990
        bcs.b        loc_09799E                                    ; $097996

loc_097998:
        movea.l      #$ffa9fa, a1                                  ; $097998

loc_09799E:
        move.b       (a2, d0.w), (a1)                              ; $09799E
        move.l       a0, -(a7)                                     ; $0979A2
        movea.l      a1, a0                                        ; $0979A4
        jsr          CommitMapCellAndSendLink.l                    ; $0979A6
        movea.l      (a7)+, a0                                     ; $0979AC
        tst.w        rLinkRole(a6)                                 ; $0979AE
        bne.b        loc_0979BA                                    ; $0979B2
        jmp          RemoveActor.l                                 ; $0979B4

loc_0979BA:
        lea.l        rSharedScratchBuffer(a6), a1                                ; $0979BA
        move.b       #$5, (a1)                                     ; $0979BE
        move.b       ActorLinkId(a0), $1(a1)                       ; $0979C2
        movem.l      d0-d7/a0-a3, -(a7)                            ; $0979C8
        movea.l      a1, a0                                        ; $0979CC
        jsr          QueueLinkCommand.l                            ; $0979CE
        movem.l      (a7)+, d0-d7/a0-a3                            ; $0979D4
        jmp          RemoveActor.l                                 ; $0979D8
        ifne *-$979DE
        fail "ROM end moved"
        endif
