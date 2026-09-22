; $022F38..$022FC5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Покадровое продвижение скролла фона: декрементит таймеры (-0x7786/-0x7784), при <0 читает новую дельту/скорость из скрипт-таблицы (A0)+, ограничивает значения 0..0x40, вычисляет смещение в таблицу градиента яркости 0x23716 (lsl#5, neg) и пишет указатели (-0x777a/-0x7776)
        ifne *-$22F38
        fail "ROM start moved"
        endif

UiRoutine_022F38:
        subq.w       #$1, -$7786(a6)                               ; $022F38
        bpl.b        loc_022F4E                                    ; $022F3C
        movea.l      -$7782(a6), a0                                ; $022F3E
        move.w       (a0)+, -$7786(a6)                             ; $022F42
        subq.w       #$1, -$7786(a6)                               ; $022F46
        move.l       a0, -$7782(a6)                                ; $022F4A

loc_022F4E:
        subq.w       #$1, -$7784(a6)                               ; $022F4E
        bpl.b        loc_022F64                                    ; $022F52
        movea.l      -$777e(a6), a0                                ; $022F54
        move.w       (a0)+, -$7784(a6)                             ; $022F58
        subq.w       #$1, -$7784(a6)                               ; $022F5C
        move.l       a0, -$777e(a6)                                ; $022F60

loc_022F64:
        move.w       -$7786(a6), d0                                ; $022F64
        cmpi.w       #$40, d0                                      ; $022F68
        ble.b        loc_022F72                                    ; $022F6C
        move.w       #$40, d0                                      ; $022F6E

loc_022F72:
        subi.w       #$20, d0                                      ; $022F72
        bpl.b        loc_022F7A                                    ; $022F76
        neg.w        d0                                            ; $022F78

loc_022F7A:
        cmpi.w       #$20, d0                                      ; $022F7A
        bcs.b        loc_022F84                                    ; $022F7E
        move.w       #$1f, d0                                      ; $022F80

loc_022F84:
        lsl.w        #$5, d0                                       ; $022F84
        neg.w        d0                                            ; $022F86
        ext.l        d0                                            ; $022F88
        addi.l       #$23716, d0                                   ; $022F8A
        move.l       d0, -$777a(a6)                                ; $022F90
        move.w       -$7784(a6), d0                                ; $022F94
        cmpi.w       #$40, d0                                      ; $022F98
        ble.b        loc_022FA2                                    ; $022F9C
        move.w       #$40, d0                                      ; $022F9E

loc_022FA2:
        subi.w       #$20, d0                                      ; $022FA2
        bpl.b        loc_022FAA                                    ; $022FA6
        neg.w        d0                                            ; $022FA8

loc_022FAA:
        cmpi.w       #$20, d0                                      ; $022FAA
        bcs.b        loc_022FB4                                    ; $022FAE
        move.w       #$1f, d0                                      ; $022FB0

loc_022FB4:
        lsl.w        #$5, d0                                       ; $022FB4
        neg.w        d0                                            ; $022FB6
        ext.l        d0                                            ; $022FB8
        addi.l       #$23716, d0                                   ; $022FBA
        move.l       d0, -$7776(a6)                                ; $022FC0
        rts                                                        ; $022FC4
        ifne *-$22FC6
        fail "ROM end moved"
        endif
