; $00E1E2..$00E30B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Палитра-вспышка/затемнение при тряске-уроне через CRAM: ждёт vblank (-0x7ffe,A6), программирует команду записи CRAM в $C00004, по амплитуде (-0x720e,A6) выбирает маску затемнения (0x77/0x76/0x66/0x65/0x55) и льёт ORнутые цвета из ROM-таблицы 0x1641e0 в $C00000
        ifne *-$E1E2
        fail "ROM start moved"
        endif

UpdatePlayerHealthHudDigits:
        movem.l      d0-d3/a0/a4, -(a7)                            ; $00E1E2

loc_00E1E6:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $00E1E6
        bne.b        loc_00E1E6                                    ; $00E1EA
        move.l       #$4ca0003, VDP_CONTROL.l                      ; $00E1EC
        movea.l      #VDP_DATA, a4                                 ; $00E1F6
        move.w       (a4), d0                                      ; $00E1FC
        jsr          DelayVdpAccess.w                              ; $00E1FE
        andi.w       #$7ff, d0                                     ; $00E202
        lsl.w        #$5, d0                                       ; $00E206
        move.w       d0, d1                                        ; $00E208
        andi.w       #$3fff, d1                                    ; $00E20A
        ori.w        #$4000, d1                                    ; $00E20E
        swap         d1                                            ; $00E212
        lsr.w        #$8, d0                                       ; $00E214
        lsr.w        #$6, d0                                       ; $00E216
        move.w       d0, d1                                        ; $00E218
        move.l       d1, VDP_CONTROL.l                             ; $00E21A
        move.w       rPlayerHealth(a6), d0                         ; $00E220
        bpl.b        loc_00E22E                                    ; $00E224
        clr.w        d0                                            ; $00E226
        clr.w        rPlayerHealth(a6)                             ; $00E228
        bra.b        loc_00E23E                                    ; $00E22C

loc_00E22E:
        cmpi.w       #$64, d0                                      ; $00E22E
        bls.b        loc_00E23E                                    ; $00E232
        move.w       #$64, rPlayerHealth(a6)                       ; $00E234
        move.w       #$64, d0                                      ; $00E23A

loc_00E23E:
        mulu.w       #$64, d0                                      ; $00E23E
        subq.l       #$1, d0                                       ; $00E242
        bpl.b        loc_00E248                                    ; $00E244
        clr.l        d0                                            ; $00E246

loc_00E248:
        divu.w       #$64, d0                                      ; $00E248
        move.l       #$77777777, d1                                ; $00E24C
        cmpi.w       #$50, d0                                      ; $00E252
        bhi.b        loc_00E282                                    ; $00E256
        move.l       #$76767676, d1                                ; $00E258
        cmpi.w       #$3c, d0                                      ; $00E25E
        bhi.b        loc_00E282                                    ; $00E262
        move.l       #$66666666, d1                                ; $00E264
        cmpi.w       #$28, d0                                      ; $00E26A
        bhi.b        loc_00E282                                    ; $00E26E
        move.l       #$65656565, d1                                ; $00E270
        cmpi.w       #$14, d0                                      ; $00E276
        bhi.b        loc_00E282                                    ; $00E27A
        move.l       #$55555555, d1                                ; $00E27C

loc_00E282:
        movea.l      #HealthNumberMaskTiles, a0                              ; $00E282
        move.l       d1, d3                                        ; $00E288
        ror.l        #$4, d3                                       ; $00E28A

loc_00E28C:
        cmpi.w       #$a, d0                                       ; $00E28C
        bcs.b        loc_00E29C                                    ; $00E290
        subi.w       #$a, d0                                       ; $00E292
        adda.w       #$20, a0                                      ; $00E296
        bra.b        loc_00E28C                                    ; $00E29A

loc_00E29C:
        move.l       (a0)+, d2                                     ; $00E29C
        or.l         d1, d2                                        ; $00E29E
        move.l       d2, (a4)                                      ; $00E2A0
        move.l       (a0)+, d2                                     ; $00E2A2
        or.l         d3, d2                                        ; $00E2A4
        move.l       d2, (a4)                                      ; $00E2A6
        move.l       (a0)+, d2                                     ; $00E2A8
        or.l         d1, d2                                        ; $00E2AA
        move.l       d2, (a4)                                      ; $00E2AC
        move.l       (a0)+, d2                                     ; $00E2AE
        or.l         d3, d2                                        ; $00E2B0
        move.l       d2, (a4)                                      ; $00E2B2
        move.l       (a0)+, d2                                     ; $00E2B4
        or.l         d1, d2                                        ; $00E2B6
        move.l       d2, (a4)                                      ; $00E2B8
        move.l       (a0)+, d2                                     ; $00E2BA
        or.l         d3, d2                                        ; $00E2BC
        move.l       d2, (a4)                                      ; $00E2BE
        move.l       (a0)+, d2                                     ; $00E2C0
        or.l         d1, d2                                        ; $00E2C2
        move.l       d2, (a4)                                      ; $00E2C4
        move.l       (a0)+, d2                                     ; $00E2C6
        or.l         d3, d2                                        ; $00E2C8
        move.l       d2, (a4)                                      ; $00E2CA
        movea.l      #HealthNumberMaskTiles, a0                              ; $00E2CC
        lsl.w        #$5, d0                                       ; $00E2D2
        adda.w       d0, a0                                        ; $00E2D4
        move.l       (a0)+, d2                                     ; $00E2D6
        or.l         d1, d2                                        ; $00E2D8
        move.l       d2, (a4)                                      ; $00E2DA
        move.l       (a0)+, d2                                     ; $00E2DC
        or.l         d3, d2                                        ; $00E2DE
        move.l       d2, (a4)                                      ; $00E2E0
        move.l       (a0)+, d2                                     ; $00E2E2
        or.l         d1, d2                                        ; $00E2E4
        move.l       d2, (a4)                                      ; $00E2E6
        move.l       (a0)+, d2                                     ; $00E2E8
        or.l         d3, d2                                        ; $00E2EA
        move.l       d2, (a4)                                      ; $00E2EC
        move.l       (a0)+, d2                                     ; $00E2EE
        or.l         d1, d2                                        ; $00E2F0
        move.l       d2, (a4)                                      ; $00E2F2
        move.l       (a0)+, d2                                     ; $00E2F4
        or.l         d3, d2                                        ; $00E2F6
        move.l       d2, (a4)                                      ; $00E2F8
        move.l       (a0)+, d2                                     ; $00E2FA
        or.l         d1, d2                                        ; $00E2FC
        move.l       d2, (a4)                                      ; $00E2FE
        move.l       (a0)+, d2                                     ; $00E300
        or.l         d3, d2                                        ; $00E302
        move.l       d2, (a4)                                      ; $00E304
        movem.l      (a7)+, d0-d3/a0/a4                            ; $00E306
        rts                                                        ; $00E30A
        ifne *-$E30C
        fail "ROM end moved"
        endif
