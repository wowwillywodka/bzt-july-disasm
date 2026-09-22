; $0002FA..$0003FF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Чтение/инициализация контроллеров: move.b $A10001,D0 (версия железа), настройка регистров данных пада, затем lea (таблица регионов,PC)→A0 и цикл сравнения байта региона консоли
        ifne *-$2FA
        fail "ROM start moved"
        endif

CheckConsoleRegion:
        tst.w        VDP_CONTROL.l                                 ; $0002FA
        clr.l        d0                                            ; $000300
        move.b       IO_VERSION.l, d0                              ; $000302
        lsr.b        #$6, d0                                       ; $000308
        andi.b       #$3, d0                                       ; $00030A
        lea.l        RegionCompatibilityData(pc), a0               ; $00030E
        move.b       (a0, d0.w), d0                                ; $000312
        tst.b        d0                                            ; $000316
        beq.w        loc_0003FE                                    ; $000318
        lea.l        Data_0001F0.l, a0                             ; $00031C
        move.w       #$f, d1                                       ; $000322

loc_000326:
        cmp.b        (a0), d0                                      ; $000326
        beq.w        InitializeMachine                             ; $000328
        addq.l       #$1, a0                                       ; $00032C
        dbra         d1, loc_000326                                ; $00032E
        lea.l        VDP_DATA.l, a4                                ; $000332
        lea.l        VDP_CONTROL.l, a5                             ; $000338
        move.w       #$8164, (a5)                                  ; $00033E
        move.w       #$8230, (a5)                                  ; $000342
        move.w       #$8c81, (a5)                                  ; $000346
        move.w       #$8f02, (a5)                                  ; $00034A
        move.w       #$9001, (a5)                                  ; $00034E
        move.l       #$c0020000, (a5)                              ; $000352
        move.w       #$eee, (a4)                                   ; $000358
        move.l       #$40000000, (a5)                              ; $00035C
        lea.l        RegionWarningFont1Bpp(pc), a0                 ; $000362
        move.w       #$3a, d0                                      ; $000366
        move.l       #$10000000, d2                                ; $00036A

loc_000370:
        move.w       #$7, d6                                       ; $000370

loc_000374:
        move.b       (a0)+, d1                                     ; $000374
        move.l       #$0, d4                                       ; $000376
        move.w       #$7, d5                                       ; $00037C

loc_000380:
        rol.l        #$4, d2                                       ; $000380
        ror.b        #$1, d1                                       ; $000382
        bcc.b        loc_000388                                    ; $000384
        or.l         d2, d4                                        ; $000386

loc_000388:
        dbra         d5, loc_000380                                ; $000388
        move.l       d4, (a4)                                      ; $00038C
        dbra         d6, loc_000374                                ; $00038E
        dbra         d0, loc_000370                                ; $000392
        move.b       #$8, d1                                       ; $000396
        lea.l        RegionWarningStrings(pc), a0                  ; $00039A
        move.b       (a0)+, d0                                     ; $00039E
        bsr.w        PrintRegionWarning                            ; $0003A0
        lea.l        Data_0001F0.l, a1                             ; $0003A4

loc_0003AA:
        cmpi.b       #$20, (a1)                                    ; $0003AA
        beq.b        loc_0003F2                                    ; $0003AE
        lea.l        Data_00043A(pc), a2                           ; $0003B0

loc_0003B4:
        move.w       (a2)+, d4                                     ; $0003B4
        tst.b        d4                                            ; $0003B6
        beq.b        loc_0003EE                                    ; $0003B8
        cmp.b        (a1), d4                                      ; $0003BA
        bne.b        loc_0003EA                                    ; $0003BC
        cmpi.b       #$20, $1(a1)                                  ; $0003BE
        bne.b        loc_0003DA                                    ; $0003C4
        cmpa.l       #$1f0, a1                                     ; $0003C6
        beq.b        loc_0003DA                                    ; $0003CC
        lea.l        Data_00046B(pc), a0                           ; $0003CE
        move.b       (a0)+, d0                                     ; $0003D2
        addq.w       #$1, d1                                       ; $0003D4
        bsr.w        PrintRegionWarning                            ; $0003D6

loc_0003DA:
        lea.l        RegionCompatibilityData(pc), a0               ; $0003DA
        adda.l       (a2)+, a0                                     ; $0003DE
        move.b       (a0)+, d0                                     ; $0003E0
        addq.w       #$1, d1                                       ; $0003E2
        bsr.w        PrintRegionWarning                            ; $0003E4
        bra.b        loc_0003EE                                    ; $0003E8

loc_0003EA:
        addq.l       #$4, a2                                       ; $0003EA
        bra.b        loc_0003B4                                    ; $0003EC

loc_0003EE:
        addq.l       #$1, a1                                       ; $0003EE
        bra.b        loc_0003AA                                    ; $0003F0

loc_0003F2:
        lea.l        Data_00046E(pc), a0                           ; $0003F2
        move.b       (a0)+, d0                                     ; $0003F6
        addq.w       #$1, d1                                       ; $0003F8
        bsr.w        PrintRegionWarning                            ; $0003FA

loc_0003FE:
        bra.b        loc_0003FE                                    ; $0003FE
        ifne *-$400
        fail "ROM end moved"
        endif
