; $011C78..$011EFF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Аллокатор/загрузчик слота HUD-иконки подобранного предмета/оружия: по коду D0 ищет/занимает запись в таблице слотов (-0x6fa0,A6) с приоритетом типов 1/3/4/6/7/9, считает VRAM-адрес, стримит тайлы через 0x1175e и взводит таймеры подсветки
        ifne *-$11C78
        fail "ROM start moved"
        endif

UiRoutine_011C78:
        cmpi.w       #$4, d0                                       ; $011C78
        bne.b        loc_011CB6                                    ; $011C7C
        lea.l        rInventorySlots(a6), a0                       ; $011C7E
        cmpi.w       #$7, (a0)                                     ; $011C82
        beq.b        loc_011CB2                                    ; $011C86
        addq.w       #$1, d7                                       ; $011C88
        addq.w       #$4, a0                                       ; $011C8A
        cmpi.w       #$7, (a0)                                     ; $011C8C
        beq.b        loc_011CB2                                    ; $011C90
        addq.w       #$1, d7                                       ; $011C92
        addq.w       #$4, a0                                       ; $011C94
        cmpi.w       #$7, (a0)                                     ; $011C96
        beq.b        loc_011CB2                                    ; $011C9A
        addq.w       #$1, d7                                       ; $011C9C
        addq.w       #$4, a0                                       ; $011C9E
        cmpi.w       #$7, (a0)                                     ; $011CA0
        beq.b        loc_011CB2                                    ; $011CA4
        addq.w       #$1, d7                                       ; $011CA6
        addq.w       #$4, a0                                       ; $011CA8
        cmpi.w       #$7, (a0)                                     ; $011CAA
        beq.b        loc_011CB2                                    ; $011CAE
        bra.b        loc_011CB6                                    ; $011CB0

loc_011CB2:
        move.w       #$4, (a0)                                     ; $011CB2

loc_011CB6:
        cmpi.w       #$7, d0                                       ; $011CB6
        bne.b        loc_011CF4                                    ; $011CBA
        lea.l        rInventorySlots(a6), a0                       ; $011CBC
        cmpi.w       #$4, (a0)                                     ; $011CC0
        beq.b        loc_011CF0                                    ; $011CC4
        addq.w       #$1, d7                                       ; $011CC6
        addq.w       #$4, a0                                       ; $011CC8
        cmpi.w       #$4, (a0)                                     ; $011CCA
        beq.b        loc_011CF0                                    ; $011CCE
        addq.w       #$1, d7                                       ; $011CD0
        addq.w       #$4, a0                                       ; $011CD2
        cmpi.w       #$4, (a0)                                     ; $011CD4
        beq.b        loc_011CF0                                    ; $011CD8
        addq.w       #$1, d7                                       ; $011CDA
        addq.w       #$4, a0                                       ; $011CDC
        cmpi.w       #$4, (a0)                                     ; $011CDE
        beq.b        loc_011CF0                                    ; $011CE2
        addq.w       #$1, d7                                       ; $011CE4
        addq.w       #$4, a0                                       ; $011CE6
        cmpi.w       #$4, (a0)                                     ; $011CE8
        beq.b        loc_011CF0                                    ; $011CEC
        bra.b        loc_011CF4                                    ; $011CEE

loc_011CF0:
        move.w       #$4, d0                                       ; $011CF0

loc_011CF4:
        lea.l        rInventorySlots(a6), a0                       ; $011CF4
        clr.w        d7                                            ; $011CF8
        cmpi.w       #$6, d0                                       ; $011CFA
        beq.w        loc_011E72                                    ; $011CFE
        cmpi.w       #$1, d0                                       ; $011D02
        beq.w        loc_011EA6                                    ; $011D06
        cmpi.w       #$3, d0                                       ; $011D0A
        beq.w        loc_011ED2                                    ; $011D0E
        cmp.w        (a0), d0                                      ; $011D12
        beq.b        loc_011D44                                    ; $011D14
        addq.w       #$1, d7                                       ; $011D16
        addq.w       #$4, a0                                       ; $011D18
        cmp.w        (a0), d0                                      ; $011D1A
        beq.b        loc_011D44                                    ; $011D1C
        addq.w       #$1, d7                                       ; $011D1E
        addq.w       #$4, a0                                       ; $011D20
        cmp.w        (a0), d0                                      ; $011D22
        beq.b        loc_011D44                                    ; $011D24
        addq.w       #$1, d7                                       ; $011D26
        addq.w       #$4, a0                                       ; $011D28
        cmp.w        (a0), d0                                      ; $011D2A
        beq.b        loc_011D44                                    ; $011D2C
        addq.w       #$1, d7                                       ; $011D2E
        addq.w       #$4, a0                                       ; $011D30
        cmp.w        (a0), d0                                      ; $011D32
        beq.b        loc_011D44                                    ; $011D34
        cmpi.b       #$5, rOccupiedInventorySlotCount(a6)          ; $011D36
        bne.b        loc_011DAC                                    ; $011D3C

