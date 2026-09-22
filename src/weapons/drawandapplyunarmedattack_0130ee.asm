; $0130EE..$01367F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Unarmed attack animation owns its hit timing. Variants2/3 hit at old phase4; variants0/1 take DMA paths and hit when phase becomes3. Ordinary action selects only0..3.
        ifne *-$130EE
        fail "ROM start moved"
        endif

DrawAndApplyUnarmedAttack:
; Unarmed attack animation owns its hit timing. Variants2/3 hit at old phase4; variants0/1 take DMA paths and hit when phase becomes3. Ordinary action selects only0..3.
        move.w       rWeaponActionPhase(a6), d3                    ; $0130EE
        bne.w        loc_013146                                    ; $0130F2
        lea.l        Data_0136B0.l, a0                             ; $0130F6
        move.w       (a0), d2                                      ; $0130FC
        add.w        d0, d2                                        ; $0130FE
        cmpi.w       #$f8, d2                                      ; $013100
        bgt.w        loc_013144                                    ; $013104
        movea.l      -$7fc2(a6), a2                                ; $013108
        move.w       (a0)+, (a2)                                   ; $01310C
        add.w        d0, (a2)+                                     ; $01310E
        move.w       -$7fbe(a6), d2                                ; $013110
        addq.w       #$1, -$7fbe(a6)                               ; $013114
        or.w         (a0)+, d2                                     ; $013118
        move.w       d2, (a2)+                                     ; $01311A
        move.w       (a0)+, (a2)+                                  ; $01311C
        move.w       (a0)+, (a2)                                   ; $01311E
        add.w        d1, (a2)+                                     ; $013120
        move.l       a2, -$7fc2(a6)                                ; $013122
        movea.l      -$7fc2(a6), a2                                ; $013126
        move.w       (a0)+, (a2)                                   ; $01312A
        add.w        d0, (a2)+                                     ; $01312C
        move.w       -$7fbe(a6), d2                                ; $01312E
        addq.w       #$1, -$7fbe(a6)                               ; $013132
        or.w         (a0)+, d2                                     ; $013136
        move.w       d2, (a2)+                                     ; $013138
        move.w       (a0)+, (a2)+                                  ; $01313A
        move.w       (a0)+, (a2)                                   ; $01313C
        add.w        d1, (a2)+                                     ; $01313E
        move.l       a2, -$7fc2(a6)                                ; $013140

loc_013144:
        rts                                                        ; $013144

loc_013146:
        cmpi.w       #$2, rUnarmedAttackVariant(a6)                ; $013146
        blt.w        loc_01348C                                    ; $01314C
        beq.w        loc_013160                                    ; $013150
        cmpi.w       #$3, rUnarmedAttackVariant(a6)                ; $013154
        beq.w        loc_0132F6                                    ; $01315A
        rts                                                        ; $01315E

loc_013160:
        move.w       rWeaponActionPhase(a6), d0                    ; $013160
        cmpi.b       #$1, d0                                       ; $013164
        beq.w        loc_01319C                                    ; $013168
        cmpi.b       #$2, d0                                       ; $01316C
        beq.w        loc_0131C0                                    ; $013170
        cmpi.b       #$3, d0                                       ; $013174
        beq.w        loc_0131E4                                    ; $013178
        cmpi.b       #$4, d0                                       ; $01317C
        beq.w        loc_013226                                    ; $013180
        cmpi.b       #$5, d0                                       ; $013184
        beq.w        loc_01326A                                    ; $013188
        cmpi.b       #$6, d0                                       ; $01318C
        beq.w        loc_0132AC                                    ; $013190
        cmpi.b       #$7, d0                                       ; $013194
        beq.w        loc_0132D0                                    ; $013198

loc_01319C:
        lea.l        Data_0136C0.l, a0                             ; $01319C
        movea.l      -$7fc2(a6), a2                                ; $0131A2
        move.w       (a0)+, (a2)+                                  ; $0131A6
        move.w       -$7fbe(a6), d2                                ; $0131A8
        addq.w       #$1, -$7fbe(a6)                               ; $0131AC
        or.w         (a0)+, d2                                     ; $0131B0
        move.w       d2, (a2)+                                     ; $0131B2
        move.l       (a0)+, (a2)+                                  ; $0131B4
        move.l       a2, -$7fc2(a6)                                ; $0131B6
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0131BA
        rts                                                        ; $0131BE

