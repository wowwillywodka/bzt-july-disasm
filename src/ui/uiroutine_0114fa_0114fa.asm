; $0114FA..$01156F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сборка спрайтов HUD активного оружия/индикатора: вызывает подпрограммы, сканирует массив объектов (-0x6fa0,A6) на state==3 и список (-0x6f80,A6) на значение 7, эмитит запись спрайта (атрибут 0xa1, тайл lsl#4-0x1fff), инкрементит счётчик спрайтов (-0x7fbe,A6)
        ifne *-$114FA
        fail "ROM start moved"
        endif

UiRoutine_0114FA:
        bsr.w        UiRoutine_011570                              ; $0114FA
        bsr.w        UiRoutine_0115DE                              ; $0114FE
        lea.l        rInventorySlots(a6), a0                       ; $011502
        clr.w        d7                                            ; $011506
        adda.w       #$1c, a0                                      ; $011508
        move.w       #$7, d6                                       ; $01150C
        cmpi.w       #$3, (a0)                                     ; $011510
        beq.b        loc_011518                                    ; $011514
        rts                                                        ; $011516

loc_011518:
        clr.w        d5                                            ; $011518
        lea.l        rSelectedInventorySlot(a6), a0                ; $01151A

loc_01151E:
        cmp.b        (a0, d5.w), d6                                ; $01151E
        beq.b        loc_011528                                    ; $011522
        addq.w       #$1, d5                                       ; $011524
        bra.b        loc_01151E                                    ; $011526

loc_011528:
        lea.l        -$6f78(a6), a1                                ; $011528
        move.w       -$7fbe(a6), d0                                ; $01152C
        ori.w        #$f00, d0                                     ; $011530
        clr.w        d1                                            ; $011534
        move.b       (a0, d5.w), d1                                ; $011536
        move.b       (a1, d1.w), d2                                ; $01153A
        beq.b        loc_011550                                    ; $01153E
        subq.b       #$1, (a1, d1.w)                               ; $011540
        beq.w        loc_011646                                    ; $011544
        cmpi.b       #$3, d2                                       ; $011548
        beq.w        loc_011646                                    ; $01154C

loc_011550:
        move.w       #$a1, (a2)+                                   ; $011550
        move.w       d0, (a2)+                                     ; $011554
        addq.w       #$1, d0                                       ; $011556
        clr.w        d1                                            ; $011558
        move.b       (a0, d5.w), d1                                ; $01155A
        lsl.w        #$4, d1                                       ; $01155E
        addi.w       #$e001, d1                                    ; $011560
        move.w       d1, (a2)+                                     ; $011564
        move.w       #$192, (a2)+                                  ; $011566
        addq.w       #$1, -$7fbe(a6)                               ; $01156A
        rts                                                        ; $01156E
        ifne *-$11570
        fail "ROM end moved"
        endif