loc_011D3E:
        move.w       #$ffff, d7                                    ; $011D3E
        rts                                                        ; $011D42

loc_011D44:
        tst.w        -$7ffe(a6)                                    ; $011D44
        bne.b        loc_011D44                                    ; $011D48
        move.w       d7, d6                                        ; $011D4A
        lsl.w        #$8, d6                                       ; $011D4C
        lsl.w        #$1, d6                                       ; $011D4E
        addi.w       #$93e0, d6                                    ; $011D50
        move.w       -$6fa2(a6), d2                                ; $011D54
        bne.b        loc_011D64                                    ; $011D58
        lea.l        ItemRefillAmounts(pc), a1                     ; $011D5A
        adda.w       d0, a1                                        ; $011D5E
        adda.w       d0, a1                                        ; $011D60
        move.w       (a1), d2                                      ; $011D62

loc_011D64:
        lea.l        ItemCapacityLimits(pc), a1                    ; $011D64
        adda.w       d0, a1                                        ; $011D68
        adda.w       d0, a1                                        ; $011D6A
        move.w       (a1), d1                                      ; $011D6C
        cmp.w        $2(a0), d1                                    ; $011D6E
        beq.b        loc_011D3E                                    ; $011D72
        add.w        $2(a0), d2                                    ; $011D74
        cmp.w        d1, d2                                        ; $011D78
        bls.b        loc_011D7E                                    ; $011D7A
        move.w       d1, d2                                        ; $011D7C

loc_011D7E:
        move.w       d2, $2(a0)                                    ; $011D7E
        movem.w      d0/d7, -(a7)                                  ; $011D82
        move.w       d6, d0                                        ; $011D86
        move.w       d0, d1                                        ; $011D88
        andi.w       #$3fff, d1                                    ; $011D8A
        ori.w        #$4000, d1                                    ; $011D8E
        swap         d1                                            ; $011D92
        lsr.w        #$8, d0                                       ; $011D94
        lsr.w        #$6, d0                                       ; $011D96
        move.w       d0, d1                                        ; $011D98
        move.l       d1, VDP_CONTROL.l                             ; $011D9A
        bsr.w        VideoRoutine_01175E                           ; $011DA0
        movem.w      (a7)+, d0/d7                                  ; $011DA4
        bra.w        loc_011E4C                                    ; $011DA8

loc_011DAC:
        addq.b       #$1, rOccupiedInventorySlotCount(a6)          ; $011DAC
        lea.l        rInventorySlots(a6), a0                       ; $011DB0
        move.w       #$93e0, d6                                    ; $011DB4

loc_011DB8:
        tst.w        -$7ffe(a6)                                    ; $011DB8
        bne.b        loc_011DB8                                    ; $011DBC
        clr.w        d7                                            ; $011DBE
        tst.w        (a0)                                          ; $011DC0
        beq.b        loc_011E00                                    ; $011DC2
        addq.w       #$4, a0                                       ; $011DC4
        addi.w       #$200, d6                                     ; $011DC6
        addq.w       #$1, d7                                       ; $011DCA
        tst.w        (a0)                                          ; $011DCC
        beq.b        loc_011E00                                    ; $011DCE
        addq.w       #$4, a0                                       ; $011DD0
        addi.w       #$200, d6                                     ; $011DD2
        addq.w       #$1, d7                                       ; $011DD6
        tst.w        (a0)                                          ; $011DD8
        beq.b        loc_011E00                                    ; $011DDA
        addq.w       #$4, a0                                       ; $011DDC
        addi.w       #$200, d6                                     ; $011DDE
        addq.w       #$1, d7                                       ; $011DE2
        tst.w        (a0)                                          ; $011DE4
        beq.b        loc_011E00                                    ; $011DE6
        addq.w       #$4, a0                                       ; $011DE8
        addi.w       #$200, d6                                     ; $011DEA
        addq.w       #$1, d7                                       ; $011DEE
        tst.w        (a0)                                          ; $011DF0
        beq.b        loc_011E00                                    ; $011DF2
        move.b       #$5, rOccupiedInventorySlotCount(a6)          ; $011DF4
        move.w       #$ffff, d7                                    ; $011DFA
        rts                                                        ; $011DFE

