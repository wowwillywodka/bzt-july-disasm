; $000200..$00028D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Reset/TMSS-гейт: два теста наличия железа tst.l ($A10008) (bne $20E) и tst.w ($A1000C) (bne $28C→bra $2FA); при наличии ветвь $20E ВХОДИТ в TMSS-разлочку (lea+move.l #'SEGA',($2F00,A1)@0x226), ветвь $28C её ПРОПУСКАЕТ
        ifne *-$200
        fail "ROM start moved"
        endif

ResetEntry:
        tst.l        $a10008.l                                     ; $000200
        bne.b        loc_00020E                                    ; $000206
        tst.w        $a1000c.l                                     ; $000208

loc_00020E:
        bne.b        loc_00028C                                    ; $00020E
        lea.l        BootHardwareTables(pc), a5                    ; $000210
        movem.w      (a5)+, d5-d7                                  ; $000214
        movem.l      (a5)+, a0-a4                                  ; $000218
        move.b       -$10ff(a1), d0                                ; $00021C
        andi.b       #$f, d0                                       ; $000220
        beq.b        loc_00022E                                    ; $000224
        move.l       #$53454741, $2f00(a1)                         ; $000226

loc_00022E:
        move.w       (a4), d0                                      ; $00022E
        moveq        #$0, d0                                       ; $000230
        movea.l      d0, a6                                        ; $000232
        move         a6, usp                                       ; $000234
        moveq        #$17, d1                                      ; $000236

loc_000238:
        move.b       (a5)+, d5                                     ; $000238
        move.w       d5, (a4)                                      ; $00023A
        add.w        d7, d5                                        ; $00023C
        dbra         d1, loc_000238                                ; $00023E
        move.l       (a5)+, (a4)                                   ; $000242
        move.w       d0, (a3)                                      ; $000244
        move.w       d7, (a1)                                      ; $000246
        move.w       d7, (a2)                                      ; $000248

loc_00024A:
        btst.b       d0, (a1)                                      ; $00024A
        bne.b        loc_00024A                                    ; $00024C
        moveq        #$25, d2                                      ; $00024E

loc_000250:
        move.b       (a5)+, (a0)+                                  ; $000250
        dbra         d2, loc_000250                                ; $000252
        move.w       d0, (a2)                                      ; $000256
        move.w       d0, (a1)                                      ; $000258
        move.w       d7, (a2)                                      ; $00025A

loc_00025C:
        move.l       d0, -(a6)                                     ; $00025C
        dbra         d6, loc_00025C                                ; $00025E
        move.l       (a5)+, (a4)                                   ; $000262
        move.l       (a5)+, (a4)                                   ; $000264
        moveq        #$1f, d3                                      ; $000266

loc_000268:
        move.l       d0, (a3)                                      ; $000268
        dbra         d3, loc_000268                                ; $00026A
        move.l       (a5)+, (a4)                                   ; $00026E
        moveq        #$13, d4                                      ; $000270

loc_000272:
        move.l       d0, (a3)                                      ; $000272
        dbra         d4, loc_000272                                ; $000274
        moveq        #$3, d5                                       ; $000278

loc_00027A:
        move.b       (a5)+, $11(a3)                                ; $00027A
        dbra         d5, loc_00027A                                ; $00027E
        move.w       d0, (a2)                                      ; $000282
        movem.l      (a6), d0-d7/a0-a6                             ; $000284
        move.w       #$2700, sr                                    ; $000288

loc_00028C:
        bra.b        CheckConsoleRegion                            ; $00028C
        ifne *-$28E
        fail "ROM end moved"
        endif
