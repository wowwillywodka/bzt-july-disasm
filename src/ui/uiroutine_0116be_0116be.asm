; $0116BE..$011739 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Полный сброс состояния HUD-иконок: выставляет в -1 индексы текущих иконок (-0x6f6c..-0x6f64,A6), указатели 0xff8aba/0xff8ada, флаги/таймеры (-0x6f7a/-0x6f72/-0x6f70,A6), переинициализирует таблицу (-0x6f80,A6) и обнуляет массив (-0x6fa0,A6) из 8 слотов
        ifne *-$116BE
        fail "ROM start moved"
        endif

UiRoutine_0116BE:
        clr.w        -$6fa2(a6)                                    ; $0116BE
        move.w       #$ffff, -$6f6c(a6)                            ; $0116C2
        move.w       #$ffff, -$6f6a(a6)                            ; $0116C8
        move.w       #$ffff, -$6f68(a6)                            ; $0116CE
        move.w       #$ffff, -$6f66(a6)                            ; $0116D4
        move.w       #$ffff, -$6f64(a6)                            ; $0116DA
        move.l       #$ff8aba, -$6f60(a6)                          ; $0116E0
        move.l       #$ff8ada, -$6f60(a6)                          ; $0116E8
        move.b       #$ff, rCurrentWeaponId(a6)                    ; $0116F0
        clr.b        rPendingWeaponId(a6)                          ; $0116F6
        move.w       #$20, rWeaponLoweringOffset(a6)               ; $0116FA
        clr.w        rWeaponActionPhase(a6)                        ; $011700
        clr.b        rOccupiedInventorySlotCount(a6)               ; $011704
        lea.l        rSelectedInventorySlot(a6), a0                ; $011708
        move.l       #$10203, (a0)+                                ; $01170C
        move.b       #$4, (a0)+                                    ; $011712
        lea.l        rInventorySlots(a6), a0                       ; $011716
        clr.w        (a0)                                          ; $01171A
        addq.w       #$4, a0                                       ; $01171C
        clr.w        (a0)                                          ; $01171E
        addq.w       #$4, a0                                       ; $011720
        clr.w        (a0)                                          ; $011722
        addq.w       #$4, a0                                       ; $011724
        clr.w        (a0)                                          ; $011726
        addq.w       #$4, a0                                       ; $011728
        clr.w        (a0)                                          ; $01172A
        addq.w       #$4, a0                                       ; $01172C
        clr.w        (a0)                                          ; $01172E
        addq.w       #$4, a0                                       ; $011730
        clr.w        (a0)                                          ; $011732
        addq.w       #$4, a0                                       ; $011734
        clr.w        (a0)                                          ; $011736
        addq.w       #$4, a0                                       ; $011738
        ifne *-$1173A
        fail "ROM end moved"
        endif