loc_0131C0:
        lea.l        Data_0136C8.l, a0                             ; $0131C0
        movea.l      -$7fc2(a6), a2                                ; $0131C6
        move.w       (a0)+, (a2)+                                  ; $0131CA
        move.w       -$7fbe(a6), d2                                ; $0131CC
        addq.w       #$1, -$7fbe(a6)                               ; $0131D0
        or.w         (a0)+, d2                                     ; $0131D4
        move.w       d2, (a2)+                                     ; $0131D6
        move.l       (a0)+, (a2)+                                  ; $0131D8
        move.l       a2, -$7fc2(a6)                                ; $0131DA
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0131DE
        rts                                                        ; $0131E2

loc_0131E4:
        lea.l        Data_0136D0.l, a0                             ; $0131E4
        movea.l      -$7fc2(a6), a2                                ; $0131EA
        move.w       (a0)+, (a2)+                                  ; $0131EE
        move.w       -$7fbe(a6), d2                                ; $0131F0
        addq.w       #$1, -$7fbe(a6)                               ; $0131F4
        or.w         (a0)+, d2                                     ; $0131F8
        move.w       d2, (a2)+                                     ; $0131FA
        move.l       (a0)+, (a2)+                                  ; $0131FC
        move.l       a2, -$7fc2(a6)                                ; $0131FE
        lea.l        Data_0136E0.l, a0                             ; $013202
        movea.l      -$7fc2(a6), a2                                ; $013208
        move.w       (a0)+, (a2)+                                  ; $01320C
        move.w       -$7fbe(a6), d2                                ; $01320E
        addq.w       #$1, -$7fbe(a6)                               ; $013212
        or.w         (a0)+, d2                                     ; $013216
        move.w       d2, (a2)+                                     ; $013218
        move.l       (a0)+, (a2)+                                  ; $01321A
        move.l       a2, -$7fc2(a6)                                ; $01321C
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013220
        rts                                                        ; $013224

loc_013226:
        lea.l        Data_0136D8.l, a0                             ; $013226
        movea.l      -$7fc2(a6), a2                                ; $01322C
        move.w       (a0)+, (a2)+                                  ; $013230
        move.w       -$7fbe(a6), d2                                ; $013232
        addq.w       #$1, -$7fbe(a6)                               ; $013236
        or.w         (a0)+, d2                                     ; $01323A
        move.w       d2, (a2)+                                     ; $01323C
        move.l       (a0)+, (a2)+                                  ; $01323E
        move.l       a2, -$7fc2(a6)                                ; $013240
        lea.l        Data_0136E8.l, a0                             ; $013244
        movea.l      -$7fc2(a6), a2                                ; $01324A
        move.w       (a0)+, (a2)+                                  ; $01324E
        move.w       -$7fbe(a6), d2                                ; $013250
        addq.w       #$1, -$7fbe(a6)                               ; $013254
        or.w         (a0)+, d2                                     ; $013258
        move.w       d2, (a2)+                                     ; $01325A
        move.l       (a0)+, (a2)+                                  ; $01325C
        move.l       a2, -$7fc2(a6)                                ; $01325E
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013262
        bra.w        ApplyUnarmedAnimationHit                      ; $013266

loc_01326A:
        lea.l        Data_0136D0.l, a0                             ; $01326A
        movea.l      -$7fc2(a6), a2                                ; $013270
        move.w       (a0)+, (a2)+                                  ; $013274
        move.w       -$7fbe(a6), d2                                ; $013276
        addq.w       #$1, -$7fbe(a6)                               ; $01327A
        or.w         (a0)+, d2                                     ; $01327E
        move.w       d2, (a2)+                                     ; $013280
        move.l       (a0)+, (a2)+                                  ; $013282
        move.l       a2, -$7fc2(a6)                                ; $013284
        lea.l        Data_0136E0.l, a0                             ; $013288
        movea.l      -$7fc2(a6), a2                                ; $01328E
        move.w       (a0)+, (a2)+                                  ; $013292
        move.w       -$7fbe(a6), d2                                ; $013294
        addq.w       #$1, -$7fbe(a6)                               ; $013298
        or.w         (a0)+, d2                                     ; $01329C
        move.w       d2, (a2)+                                     ; $01329E
        move.l       (a0)+, (a2)+                                  ; $0132A0
        move.l       a2, -$7fc2(a6)                                ; $0132A2
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0132A6
        rts                                                        ; $0132AA

