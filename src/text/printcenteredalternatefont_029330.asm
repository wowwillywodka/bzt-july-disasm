; $029330..$0293AD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вариант центрированного рендера текста (другая база таблицы шрифта @-0x1ee,PC): тот же алгоритм центрирования и записи тайлов символов в VRAM через VDP-порты
        ifne *-$29330
        fail "ROM start moved"
        endif

PrintCenteredAlternateFont:
        lea.l        MenuTextGlyphPairs(pc), a1                    ; $029330
        clr.w        d1                                            ; $029334

loc_029336:
        tst.b        (a0, d1.w)                                    ; $029336
        beq.b        loc_029340                                    ; $02933A
        addq.w       #$1, d1                                       ; $02933C
        bra.b        loc_029336                                    ; $02933E

loc_029340:
        asr.w        #$1, d1                                       ; $029340
        neg.w        d1                                            ; $029342
        addi.w       #$14, d1                                      ; $029344
        asl.w        #$1, d1                                       ; $029348
        move.w       d0, -(a7)                                     ; $02934A
        move.l       a0, -(a7)                                     ; $02934C
        move.w       d0, d1                                        ; $02934E
        andi.w       #$3fff, d1                                    ; $029350
        ori.w        #$4000, d1                                    ; $029354
        swap         d1                                            ; $029358
        lsr.w        #$8, d0                                       ; $02935A
        lsr.w        #$6, d0                                       ; $02935C
        move.w       d0, d1                                        ; $02935E
        move.l       d1, VDP_CONTROL.l                             ; $029360

loc_029366:
        clr.w        d0                                            ; $029366
        move.b       (a0)+, d0                                     ; $029368
        beq.b        loc_029378                                    ; $02936A
        subi.w       #$20, d0                                      ; $02936C
        lsl.w        #$2, d0                                       ; $029370
        move.w       (a1, d0.w), (a4)                              ; $029372
        bra.b        loc_029366                                    ; $029376

loc_029378:
        addq.w       #$2, a1                                       ; $029378
        movea.l      (a7)+, a0                                     ; $02937A
        move.w       (a7)+, d0                                     ; $02937C
        addi.w       #$80, d0                                      ; $02937E
        move.w       d0, d1                                        ; $029382
        andi.w       #$3fff, d1                                    ; $029384
        ori.w        #$4000, d1                                    ; $029388
        swap         d1                                            ; $02938C
        lsr.w        #$8, d0                                       ; $02938E
        lsr.w        #$6, d0                                       ; $029390
        move.w       d0, d1                                        ; $029392
        move.l       d1, VDP_CONTROL.l                             ; $029394

loc_02939A:
        clr.w        d0                                            ; $02939A
        move.b       (a0)+, d0                                     ; $02939C
        beq.b        loc_0293AC                                    ; $02939E
        subi.w       #$20, d0                                      ; $0293A0
        lsl.w        #$2, d0                                       ; $0293A4
        move.w       (a1, d0.w), (a4)                              ; $0293A6
        bra.b        loc_02939A                                    ; $0293AA

loc_0293AC:
        rts                                                        ; $0293AC
        ifne *-$293AE
        fail "ROM end moved"
        endif
