; $0113EA..$0114F9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сборка спрайт-таблицы HUD-иконок (5 слотов, индексы из (-0x6f80,A6); таймер слота в (-0x6f78,A6)[idx], рисует если 0/был 0/!=3): пишет в (A2)+ 4 слова Y=0x83, size+link(0xf00|cnt), tile=(idx<<4)-0x1b61, X=0xa8/0xd8/0x110/0x148/0x178; обновляет счётчик (-0x7fbe,A6)
        ifne *-$113EA
        fail "ROM start moved"
        endif

AppendInventoryHudSpritesToSat:
        lea.l        rSelectedInventorySlot(a6), a0                ; $0113EA
        lea.l        rInventoryHudBlinkTicks(a6), a1                                ; $0113EE
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $0113F2
        ori.w        #$f00, d0                                     ; $0113F6
        clr.w        d1                                            ; $0113FA
        move.b       $3(a0), d1                                    ; $0113FC
        move.b       (a1, d1.w), d2                                ; $011400
        beq.b        loc_011412                                    ; $011404
        subq.b       #$1, (a1, d1.w)                               ; $011406
        beq.b        loc_01142C                                    ; $01140A
        cmpi.b       #$3, d2                                       ; $01140C
        beq.b        loc_01142C                                    ; $011410

loc_011412:
        move.w       #$83, (a2)+                                   ; $011412
        move.w       d0, (a2)+                                     ; $011416
        addq.w       #$1, d0                                       ; $011418
        clr.w        d1                                            ; $01141A
        move.b       $3(a0), d1                                    ; $01141C
        lsl.w        #$4, d1                                       ; $011420
        addi.w       #$e49f, d1                                    ; $011422
        move.w       d1, (a2)+                                     ; $011426
        move.w       #$a8, (a2)+                                   ; $011428

loc_01142C:
        clr.w        d1                                            ; $01142C
        move.b       $4(a0), d1                                    ; $01142E
        move.b       (a1, d1.w), d2                                ; $011432
        beq.b        loc_011444                                    ; $011436
        subq.b       #$1, (a1, d1.w)                               ; $011438
        beq.b        loc_01145E                                    ; $01143C
        cmpi.b       #$3, d2                                       ; $01143E
        beq.b        loc_01145E                                    ; $011442

loc_011444:
        move.w       #$83, (a2)+                                   ; $011444
        move.w       d0, (a2)+                                     ; $011448
        addq.w       #$1, d0                                       ; $01144A
        clr.w        d1                                            ; $01144C
        move.b       $4(a0), d1                                    ; $01144E
        lsl.w        #$4, d1                                       ; $011452
        addi.w       #$e49f, d1                                    ; $011454
        move.w       d1, (a2)+                                     ; $011458
        move.w       #$d8, (a2)+                                   ; $01145A

loc_01145E:
        clr.w        d1                                            ; $01145E
        move.b       (a0), d1                                      ; $011460
        move.b       (a1, d1.w), d2                                ; $011462
        beq.b        loc_011474                                    ; $011466
        subq.b       #$1, (a1, d1.w)                               ; $011468
        beq.b        loc_01148C                                    ; $01146C
        cmpi.b       #$3, d2                                       ; $01146E
        beq.b        loc_01148C                                    ; $011472

loc_011474:
        move.w       #$83, (a2)+                                   ; $011474
        move.w       d0, (a2)+                                     ; $011478
        addq.w       #$1, d0                                       ; $01147A
        clr.w        d1                                            ; $01147C
        move.b       (a0), d1                                      ; $01147E
        lsl.w        #$4, d1                                       ; $011480
        addi.w       #$e49f, d1                                    ; $011482
        move.w       d1, (a2)+                                     ; $011486
        move.w       #$110, (a2)+                                  ; $011488

loc_01148C:
        clr.w        d1                                            ; $01148C
        move.b       $1(a0), d1                                    ; $01148E
        move.b       (a1, d1.w), d2                                ; $011492
        beq.b        loc_0114A4                                    ; $011496
        subq.b       #$1, (a1, d1.w)                               ; $011498
        beq.b        loc_0114BE                                    ; $01149C
        cmpi.b       #$3, d2                                       ; $01149E
        beq.b        loc_0114BE                                    ; $0114A2

loc_0114A4:
        move.w       #$83, (a2)+                                   ; $0114A4
        move.w       d0, (a2)+                                     ; $0114A8
        addq.w       #$1, d0                                       ; $0114AA
        clr.w        d1                                            ; $0114AC
        move.b       $1(a0), d1                                    ; $0114AE
        lsl.w        #$4, d1                                       ; $0114B2
        addi.w       #$e49f, d1                                    ; $0114B4
        move.w       d1, (a2)+                                     ; $0114B8
        move.w       #$148, (a2)+                                  ; $0114BA

loc_0114BE:
        clr.w        d1                                            ; $0114BE
        move.b       $2(a0), d1                                    ; $0114C0
        move.b       (a1, d1.w), d2                                ; $0114C4
        beq.b        loc_0114D6                                    ; $0114C8
        subq.b       #$1, (a1, d1.w)                               ; $0114CA
        beq.b        loc_0114F0                                    ; $0114CE
        cmpi.b       #$3, d2                                       ; $0114D0
        beq.b        loc_0114F0                                    ; $0114D4

loc_0114D6:
        move.w       #$83, (a2)+                                   ; $0114D6
        move.w       d0, (a2)+                                     ; $0114DA
        addq.w       #$1, d0                                       ; $0114DC
        clr.w        d1                                            ; $0114DE
        move.b       $2(a0), d1                                    ; $0114E0
        lsl.w        #$4, d1                                       ; $0114E4
        addi.w       #$e49f, d1                                    ; $0114E6
        move.w       d1, (a2)+                                     ; $0114EA
        move.w       #$178, (a2)+                                  ; $0114EC

loc_0114F0:
        andi.w       #$f0ff, d0                                    ; $0114F0
        move.w       d0, rSpriteAttributeNextLink(a6)                                ; $0114F4
        rts                                                        ; $0114F8
        ifne *-$114FA
        fail "ROM end moved"
        endif
