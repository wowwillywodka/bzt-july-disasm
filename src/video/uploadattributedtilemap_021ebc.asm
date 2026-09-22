; $021EBC..$021F01 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Блит прямоугольного тайлмапа в VRAM: из A1 строит VRAM-команду нейм-таблицы, двойной цикл D0×D1 ячеек — читает (A0)+ плюс база D3, пишет в порт данных, после строки adda D2 к A1 — копирование блока карты в плоскость
        ifne *-$21EBC
        fail "ROM start moved"
        endif

UploadAttributedTilemap:
        subq.w       #$1, d0                                       ; $021EBC
        subq.w       #$1, d1                                       ; $021EBE
        asl.l        #$1, d2                                       ; $021EC0

loc_021EC2:
        move.l       a1, d4                                        ; $021EC2
        lsl.l        #$2, d4                                       ; $021EC4
        lsr.w        #$2, d4                                       ; $021EC6
        swap         d4                                            ; $021EC8
        bset.l       #$1e, d4                                      ; $021ECA
        andi.l       #$7fff0003, d4                                ; $021ECE
        move.l       d4, VDP_CONTROL.l                             ; $021ED4
        adda.l       d2, a1                                        ; $021EDA
        move.l       d0, d5                                        ; $021EDC

loc_021EDE:
        move.w       (a0)+, d4                                     ; $021EDE
        add.w        d3, d4                                        ; $021EE0
        move.w       d4, VDP_DATA.l                                ; $021EE2
        dbra         d5, loc_021EDE                                ; $021EE8
        dbra         d1, loc_021EC2                                ; $021EEC
        rts                                                        ; $021EF0

loc_021EF2:
        adda.l       #$c000, a1                                    ; $021EF2
        bra.b        UploadAttributedTilemap                       ; $021EF8

loc_021EFA:
        adda.l       #$e000, a1                                    ; $021EFA
        bra.b        UploadAttributedTilemap                       ; $021F00
        ifne *-$21F02
        fail "ROM end moved"
        endif