loc_0132AC:
        lea.l        Data_0136C8.l, a0                             ; $0132AC
        movea.l      -$7fc2(a6), a2                                ; $0132B2
        move.w       (a0)+, (a2)+                                  ; $0132B6
        move.w       -$7fbe(a6), d2                                ; $0132B8
        addq.w       #$1, -$7fbe(a6)                               ; $0132BC
        or.w         (a0)+, d2                                     ; $0132C0
        move.w       d2, (a2)+                                     ; $0132C2
        move.l       (a0)+, (a2)+                                  ; $0132C4
        move.l       a2, -$7fc2(a6)                                ; $0132C6
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0132CA
        rts                                                        ; $0132CE

loc_0132D0:
        lea.l        Data_0136C0.l, a0                             ; $0132D0
        movea.l      -$7fc2(a6), a2                                ; $0132D6
        move.w       (a0)+, (a2)+                                  ; $0132DA
        move.w       -$7fbe(a6), d2                                ; $0132DC
        addq.w       #$1, -$7fbe(a6)                               ; $0132E0
        or.w         (a0)+, d2                                     ; $0132E4
        move.w       d2, (a2)+                                     ; $0132E6
        move.l       (a0)+, (a2)+                                  ; $0132E8
        move.l       a2, -$7fc2(a6)                                ; $0132EA
        move.w       #$0, rWeaponActionPhase(a6)                   ; $0132EE
        rts                                                        ; $0132F4

loc_0132F6:
        move.w       rWeaponActionPhase(a6), d0                    ; $0132F6
        cmpi.b       #$1, d0                                       ; $0132FA
        beq.w        loc_013332                                    ; $0132FE
        cmpi.b       #$2, d0                                       ; $013302
        beq.w        loc_013356                                    ; $013306
        cmpi.b       #$3, d0                                       ; $01330A
        beq.w        loc_01337A                                    ; $01330E
        cmpi.b       #$4, d0                                       ; $013312
        beq.w        loc_0133BC                                    ; $013316
        cmpi.b       #$5, d0                                       ; $01331A
        beq.w        loc_013400                                    ; $01331E
        cmpi.b       #$6, d0                                       ; $013322
        beq.w        loc_013442                                    ; $013326
        cmpi.b       #$7, d0                                       ; $01332A
        beq.w        loc_013466                                    ; $01332E

loc_013332:
        lea.l        WeaponAnimationSpriteMappings.l, a0           ; $013332
        movea.l      -$7fc2(a6), a2                                ; $013338
        move.w       (a0)+, (a2)+                                  ; $01333C
        move.w       -$7fbe(a6), d2                                ; $01333E
        addq.w       #$1, -$7fbe(a6)                               ; $013342
        or.w         (a0)+, d2                                     ; $013346
        move.w       d2, (a2)+                                     ; $013348
        move.l       (a0)+, (a2)+                                  ; $01334A
        move.l       a2, -$7fc2(a6)                                ; $01334C
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013350
        rts                                                        ; $013354

loc_013356:
        lea.l        Data_013688.l, a0                             ; $013356
        movea.l      -$7fc2(a6), a2                                ; $01335C
        move.w       (a0)+, (a2)+                                  ; $013360
        move.w       -$7fbe(a6), d2                                ; $013362
        addq.w       #$1, -$7fbe(a6)                               ; $013366
        or.w         (a0)+, d2                                     ; $01336A
        move.w       d2, (a2)+                                     ; $01336C
        move.l       (a0)+, (a2)+                                  ; $01336E
        move.l       a2, -$7fc2(a6)                                ; $013370
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013374
        rts                                                        ; $013378

loc_01337A:
        lea.l        Data_013690.l, a0                             ; $01337A
        movea.l      -$7fc2(a6), a2                                ; $013380
        move.w       (a0)+, (a2)+                                  ; $013384
        move.w       -$7fbe(a6), d2                                ; $013386
        addq.w       #$1, -$7fbe(a6)                               ; $01338A
        or.w         (a0)+, d2                                     ; $01338E
        move.w       d2, (a2)+                                     ; $013390
        move.l       (a0)+, (a2)+                                  ; $013392
        move.l       a2, -$7fc2(a6)                                ; $013394
        lea.l        Data_0136A0.l, a0                             ; $013398
        movea.l      -$7fc2(a6), a2                                ; $01339E
        move.w       (a0)+, (a2)+                                  ; $0133A2
        move.w       -$7fbe(a6), d2                                ; $0133A4
        addq.w       #$1, -$7fbe(a6)                               ; $0133A8
        or.w         (a0)+, d2                                     ; $0133AC
        move.w       d2, (a2)+                                     ; $0133AE
        move.l       (a0)+, (a2)+                                  ; $0133B0
        move.l       a2, -$7fc2(a6)                                ; $0133B2
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0133B6
        rts                                                        ; $0133BA

