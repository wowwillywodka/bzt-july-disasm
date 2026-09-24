; $011648..$0116BD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация дескрипторов HUD-панели: (-0x6f7b,A6)=5; в (-0x6f80,A6) пишет байты 00 01 02 03 04 (move.l #0x00010203 + move.b #4); массив (-0x6fa0,A6) = пары (код-иконки {7,4,b,5,e,0,1,3}, 0x6300); (-0x720e,A6)=0x63
        ifne *-$11648
        fail "ROM start moved"
        endif

GrantPauseCodeFullLoadout:
        move.b       #$5, rOccupiedInventorySlotCount(a6)          ; $011648
        lea.l        rSelectedInventorySlot(a6), a0                ; $01164E
        move.l       #$10203, (a0)+                                ; $011652
        move.b       #$4, (a0)+                                    ; $011658
        lea.l        rInventorySlots(a6), a0                       ; $01165C
        move.w       #$7, (a0)                                     ; $011660
        move.w       #$6300, $2(a0)                                ; $011664
        addq.w       #$4, a0                                       ; $01166A
        move.w       #$4, (a0)                                     ; $01166C
        move.w       #$6300, $2(a0)                                ; $011670
        addq.w       #$4, a0                                       ; $011676
        move.w       #$b, (a0)                                     ; $011678
        move.w       #$6300, $2(a0)                                ; $01167C
        addq.w       #$4, a0                                       ; $011682
        move.w       #$5, (a0)                                     ; $011684
        move.w       #$6300, $2(a0)                                ; $011688
        addq.w       #$4, a0                                       ; $01168E
        move.w       #$e, (a0)                                     ; $011690
        move.w       #$6300, $2(a0)                                ; $011694
        addq.w       #$4, a0                                       ; $01169A
        clr.w        (a0)                                          ; $01169C
        addq.w       #$4, a0                                       ; $01169E
        move.w       #$1, (a0)                                     ; $0116A0
        move.w       #$6300, $2(a0)                                ; $0116A4
        addq.w       #$4, a0                                       ; $0116AA
        move.w       #$3, (a0)                                     ; $0116AC
        move.w       #$6300, $2(a0)                                ; $0116B0
        move.w       #$63, rPlayerHealth(a6)                       ; $0116B6
        rts                                                        ; $0116BC
        ifne *-$116BE
        fail "ROM end moved"
        endif
