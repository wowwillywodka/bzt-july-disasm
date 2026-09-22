; $011878..$0118CB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Exhaust selected slot: add another $100 to usage, clear kind/amount, decrement occupied count, request weapon0, mark HUD dirty and erase icon. Caller supplies A0=inventory, D0=slot*4, D5=VRAM icon address, A4=VDP_DATA.
        ifne *-$11878
        fail "ROM start moved"
        endif

ExhaustSelectedItemAndEraseHud:
; Exhaust selected slot: add another $100 to usage, clear kind/amount, decrement occupied count, request weapon0, mark HUD dirty and erase icon. Caller supplies A0=inventory, D0=slot*4, D5=VRAM icon address, A4=VDP_DATA.
        addi.l       #$100, rAmmoUsageFixedCounter(a6)             ; $011878
        move.w       #$1, -$558e(a6)                               ; $011880
        clr.w        (a0, d0.w)                                    ; $011886
        clr.w        $2(a0, d0.w)                                  ; $01188A
        subq.b       #$1, rOccupiedInventorySlotCount(a6)          ; $01188E
        clr.b        rPendingWeaponId(a6)                          ; $011892
        move.w       #$f, d6                                       ; $011896
        moveq        #$0, d7                                       ; $01189A
        move.w       d5, d0                                        ; $01189C
        move.w       d0, d1                                        ; $01189E
        andi.w       #$3fff, d1                                    ; $0118A0
        ori.w        #$4000, d1                                    ; $0118A4
        swap         d1                                            ; $0118A8
        lsr.w        #$8, d0                                       ; $0118AA
        lsr.w        #$6, d0                                       ; $0118AC
        move.w       d0, d1                                        ; $0118AE
        move.l       d1, VDP_CONTROL.l                             ; $0118B0

loc_0118B6:
        move.l       d7, (a4)                                      ; $0118B6
        move.l       d7, (a4)                                      ; $0118B8
        move.l       d7, (a4)                                      ; $0118BA
        move.l       d7, (a4)                                      ; $0118BC
        move.l       d7, (a4)                                      ; $0118BE
        move.l       d7, (a4)                                      ; $0118C0
        move.l       d7, (a4)                                      ; $0118C2
        move.l       d7, (a4)                                      ; $0118C4
        dbra         d6, loc_0118B6                                ; $0118C6
        rts                                                        ; $0118CA
        ifne *-$118CC
        fail "ROM end moved"
        endif