loc_0133BC:
        lea.l        Data_013698.l, a0                             ; $0133BC
        movea.l      -$7fc2(a6), a2                                ; $0133C2
        move.w       (a0)+, (a2)+                                  ; $0133C6
        move.w       -$7fbe(a6), d2                                ; $0133C8
        addq.w       #$1, -$7fbe(a6)                               ; $0133CC
        or.w         (a0)+, d2                                     ; $0133D0
        move.w       d2, (a2)+                                     ; $0133D2
        move.l       (a0)+, (a2)+                                  ; $0133D4
        move.l       a2, -$7fc2(a6)                                ; $0133D6
        lea.l        Data_0136A8.l, a0                             ; $0133DA
        movea.l      -$7fc2(a6), a2                                ; $0133E0
        move.w       (a0)+, (a2)+                                  ; $0133E4
        move.w       -$7fbe(a6), d2                                ; $0133E6
        addq.w       #$1, -$7fbe(a6)                               ; $0133EA
        or.w         (a0)+, d2                                     ; $0133EE
        move.w       d2, (a2)+                                     ; $0133F0
        move.l       (a0)+, (a2)+                                  ; $0133F2
        move.l       a2, -$7fc2(a6)                                ; $0133F4
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0133F8
        bra.w        ApplyUnarmedAnimationHit                      ; $0133FC

loc_013400:
        lea.l        Data_013690.l, a0                             ; $013400
        movea.l      -$7fc2(a6), a2                                ; $013406
        move.w       (a0)+, (a2)+                                  ; $01340A
        move.w       -$7fbe(a6), d2                                ; $01340C
        addq.w       #$1, -$7fbe(a6)                               ; $013410
        or.w         (a0)+, d2                                     ; $013414
        move.w       d2, (a2)+                                     ; $013416
        move.l       (a0)+, (a2)+                                  ; $013418
        move.l       a2, -$7fc2(a6)                                ; $01341A
        lea.l        Data_0136A0.l, a0                             ; $01341E
        movea.l      -$7fc2(a6), a2                                ; $013424
        move.w       (a0)+, (a2)+                                  ; $013428
        move.w       -$7fbe(a6), d2                                ; $01342A
        addq.w       #$1, -$7fbe(a6)                               ; $01342E
        or.w         (a0)+, d2                                     ; $013432
        move.w       d2, (a2)+                                     ; $013434
        move.l       (a0)+, (a2)+                                  ; $013436
        move.l       a2, -$7fc2(a6)                                ; $013438
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $01343C
        rts                                                        ; $013440

loc_013442:
        lea.l        Data_013688.l, a0                             ; $013442
        movea.l      -$7fc2(a6), a2                                ; $013448
        move.w       (a0)+, (a2)+                                  ; $01344C
        move.w       -$7fbe(a6), d2                                ; $01344E
        addq.w       #$1, -$7fbe(a6)                               ; $013452
        or.w         (a0)+, d2                                     ; $013456
        move.w       d2, (a2)+                                     ; $013458
        move.l       (a0)+, (a2)+                                  ; $01345A
        move.l       a2, -$7fc2(a6)                                ; $01345C
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013460
        rts                                                        ; $013464

loc_013466:
        lea.l        WeaponAnimationSpriteMappings.l, a0           ; $013466
        movea.l      -$7fc2(a6), a2                                ; $01346C
        move.w       (a0)+, (a2)+                                  ; $013470
        move.w       -$7fbe(a6), d2                                ; $013472
        addq.w       #$1, -$7fbe(a6)                               ; $013476
        or.w         (a0)+, d2                                     ; $01347A
        move.w       d2, (a2)+                                     ; $01347C
        move.l       (a0)+, (a2)+                                  ; $01347E
        move.l       a2, -$7fc2(a6)                                ; $013480
        move.w       #$0, rWeaponActionPhase(a6)                   ; $013484
        rts                                                        ; $01348A

loc_01348C:
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $01348C
        cmpi.w       #$2, rUnarmedAttackVariant(a6)                ; $013490
        bcc.b        loc_0134D4                                    ; $013496
        cmpi.w       #$1, d3                                       ; $013498
        bne.b        loc_0134B2                                    ; $01349C
        move.l       #HeldWeaponGraphics, d4                       ; $01349E
        move.w       #$9de0, d5                                    ; $0134A4
        move.w       #$150, d6                                     ; $0134A8
        jmp          QueueVramDma.l                                ; $0134AC

