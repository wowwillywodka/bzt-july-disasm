; $000400..$000435 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вычисление VDP-команды записи в VRAM из D1/D0: swap+lsl/asl формируют адрес ((addr&0x3FFF)<<16)|(addr>>14), addi.l #0x40000003 ставит флаг записи VRAM, move.l D2,(A5) в контроль-порт; затем символы (A0)+ минус 0x20 (ASCII→тайл) пишутся словом в (A4) данные-порт, rts
        ifne *-$400
        fail "ROM start moved"
        endif

PrintRegionWarning:
        move.b       d1, d2                                        ; $000400
        andi.l       #$ff, d2                                      ; $000402
        swap         d2                                            ; $000408
        lsl.l        #$7, d2                                       ; $00040A
        move.b       d0, d3                                        ; $00040C
        andi.l       #$ff, d3                                      ; $00040E
        swap         d3                                            ; $000414
        asl.l        #$1, d3                                       ; $000416
        add.l        d3, d2                                        ; $000418
        addi.l       #$40000003, d2                                ; $00041A
        move.l       d2, (a5)                                      ; $000420

loc_000422:
        tst.b        (a0)                                          ; $000422
        beq.b        loc_000434                                    ; $000424
        move.b       (a0)+, d2                                     ; $000426
        subi.b       #$20, d2                                      ; $000428
        andi.w       #$ff, d2                                      ; $00042C
        move.w       d2, (a4)                                      ; $000430
        bra.b        loc_000422                                    ; $000432

loc_000434:
        rts                                                        ; $000434
        ifne *-$436
        fail "ROM end moved"
        endif
