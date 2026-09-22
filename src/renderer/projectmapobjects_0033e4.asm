; $0033E4..$00345B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проекция объектов в таблицу спрайтов: читает пары (col,row) из (-0x429e,A6) до терминатора #-1, переводит в экранные X/Y (lsl<<2, +0x9c/+0xe0, вычитание камеры -0x2260/-0x2262,A6), пишет атрибуты спрайта (Y,size,link,tile,X) в буфер (-0x7fc2,A6), инкремент счётчика спрайтов (-0x7fbe,A6)
        ifne *-$33E4
        fail "ROM start moved"
        endif

ProjectMapObjects:
        lea.l        -$429e(a6), a0                                ; $0033E4
        movea.l      -$7fc2(a6), a2                                ; $0033E8

loc_0033EC:
        clr.w        d0                                            ; $0033EC
        clr.w        d1                                            ; $0033EE
        move.b       (a0)+, d0                                     ; $0033F0
        move.b       (a0)+, d1                                     ; $0033F2
        cmpi.b       #$ff, d0                                      ; $0033F4
        beq.b        loc_003456                                    ; $0033F8
        lsl.w        #$2, d0                                       ; $0033FA
        lsl.w        #$2, d1                                       ; $0033FC
        addi.w       #$9c, d1                                      ; $0033FE
        addi.w       #$e0, d0                                      ; $003402
        move.w       -$2260(a6), d6                                ; $003406
        add.w        rMapWindowOriginY(a6), d6                     ; $00340A
        asl.w        #$2, d6                                       ; $00340E
        neg.w        d6                                            ; $003410
        add.w        d6, d1                                        ; $003412
        cmpi.w       #$9c, d1                                      ; $003414
        ble.b        loc_003454                                    ; $003418
        cmpi.w       #$11c, d1                                     ; $00341A
        bge.b        loc_003454                                    ; $00341E
        move.w       -$2262(a6), d6                                ; $003420
        add.w        rMapWindowOriginX(a6), d6                     ; $003424
        andi.w       #$fffe, d6                                    ; $003428
        asl.w        #$2, d6                                       ; $00342C
        neg.w        d6                                            ; $00342E
        add.w        d6, d0                                        ; $003430
        cmpi.w       #$e0, d0                                      ; $003432
        ble.b        loc_003454                                    ; $003436
        cmpi.w       #$160, d0                                     ; $003438
        bge.b        loc_003454                                    ; $00343C
        move.w       d1, (a2)+                                     ; $00343E
        move.w       -$7fbe(a6), d2                                ; $003440
        ori.w        #$0, d2                                       ; $003444
        move.w       d2, (a2)+                                     ; $003448
        addq.w       #$1, -$7fbe(a6)                               ; $00344A
        move.w       #$e286, (a2)+                                 ; $00344E
        move.w       d0, (a2)+                                     ; $003452

loc_003454:
        bra.b        loc_0033EC                                    ; $003454

loc_003456:
        move.l       a2, -$7fc2(a6)                                ; $003456
        rts                                                        ; $00345A
        ifne *-$345C
        fail "ROM end moved"
        endif