loc_0134B2:
        cmpi.w       #$5, d3                                       ; $0134B2
        bne.b        loc_0134D0                                    ; $0134B6
        clr.w        rWeaponActionPhase(a6)                        ; $0134B8
        move.l       #Data_15D6D8, d4                              ; $0134BC
        move.w       #$9de0, d5                                    ; $0134C2
        move.w       #$150, d6                                     ; $0134C6
        jmp          QueueVramDma.l                                ; $0134CA

loc_0134D0:
        subq.w       #$1, d3                                       ; $0134D0
        bra.b        loc_0134E0                                    ; $0134D2

loc_0134D4:
        cmpi.w       #$4, rWeaponActionPhase(a6)                   ; $0134D4
        bne.b        loc_0134E0                                    ; $0134DA
        clr.w        rWeaponActionPhase(a6)                        ; $0134DC

loc_0134E0:
        lea.l        WeaponOverlaySpriteMappings(pc), a0           ; $0134E0
        move.w       rUnarmedAttackVariant(a6), d2                 ; $0134E4
        lsl.w        #$3, d2                                       ; $0134E8
        adda.w       d2, a0                                        ; $0134EA
        lsl.w        #$1, d2                                       ; $0134EC
        adda.w       d2, a0                                        ; $0134EE
        subq.w       #$1, d3                                       ; $0134F0
        lsl.w        #$3, d3                                       ; $0134F2
        adda.w       d3, a0                                        ; $0134F4
        movea.l      -$7fc2(a6), a2                                ; $0134F6
        move.w       (a0)+, (a2)+                                  ; $0134FA
        move.w       -$7fbe(a6), d2                                ; $0134FC
        or.w         (a0)+, d2                                     ; $013500
        addq.w       #$1, -$7fbe(a6)                               ; $013502
        move.w       d2, (a2)+                                     ; $013506
        move.l       (a0)+, (a2)+                                  ; $013508
        move.l       a2, -$7fc2(a6)                                ; $01350A
        cmpi.w       #$4, rUnarmedAttackVariant(a6)                ; $01350E
        bcs.b        loc_013532                                    ; $013514
        adda.w       #$28, a0                                      ; $013516
        movea.l      -$7fc2(a6), a2                                ; $01351A
        move.w       (a0)+, (a2)+                                  ; $01351E
        move.w       -$7fbe(a6), d2                                ; $013520
        or.w         (a0)+, d2                                     ; $013524
        addq.w       #$1, -$7fbe(a6)                               ; $013526
        move.w       d2, (a2)+                                     ; $01352A
        move.l       (a0)+, (a2)+                                  ; $01352C
        move.l       a2, -$7fc2(a6)                                ; $01352E

loc_013532:
        cmpi.w       #$3, rWeaponActionPhase(a6)                   ; $013532
        bne.w        loc_01367E                                    ; $013538

ApplyUnarmedAnimationHit:
; Unarmed hit uses nearest flagged-actor selector then projected forward/lateral gates. Hit D0 is distance-like parameter $300 (character3:$C8,character4:$1F4), not HP damage.
        movea.l      #$0, a0                                       ; $01353C
        move.w       #$40, d5                                      ; $013542
        tst.w        -$71d8(a6)                                    ; $013546
        beq.b        loc_013558                                    ; $01354A
        bmi.b        loc_013554                                    ; $01354C
        move.w       #$80, d5                                      ; $01354E
        bra.b        loc_013558                                    ; $013552

loc_013554:
        move.w       #$8, d5                                       ; $013554

