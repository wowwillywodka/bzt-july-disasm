; $0294FE..$02954D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Форматирование статистики в число: делит масштабированное значение ((A3) поле) на делитель из таблицы @0x11f24, записывает результат байтом в (A2)+ — хелпер вывода процента/счёта
        ifne *-$294FE
        fail "ROM start moved"
        endif

MathRoutine_0294FE:
        move.w       (a3), d0                                      ; $0294FE
        movea.l      #ItemCapacityLimits, a1                       ; $029500
        adda.w       d0, a1                                        ; $029506
        adda.w       d0, a1                                        ; $029508
        move.w       $2(a3), d0                                    ; $02950A
        ext.l        d0                                            ; $02950E
        lsl.l        #$3, d0                                       ; $029510
        beq.b        loc_029516                                    ; $029512
        subq.l       #$1, d0                                       ; $029514

loc_029516:
        divu.w       (a1), d0                                      ; $029516
        move.b       d0, (a2)+                                     ; $029518
        rts                                                        ; $02951A

loc_02951C:
        move.w       rPlayerHealth(a6), d0                         ; $02951C
        ext.l        d0                                            ; $029520
        lsl.l        #$6, d0                                       ; $029522
        beq.b        loc_029528                                    ; $029524
        subq.l       #$1, d0                                       ; $029526

loc_029528:
        divu.w       #$64, d0                                      ; $029528
        move.b       d0, rSavedHealth(a6)                          ; $02952C
        clr.w        d0                                            ; $029530
        move.w       rGeometryEpisode(a6), d0                      ; $029532
        move.b       d0, rLevelSelection(a6)                       ; $029536
        movem.l      d1-d2/a2, -(a7)                               ; $02953A
        bsr.w        EncodeProgressPassword                        ; $02953E
        movem.l      (a7)+, d1-d2/a2                               ; $029542
        clr.w        rFloorClearMessageTimer(a6)                   ; $029546
        bra.w        CountLegacyObjectiveFloorEnemies              ; $02954A
        ifne *-$2954E
        fail "ROM end moved"
        endif