loc_011E00:
        move.w       d0, (a0)                                      ; $011E00
        move.w       -$6fa2(a6), $2(a0)                            ; $011E02
        bne.b        loc_011E22                                    ; $011E08
        lea.l        ItemRefillAmounts(pc), a1                     ; $011E0A
        adda.w       d0, a1                                        ; $011E0E
        adda.w       d0, a1                                        ; $011E10
        move.w       (a1), $2(a0)                                  ; $011E12
        move.l       d0, -(a7)                                     ; $011E16
        move.w       $2(a0), d0                                    ; $011E18
        move.w       d0, $2(a0)                                    ; $011E1C
        move.l       (a7)+, d0                                     ; $011E20

loc_011E22:
        movem.w      d0/d7, -(a7)                                  ; $011E22
        move.w       d6, d0                                        ; $011E26
        move.w       d0, d1                                        ; $011E28
        andi.w       #$3fff, d1                                    ; $011E2A
        ori.w        #$4000, d1                                    ; $011E2E
        swap         d1                                            ; $011E32
        lsr.w        #$8, d0                                       ; $011E34
        lsr.w        #$6, d0                                       ; $011E36
        move.w       d0, d1                                        ; $011E38
        move.l       d1, VDP_CONTROL.l                             ; $011E3A
        bsr.w        VideoRoutine_01175E                           ; $011E40
        bsr.w        RequestWeaponFromSelectedItem                 ; $011E44
        movem.w      (a7)+, d0/d7                                  ; $011E48

loc_011E4C:
        lea.l        -$6f78(a6), a1                                ; $011E4C
        move.b       #$3, (a1, d7.w)                               ; $011E50
        cmpi.w       #$9, d0                                       ; $011E56
        bne.w        loc_011EFC                                    ; $011E5A
        tst.w        -$6f6c(a6)                                    ; $011E5E
        bpl.w        loc_011EFC                                    ; $011E62
        move.w       d7, -$6f6c(a6)                                ; $011E66
        bsr.w        UiRoutine_011F70                              ; $011E6A
        bra.w        loc_011EFC                                    ; $011E6E

loc_011E72:
        lea.l        rInventorySlots(a6), a0                       ; $011E72
        adda.w       #$14, a0                                      ; $011E76
        move.w       -$6fa2(a6), $2(a0)                            ; $011E7A
        bne.b        loc_011E8E                                    ; $011E80
        lea.l        ItemRefillAmounts(pc), a1                     ; $011E82
        adda.w       d0, a1                                        ; $011E86
        adda.w       d0, a1                                        ; $011E88
        move.w       (a1), $2(a0)                                  ; $011E8A

loc_011E8E:
        tst.w        -$6f6a(a6)                                    ; $011E8E
        bpl.w        loc_011EFC                                    ; $011E92
        move.w       d0, (a0)                                      ; $011E96
        move.w       #$5, -$6f6a(a6)                               ; $011E98
        move.w       #$10, -$7122(a6)                              ; $011E9E
        bra.b        loc_011EFC                                    ; $011EA4

loc_011EA6:
        lea.l        rInventorySlots(a6), a0                       ; $011EA6
        adda.w       #$18, a0                                      ; $011EAA
        move.w       -$6fa2(a6), $2(a0)                            ; $011EAE
        bne.b        loc_011EC2                                    ; $011EB4
        lea.l        ItemRefillAmounts(pc), a1                     ; $011EB6
        adda.w       d0, a1                                        ; $011EBA
        adda.w       d0, a1                                        ; $011EBC
        move.w       (a1), $2(a0)                                  ; $011EBE

loc_011EC2:
        tst.w        -$6f68(a6)                                    ; $011EC2
        bpl.b        loc_011ED2                                    ; $011EC6
        move.w       d0, (a0)                                      ; $011EC8
        move.w       #$6, -$6f68(a6)                               ; $011ECA
        bra.b        loc_011EFC                                    ; $011ED0

loc_011ED2:
        lea.l        rInventorySlots(a6), a0                       ; $011ED2
        adda.w       #$1c, a0                                      ; $011ED6
        move.w       -$6fa2(a6), $2(a0)                            ; $011EDA
        bne.b        loc_011EEE                                    ; $011EE0
        lea.l        ItemRefillAmounts(pc), a1                     ; $011EE2
        adda.w       d0, a1                                        ; $011EE6
        adda.w       d0, a1                                        ; $011EE8
        move.w       (a1), $2(a0)                                  ; $011EEA

loc_011EEE:
        tst.w        -$6f66(a6)                                    ; $011EEE
        bpl.b        loc_011EFC                                    ; $011EF2
        move.w       d0, (a0)                                      ; $011EF4
        move.w       #$7, -$6f66(a6)                               ; $011EF6

loc_011EFC:
        clr.w        d7                                            ; $011EFC
        rts                                                        ; $011EFE
        ifne *-$11F00
        fail "ROM end moved"
        endif
