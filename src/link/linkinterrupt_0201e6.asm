; $0201E6..$020385 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обработчик внешнего прерывания (EX-INT от линк-кабеля): DDR порта3 ($A1000B=$20), проверка флага режима $2100 ($FF2C66), сохранение регистров, обмен RX/TX-блоками через буферы $FF2C70/$FF3470 с контролем чексуммы и счётчиком ошибок $FF2C5E
        ifne *-$201E6
        fail "ROM start moved"
        endif

LinkInterrupt:
        move.b       #$20, PAD2_CONTROL.l                          ; $0201E6
        cmpi.w       #$2100, $ff2c66.l                             ; $0201EE
        beq.b        loc_0201FA                                    ; $0201F6
        rte                                                        ; $0201F8

loc_0201FA:
        move.w       sr, -(a7)                                     ; $0201FA
        move.w       #$2700, sr                                    ; $0201FC
        movem.l      d0-d7/a0/a2-a3, -(a7)                         ; $020200
        movea.l      #PAD2_CONTROL, a2                             ; $020204
        movea.l      #PAD2_DATA, a3                                ; $02020A
        moveq        #$f, d2                                       ; $020210
        move.w       #$f0, d3                                      ; $020212
        clr.w        $ff2c5e.l                                     ; $020216
        bsr.w        loc_01FEAC                                    ; $02021C
        tst.w        $ff2c5e.l                                     ; $020220
        bne.w        loc_020352                                    ; $020226
        clr.w        d1                                            ; $02022A
        bsr.w        InputRoutine_01FEB6                           ; $02022C
        tst.w        $ff2c5e.l                                     ; $020230
        bne.w        loc_020352                                    ; $020236
        move.w       $ff2c6a.l, d4                                 ; $02023A
        move.w       d7, d0                                        ; $020240
        subq.w       #$1, d0                                       ; $020242
        bmi.w        loc_02026C                                    ; $020244
        lea.l        $ff2c70.l, a0                                 ; $020248

loc_02024E:
        bsr.w        InputRoutine_01FEB6                           ; $02024E
        tst.w        $ff2c5e.l                                     ; $020252
        bne.w        loc_020352                                    ; $020258
        add.w        d7, d1                                        ; $02025C
        move.w       d7, (a0, d4.w)                                ; $02025E
        addq.w       #$2, d4                                       ; $020262
        andi.w       #$7ff, d4                                     ; $020264
        dbra         d0, loc_02024E                                ; $020268

loc_02026C:
        bsr.w        InputRoutine_01FEB6                           ; $02026C
        tst.w        $ff2c5e.l                                     ; $020270
        bne.w        loc_020352                                    ; $020276
        cmp.w        d7, d1                                        ; $02027A
        bne.b        loc_020284                                    ; $02027C
        move.w       d4, $ff2c6a.l                                 ; $02027E

loc_020284:
        bsr.w        InputRoutine_01FF30                           ; $020284
        tst.w        $ff2c5e.l                                     ; $020288
        bne.w        loc_020352                                    ; $02028E
        bsr.w        InputRoutine_01FDD4                           ; $020292
        tst.w        $ff2c5e.l                                     ; $020296
        bne.w        loc_020352                                    ; $02029C
        move.w       d1, d7                                        ; $0202A0
        bsr.w        InputRoutine_01FDF6                           ; $0202A2
        tst.w        $ff2c5e.l                                     ; $0202A6
        bne.w        loc_020352                                    ; $0202AC
        move.w       $ff2c6e.l, d0                                 ; $0202B0
        sub.w        $ff2c6c.l, d0                                 ; $0202B6
        bpl.b        loc_0202C2                                    ; $0202BC
        addi.w       #$800, d0                                     ; $0202BE

loc_0202C2:
        asr.w        #$1, d0                                       ; $0202C2
        move.w       d0, d7                                        ; $0202C4
        bsr.w        InputRoutine_01FDF6                           ; $0202C6
        tst.w        $ff2c5e.l                                     ; $0202CA
        bne.w        loc_020352                                    ; $0202D0
        clr.w        d1                                            ; $0202D4
        move.w       $ff2c6c.l, d4                                 ; $0202D6
        subq.w       #$1, d0                                       ; $0202DC
        bmi.w        loc_020306                                    ; $0202DE
        lea.l        $ff3470.l, a0                                 ; $0202E2

loc_0202E8:
        move.w       (a0, d4.w), d7                                ; $0202E8
        addq.w       #$2, d4                                       ; $0202EC
        andi.w       #$7ff, d4                                     ; $0202EE
        add.w        d7, d1                                        ; $0202F2
        bsr.w        InputRoutine_01FDF6                           ; $0202F4
        tst.w        $ff2c5e.l                                     ; $0202F8
        bne.w        loc_020352                                    ; $0202FE
        dbra         d0, loc_0202E8                                ; $020302

loc_020306:
        move.w       d1, d7                                        ; $020306
        bsr.w        InputRoutine_01FDF6                           ; $020308
        tst.w        $ff2c5e.l                                     ; $02030C
        bne.w        loc_020352                                    ; $020312
        bsr.w        InputRoutine_01FE8A                           ; $020316
        tst.w        $ff2c5e.l                                     ; $02031A
        bne.w        loc_020352                                    ; $020320
        bsr.w        loc_01FEAC                                    ; $020324
        tst.w        $ff2c5e.l                                     ; $020328
        bne.w        loc_020352                                    ; $02032E
        bsr.w        InputRoutine_01FEB6                           ; $020332
        tst.w        $ff2c5e.l                                     ; $020336
        bne.w        loc_020352                                    ; $02033C
        cmp.w        d7, d1                                        ; $020340
        bne.b        loc_02034E                                    ; $020342
        move.w       $ff2c6e.l, $ff2c6c.l                          ; $020344

loc_02034E:
        bsr.w        InputRoutine_01FF30                           ; $02034E

loc_020352:
        tst.w        $ff2c5e.l                                     ; $020352
        bne.b        loc_020362                                    ; $020358
        clr.w        $ff2c60.l                                     ; $02035A
        bra.b        loc_020368                                    ; $020360

loc_020362:
        addq.w       #$5, $ff2c60.l                                ; $020362

loc_020368:
        move.b       #$20, (a2)                                    ; $020368
        bset.b       #$5, (a3)                                     ; $02036C

loc_020370:
        btst.b       #$6, (a3)                                     ; $020370
        beq.b        loc_020370                                    ; $020374
        movem.l      (a7)+, d0-d7/a0/a2-a3                         ; $020376
        move.b       #$a0, PAD2_CONTROL.l                          ; $02037A
        move.w       (a7)+, sr                                     ; $020382
        rte                                                        ; $020384
        ifne *-$20386
        fail "ROM end moved"
        endif
