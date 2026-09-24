; $0115DE..$011647 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Брат 0x011570: при слоте (-0x6fa0+0x14)==6 ищет иконку D6=5 в таблице (-0x6f80,A6), декрементит таймер в (-0x6f78,A6) и пишет 4-словную VDP-запись иконки HUD (маркер 0x101, адрес, тайл, 0x192) в (A2)+, инкремент (-0x7fbe,A6)
        ifne *-$115DE
        fail "ROM start moved"
        endif

AppendInventorySlot5StatusSprite:
        lea.l        rInventorySlots(a6), a0                       ; $0115DE
        clr.w        d7                                            ; $0115E2
        adda.w       #$14, a0                                      ; $0115E4
        move.w       #$5, d6                                       ; $0115E8
        cmpi.w       #$6, (a0)                                     ; $0115EC
        beq.b        loc_0115F4                                    ; $0115F0
        rts                                                        ; $0115F2

loc_0115F4:
        clr.w        d5                                            ; $0115F4
        lea.l        rSelectedInventorySlot(a6), a0                ; $0115F6

loc_0115FA:
        cmp.b        (a0, d5.w), d6                                ; $0115FA
        beq.b        loc_011604                                    ; $0115FE
        addq.w       #$1, d5                                       ; $011600
        bra.b        loc_0115FA                                    ; $011602

loc_011604:
        lea.l        rInventoryHudBlinkTicks(a6), a1                                ; $011604
        move.w       rSpriteAttributeNextLink(a6), d0                                ; $011608
        ori.w        #$f00, d0                                     ; $01160C
        clr.w        d1                                            ; $011610
        move.b       (a0, d5.w), d1                                ; $011612
        move.b       (a1, d1.w), d2                                ; $011616
        beq.b        loc_011628                                    ; $01161A
        subq.b       #$1, (a1, d1.w)                               ; $01161C
        beq.b        loc_011646                                    ; $011620
        cmpi.b       #$3, d2                                       ; $011622
        beq.b        loc_011646                                    ; $011626

loc_011628:
        move.w       #$101, (a2)+                                  ; $011628
        move.w       d0, (a2)+                                     ; $01162C
        addq.w       #$1, d0                                       ; $01162E
        clr.w        d1                                            ; $011630
        move.b       (a0, d5.w), d1                                ; $011632
        lsl.w        #$4, d1                                       ; $011636
        addi.w       #$e001, d1                                    ; $011638
        move.w       d1, (a2)+                                     ; $01163C
        move.w       #$192, (a2)+                                  ; $01163E
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $011642

loc_011646:
        rts                                                        ; $011646
        ifne *-$11648
        fail "ROM end moved"
        endif
