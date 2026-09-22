; $0292B0..$02932F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Рендер центрированной 2-строчной надписи: считает длину строки→центрирует X, строит VDP-команду записи в план A (0xC00004), пишет тайлы (символ-0x20)*4 из таблицы шрифта в порт данных VDP (A4)
        ifne *-$292B0
        fail "ROM start moved"
        endif

PrintCenteredText:
        lea.l        MenuTextGlyphPairs(pc), a1                    ; $0292B0
        clr.w        d1                                            ; $0292B4

loc_0292B6:
        tst.b        (a0, d1.w)                                    ; $0292B6
        beq.b        loc_0292C0                                    ; $0292BA
        addq.w       #$1, d1                                       ; $0292BC
        bra.b        loc_0292B6                                    ; $0292BE

loc_0292C0:
        asr.w        #$1, d1                                       ; $0292C0
        neg.w        d1                                            ; $0292C2
        addi.w       #$14, d1                                      ; $0292C4
        asl.w        #$1, d1                                       ; $0292C8
        add.w        d1, d0                                        ; $0292CA
        move.w       d0, -(a7)                                     ; $0292CC
        move.l       a0, -(a7)                                     ; $0292CE
        move.w       d0, d1                                        ; $0292D0
        andi.w       #$3fff, d1                                    ; $0292D2
        ori.w        #$4000, d1                                    ; $0292D6
        swap         d1                                            ; $0292DA
        lsr.w        #$8, d0                                       ; $0292DC
        lsr.w        #$6, d0                                       ; $0292DE
        move.w       d0, d1                                        ; $0292E0
        move.l       d1, VDP_CONTROL.l                             ; $0292E2

loc_0292E8:
        clr.w        d0                                            ; $0292E8
        move.b       (a0)+, d0                                     ; $0292EA
        beq.b        loc_0292FA                                    ; $0292EC
        subi.w       #$20, d0                                      ; $0292EE
        lsl.w        #$2, d0                                       ; $0292F2
        move.w       (a1, d0.w), (a4)                              ; $0292F4
        bra.b        loc_0292E8                                    ; $0292F8

loc_0292FA:
        addq.w       #$2, a1                                       ; $0292FA
        movea.l      (a7)+, a0                                     ; $0292FC
        move.w       (a7)+, d0                                     ; $0292FE
        addi.w       #$80, d0                                      ; $029300
        move.w       d0, d1                                        ; $029304
        andi.w       #$3fff, d1                                    ; $029306
        ori.w        #$4000, d1                                    ; $02930A
        swap         d1                                            ; $02930E
        lsr.w        #$8, d0                                       ; $029310
        lsr.w        #$6, d0                                       ; $029312
        move.w       d0, d1                                        ; $029314
        move.l       d1, VDP_CONTROL.l                             ; $029316

loc_02931C:
        clr.w        d0                                            ; $02931C
        move.b       (a0)+, d0                                     ; $02931E
        beq.b        loc_02932E                                    ; $029320
        subi.w       #$20, d0                                      ; $029322
        lsl.w        #$2, d0                                       ; $029326
        move.w       (a1, d0.w), (a4)                              ; $029328
        bra.b        loc_02931C                                    ; $02932C

loc_02932E:
        rts                                                        ; $02932E
        ifne *-$29330
        fail "ROM end moved"
        endif