loc_013558:
        jsr          EnemiesRoutine_01E4FA.l                       ; $013558
        cmpa.l       #$ffffffff, a1                                ; $01355E
        beq.w        loc_013642                                    ; $013564
        movea.l      a1, a0                                        ; $013568
        move.w       $24(a0), d4                                   ; $01356A
        sub.w        rPlayerX(a6), d4                              ; $01356E
        move.w       d4, d5                                        ; $013572
        muls.w       -$71f2(a6), d4                                ; $013574
        move.w       $26(a0), d3                                   ; $013578
        sub.w        rPlayerY(a6), d3                              ; $01357C
        move.w       d3, d6                                        ; $013580
        muls.w       -$71f0(a6), d3                                ; $013582
        add.l        d3, d4                                        ; $013586
        muls.w       -$71f2(a6), d6                                ; $013588
        muls.w       -$71f0(a6), d5                                ; $01358C
        sub.l        d5, d6                                        ; $013590
        asr.l        #$6, d4                                       ; $013592
        cmpi.l       #$2, d4                                       ; $013594
        blt.w        loc_013642                                    ; $01359A
        move.l       #$10000, d5                                   ; $01359E
        divs.w       d4, d5                                        ; $0135A4
        cmpi.w       #$3, rSelectedCharacter(a6)                   ; $0135A6
        beq.b        loc_0135B8                                    ; $0135AC
        cmpi.w       #$a0, d5                                      ; $0135AE
        bls.w        loc_013642                                    ; $0135B2
        bra.b        loc_0135C0                                    ; $0135B6

loc_0135B8:
        cmpi.w       #$64, d5                                      ; $0135B8
        bls.w        loc_013642                                    ; $0135BC

loc_0135C0:
        divs.w       d4, d6                                        ; $0135C0
        bpl.b        loc_0135C6                                    ; $0135C2
        neg.w        d6                                            ; $0135C4

loc_0135C6:
        move.w       d5, d4                                        ; $0135C6
        asr.w        #$3, d4                                       ; $0135C8
        cmp.w        d4, d6                                        ; $0135CA
        bhi.w        loc_013642                                    ; $0135CC
        move.w       -$71f0(a6), d3                                ; $0135D0
        neg.w        d3                                            ; $0135D4
        move.w       -$71f2(a6), d4                                ; $0135D6
        btst.b       #$0, -$6f6d(a6)                               ; $0135DA
        bne.b        loc_0135E6                                    ; $0135E0
        neg.w        d3                                            ; $0135E2
        neg.w        d4                                            ; $0135E4

loc_0135E6:
        asr.w        #$2, d3                                       ; $0135E6
        asr.w        #$2, d4                                       ; $0135E8
        add.w        rPlayerX(a6), d3                              ; $0135EA
        add.w        rPlayerY(a6), d4                              ; $0135EE
        sub.w        $24(a0), d3                                   ; $0135F2
        sub.w        $26(a0), d4                                   ; $0135F6
        move.w       #$300, d0                                     ; $0135FA
        cmpi.w       #$3, rSelectedCharacter(a6)                   ; $0135FE
        bne.b        loc_01360A                                    ; $013604
        move.w       #$c8, d0                                      ; $013606

loc_01360A:
        cmpi.w       #$4, rSelectedCharacter(a6)                   ; $01360A
        bne.b        loc_013616                                    ; $013610
        move.w       #$1f4, d0                                     ; $013612

loc_013616:
        movea.l      ActorHitCallback(a0), a1                      ; $013616
        jsr          (a1)                                          ; $01361A
        clr.w        -$55a0(a6)                                    ; $01361C
        clr.w        -$559e(a6)                                    ; $013620
        move.w       #$2e, d0                                      ; $013624
        cmpi.w       #$2, rUnarmedAttackVariant(a6)                ; $013628
        bcc.b        loc_013634                                    ; $01362E
        move.w       #$24, d0                                      ; $013630

loc_013634:
        jsr          SoundRoutine_00DF84.l                         ; $013634
        move.w       #$f, -$559e(a6)                               ; $01363A
        rts                                                        ; $013640

loc_013642:
        move.w       -$71f2(a6), d0                                ; $013642
        asr.w        #$2, d0                                       ; $013646
        add.w        rPlayerX(a6), d0                              ; $013648
        move.w       -$71f0(a6), d1                                ; $01364C
        asr.w        #$2, d1                                       ; $013650
        add.w        rPlayerY(a6), d1                              ; $013652
        jsr          TestProjectilePointInVisibleMap.l             ; $013656
        beq.b        loc_01367E                                    ; $01365C
        jsr          DisabledPlayerProjectileSurfaceTest.l         ; $01365E
        bne.b        loc_01367E                                    ; $013664
        clr.w        -$55a0(a6)                                    ; $013666
        clr.w        -$559e(a6)                                    ; $01366A
        move.w       #$2a, d0                                      ; $01366E
        jsr          SoundRoutine_00DF84.l                         ; $013672
        move.w       #$f, -$559e(a6)                               ; $013678

loc_01367E:
        rts                                                        ; $01367E
        ifne *-$13680
        fail "ROM end moved"
        endif
