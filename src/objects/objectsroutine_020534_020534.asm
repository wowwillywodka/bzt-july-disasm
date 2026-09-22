; $020534..$020567 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обход связного списка объектов (голова -0x57c4,A6, счётчик -0x57c6,A6): идёт по next-указателям (a0), ищет запись с полем 0x1a(a0)==0x1d25a, пропуская ==0x1d880
        ifne *-$20534
        fail "ROM start moved"
        endif

ObjectsRoutine_020534:
        movea.l      rActiveActorHead(a6), a0                      ; $020534
        move.w       rActiveActorCount(a6), d7                     ; $020538
        subq.w       #$1, d7                                       ; $02053C
        bmi.b        loc_020562                                    ; $02053E

loc_020540:
        cmpi.l       #$1d880, ActorExitCallback(a0)                ; $020540
        bne.b        loc_020554                                    ; $020548
        cmpi.l       #$1d25a, ActorExitCallback(a0)                ; $02054A
        beq.b        loc_020564                                    ; $020552

loc_020554:
        movea.l      (a0), a0                                      ; $020554
        cmpa.l       #$0, a0                                       ; $020556
        beq.b        loc_020562                                    ; $02055C
        dbra         d7, loc_020540                                ; $02055E

loc_020562:
        rts                                                        ; $020562

loc_020564:
        jmp          RemoveActorAndSendLink(pc)                    ; $020564
        ifne *-$20568
        fail "ROM end moved"
        endif
