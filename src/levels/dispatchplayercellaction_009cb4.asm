; $009CB4..$009CEB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Чтение типа клетки карты под игроком: индексирует map-указатель (-0x6fb2) по X/Y камеры (-0x7206/-0x7204), прогоняет байт через celltype-LUT (0x24ea) и второй LUT (0x9cec), затем jmp по jump-таблице обработчиков взаимодействия с клеткой
        ifne *-$9CB4
        fail "ROM start moved"
        endif

DispatchPlayerCellAction:
        movea.l      rVisibleMapBasePointer(a6), a0                ; $009CB4
        lea.l        rCellTypeByIndex(a6), a5                      ; $009CB8
        move.w       rPlayerX(a6), d3                              ; $009CBC
        asr.w        #$8, d3                                       ; $009CC0
        adda.w       d3, a0                                        ; $009CC2
        move.w       rPlayerY(a6), d3                              ; $009CC4
        clr.b        d3                                            ; $009CC8
        asr.w        #$3, d3                                       ; $009CCA
        adda.w       d3, a0                                        ; $009CCC
        clr.w        d3                                            ; $009CCE
        move.b       (a0), d3                                      ; $009CD0
        move.b       (a5, d3.w), d3                                ; $009CD2
        move.b       PlayerCellActionSelectors(pc, d3.w), d3       ; $009CD6
        subq.w       #$1, d3                                       ; $009CDA
        bmi.b        loc_009CEA                                    ; $009CDC
        lsl.w        #$2, d3                                       ; $009CDE
        lea.l        PlayerCellActionHandlers(pc), a1              ; $009CE0
        movea.l      (a1, d3.w), a1                                ; $009CE4
        jmp          (a1)                                          ; $009CE8

loc_009CEA:
        rts                                                        ; $009CEA
        ifne *-$9CEC
        fail "ROM end moved"
        endif
