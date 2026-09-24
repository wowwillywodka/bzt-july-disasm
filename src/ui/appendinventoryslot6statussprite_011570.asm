; $011570..$0115DD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; При активном слоте (-0x6fa0+0x18)==1 ищет иконку D6=6 в таблице (-0x6f80,A6), декрементит её таймер в (-0x6f78,A6) и пишет в спрайт-буфер (A2)+ 4-словную VDP-запись иконки HUD (маркер 0xd1, VRAM-адрес, тайл, 0x192), инкрементит счётчик спрайтов (-0x7fbe,A6)
        ifne *-$11570
        fail "ROM start moved"
        endif

AppendInventorySlot6StatusSprite:
        lea.l        rInventorySlots(a6), a0                       ; $011570
        clr.w        d7                                            ; $011574
        adda.w       #$18, a0                                      ; $011576
        move.w       #$6, d6                                       ; $01157A
        cmpi.w       #$1, (a0)                                     ; $01157E
        beq.b        loc_011586                                    ; $011582
        rts                                                        ; $011584

loc_011586:
        clr.w        d5                                            ; $011586
        lea.l        rSelectedInventorySlot(a6), a0                ; $011588

loc_01158C:
        cmp.b        (a0, d5.w), d6                                ; $01158C
        beq.b        loc_011596                                    ; $011590
        addq.w       #$1, d5                                       ; $011592
        bra.b        loc_01158C                                    ; $011594

loc_011596:
        lea.l        rInventoryHudBlinkTicks(a6), a1                                ; $011596
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $01159A
        ori.w        #$f00, d0                                     ; $01159E
        clr.w        d1                                            ; $0115A2
        move.b       (a0, d5.w), d1                                ; $0115A4
        move.b       (a1, d1.w), d2                                ; $0115A8
        beq.b        loc_0115BE                                    ; $0115AC
        subq.b       #$1, (a1, d1.w)                               ; $0115AE
        beq.w        loc_011646                                    ; $0115B2
        cmpi.b       #$3, d2                                       ; $0115B6
        beq.w        loc_011646                                    ; $0115BA

loc_0115BE:
        move.w       #$d1, (a2)+                                   ; $0115BE
        move.w       d0, (a2)+                                     ; $0115C2
        addq.w       #$1, d0                                       ; $0115C4
        clr.w        d1                                            ; $0115C6
        move.b       (a0, d5.w), d1                                ; $0115C8
        lsl.w        #$4, d1                                       ; $0115CC
        addi.w       #$e001, d1                                    ; $0115CE
        move.w       d1, (a2)+                                     ; $0115D2
        move.w       #$192, (a2)+                                  ; $0115D4
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $0115D8
        rts                                                        ; $0115DC
        ifne *-$115DE
        fail "ROM end moved"
        endif
