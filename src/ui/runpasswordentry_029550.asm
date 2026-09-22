; $029550..$0299AB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Экран ввода имени/инициалов (хай-скор/ID): инициализирует VDP и тайлмап, рисует подписи через 0x292b0, строит спрайт-список курсора, по паду двигает курсор по сетке символов 8x9, редактирует буфер имени (backspace 0x7f / enter 0xd), играет UI-звуки через 0xdf84
        ifne *-$29550
        fail "ROM start moved"
        endif

RunPasswordEntry:
        clr.w        -$7ffe(a6)                                    ; $029550
        jsr          ClearVramLongs.w                              ; $029554
        jsr          ClearVideoMemory.w                            ; $029558
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $02955C
        move.w       #$287, d0                                     ; $029562
        jsr          DecompressBytePairToVramLong.l                ; $029566
        lea.l        Data_15CCB8.l, a0                             ; $02956C
        move.w       #$7, d7                                       ; $029572

loc_029576:
        move.l       (a0)+, VDP_DATA.l                             ; $029576
        dbra         d7, loc_029576                                ; $02957C
        move.l       #$c0400000, VDP_CONTROL.l                     ; $029580
        movea.l      #InterfacePalettes, a0                        ; $02958A
        move.l       (a0)+, (a4)                                   ; $029590
        move.l       (a0)+, (a4)                                   ; $029592
        move.l       (a0)+, (a4)                                   ; $029594
        move.l       (a0)+, (a4)                                   ; $029596
        move.l       (a0)+, (a4)                                   ; $029598
        move.l       (a0)+, (a4)                                   ; $02959A
        move.l       (a0)+, (a4)                                   ; $02959C
        move.l       (a0)+, (a4)                                   ; $02959E
        lea.l        -$7abc(a6), a0                                ; $0295A0
        move.l       #$ffffffff, (a0)                              ; $0295A4
        move.l       a0, rDmaQueueTail(a6)                         ; $0295AA
        move.w       #$1, -$7fbe(a6)                               ; $0295AE
        move.l       #$ff0044, -$7fc2(a6)                          ; $0295B4
        move.w       #$e080, d0                                    ; $0295BC
        lea.l        Data_0299BF(pc), a0                           ; $0295C0
        jsr          PrintCenteredText(pc)                         ; $0295C4
        move.w       #$e200, d0                                    ; $0295C8
        lea.l        Data_0299CF(pc), a0                           ; $0295CC
        jsr          PrintCenteredText(pc)                         ; $0295D0
        move.w       #$e300, d0                                    ; $0295D4
        lea.l        Data_0299DF(pc), a0                           ; $0295D8
        jsr          PrintCenteredText(pc)                         ; $0295DC
        move.w       #$e400, d0                                    ; $0295E0
        lea.l        Data_0299EF(pc), a0                           ; $0295E4
        jsr          PrintCenteredText(pc)                         ; $0295E8
        move.w       #$e500, d0                                    ; $0295EC
        lea.l        Data_0299FF(pc), a0                           ; $0295F0
        jsr          PrintCenteredText(pc)                         ; $0295F4
        move.w       #$e600, d0                                    ; $0295F8
        lea.l        Data_029A0F(pc), a0                           ; $0295FC
        jsr          PrintCenteredText(pc)                         ; $029600
        move.w       #$e700, d0                                    ; $029604
        lea.l        Data_029A1F(pc), a0                           ; $029608
        jsr          PrintCenteredText(pc)                         ; $02960C
        move.w       #$e800, d0                                    ; $029610
        lea.l        Data_029A2F(pc), a0                           ; $029614
        jsr          PrintCenteredText(pc)                         ; $029618
        move.w       #$e900, d0                                    ; $02961C
        lea.l        Data_029A3F(pc), a0                           ; $029620
        jsr          PrintCenteredText(pc)                         ; $029624
        move.w       #$ea00, d0                                    ; $029628
        lea.l        Data_029A4F(pc), a0                           ; $02962C
        jsr          PrintCenteredText(pc)                         ; $029630
        move.w       #$3, -$791e(a6)                               ; $029634
        move.w       #$8, -$791c(a6)                               ; $02963A
        clr.w        -$791a(a6)                                    ; $029640
        lea.l        -$7ff6(a6), a1                                ; $029644
        lea.l        -$7918(a6), a0                                ; $029648
        move.b       (a1)+, (a0)                                   ; $02964C
        move.b       (a1)+, $1(a0)                                 ; $02964E
        move.b       (a1)+, $2(a0)                                 ; $029652
        move.b       (a1)+, $3(a0)                                 ; $029656
        move.b       (a1)+, $4(a0)                                 ; $02965A
        move.b       (a1)+, $5(a0)                                 ; $02965E
        move.b       (a1)+, $6(a0)                                 ; $029662
        move.b       (a1)+, $7(a0)                                 ; $029666
        move.b       (a1)+, $8(a0)                                 ; $02966A
        clr.b        $9(a0)                                        ; $02966E
        cmpi.b       #$5f, -$7918(a6)                              ; $029672
        beq.b        loc_029680                                    ; $029678
        move.w       #$9, -$791a(a6)                               ; $02967A

loc_029680:
        move.w       #$eb80, d0                                    ; $029680
        jsr          PrintCenteredText(pc)                         ; $029684
        clr.l        -$6faa(a6)                                    ; $029688

loc_02968C:
        jsr          WaitForVBlank.w                               ; $02968C
        jsr          FlushDmaQueue.l                               ; $029690
        jsr          ReadController.w                              ; $029696
        move.w       #$1, -$7fbe(a6)                               ; $02969A
        lea.l        -$7fbc(a6), a2                                ; $0296A0
        move.l       a2, -$7fc2(a6)                                ; $0296A4
        move.w       -$791c(a6), d3                                ; $0296A8
        lsl.w        #$4, d3                                       ; $0296AC
        addi.w       #$9e, d3                                      ; $0296AE
        move.w       -$791e(a6), d4                                ; $0296B2
        lsl.w        #$4, d4                                       ; $0296B6
        addi.w       #$e5, d4                                      ; $0296B8
        move.w       d3, d5                                        ; $0296BC
        addi.w       #$b, d5                                       ; $0296BE
        move.w       d4, d6                                        ; $0296C2
        addq.w       #$6, d6                                       ; $0296C4
        cmpi.w       #$8, -$791c(a6)                               ; $0296C6
        bne.b        loc_0296DE                                    ; $0296CC
        move.w       -$791e(a6), d0                                ; $0296CE
        lea.l        PasswordCursorCoordinates(pc), a0             ; $0296D2
        lsl.w        #$2, d0                                       ; $0296D6
        adda.w       d0, a0                                        ; $0296D8
        move.w       (a0)+, d4                                     ; $0296DA
        move.w       (a0)+, d6                                     ; $0296DC

loc_0296DE:
        move.w       d3, (a2)+                                     ; $0296DE
        move.w       -$7fbe(a6), d0                                ; $0296E0
        addq.w       #$1, -$7fbe(a6)                               ; $0296E4
        ori.w        #$0, d0                                       ; $0296E8
        move.w       d0, (a2)+                                     ; $0296EC
        move.w       #$c31d, (a2)+                                 ; $0296EE
        move.w       d4, (a2)+                                     ; $0296F2
        move.w       d3, (a2)+                                     ; $0296F4
        move.w       -$7fbe(a6), d0                                ; $0296F6
        addq.w       #$1, -$7fbe(a6)                               ; $0296FA
        ori.w        #$0, d0                                       ; $0296FE
        move.w       d0, (a2)+                                     ; $029702
        move.w       #$cb1d, (a2)+                                 ; $029704
        move.w       d6, (a2)+                                     ; $029708
        move.w       d5, (a2)+                                     ; $02970A
        move.w       -$7fbe(a6), d0                                ; $02970C
        addq.w       #$1, -$7fbe(a6)                               ; $029710
        ori.w        #$0, d0                                       ; $029714
        move.w       d0, (a2)+                                     ; $029718
        move.w       #$d31d, (a2)+                                 ; $02971A
        move.w       d4, (a2)+                                     ; $02971E
        move.w       d5, (a2)+                                     ; $029720
        move.w       -$7fbe(a6), d0                                ; $029722
        addq.w       #$1, -$7fbe(a6)                               ; $029726
        ori.w        #$0, d0                                       ; $02972A
        move.w       d0, (a2)+                                     ; $02972E
        move.w       #$db1d, (a2)+                                 ; $029730
        move.w       d6, (a2)+                                     ; $029734
        move.l       a2, -$7fc2(a6)                                ; $029736
        jsr          UploadSpriteTable.w                           ; $02973A
        movea.l      rDmaQueueTail(a6), a0                         ; $02973E
        move.l       #$ffffffff, (a0)                              ; $029742
        btst.b       #$2, rControllerState(a6)                     ; $029748
        beq.b        loc_02979E                                    ; $02974E
        btst.b       #$2, rPreviousControllerState(a6)             ; $029750
        bne.b        loc_029760                                    ; $029756
        move.b       #$14, -$6fa9(a6)                              ; $029758
        bra.b        loc_029772                                    ; $02975E

loc_029760:
        subq.b       #$1, -$6fa9(a6)                               ; $029760
        cmpi.b       #$1, -$6fa9(a6)                               ; $029764
        bne.b        loc_0297A2                                    ; $02976A
        move.b       #$8, -$6fa9(a6)                               ; $02976C

loc_029772:
        cmpi.w       #$8, -$791c(a6)                               ; $029772
        bne.b        loc_029788                                    ; $029778
        lea.l        PasswordActionTableA(pc), a0                  ; $02977A
        move.w       -$791e(a6), d0                                ; $02977E
        move.b       (a0, d0.w), -$791d(a6)                        ; $029782

loc_029788:
        subq.w       #$1, -$791e(a6)                               ; $029788
        andi.w       #$7, -$791e(a6)                               ; $02978C
        move.w       #$62, d0                                      ; $029792
        jsr          SoundRoutine_00DF84.l                         ; $029796
        bra.b        loc_0297A2                                    ; $02979C

loc_02979E:
        clr.b        -$6fa9(a6)                                    ; $02979E

loc_0297A2:
        btst.b       #$3, rControllerState(a6)                     ; $0297A2
        beq.b        loc_0297F8                                    ; $0297A8
        btst.b       #$3, rPreviousControllerState(a6)             ; $0297AA
        bne.b        loc_0297BA                                    ; $0297B0
        move.b       #$14, -$6faa(a6)                              ; $0297B2
        bra.b        loc_0297CC                                    ; $0297B8

loc_0297BA:
        subq.b       #$1, -$6faa(a6)                               ; $0297BA
        cmpi.b       #$1, -$6faa(a6)                               ; $0297BE
        bne.b        loc_0297FC                                    ; $0297C4
        move.b       #$8, -$6faa(a6)                               ; $0297C6

loc_0297CC:
        cmpi.w       #$8, -$791c(a6)                               ; $0297CC
        bne.b        loc_0297E2                                    ; $0297D2
        lea.l        PasswordActionTableB(pc), a0                  ; $0297D4
        move.w       -$791e(a6), d0                                ; $0297D8
        move.b       (a0, d0.w), -$791d(a6)                        ; $0297DC

loc_0297E2:
        addq.w       #$1, -$791e(a6)                               ; $0297E2
        andi.w       #$7, -$791e(a6)                               ; $0297E6
        move.w       #$62, d0                                      ; $0297EC
        jsr          SoundRoutine_00DF84.l                         ; $0297F0
        bra.b        loc_0297FC                                    ; $0297F6

loc_0297F8:
        clr.b        -$6faa(a6)                                    ; $0297F8

loc_0297FC:
        btst.b       #$0, rControllerState(a6)                     ; $0297FC
        beq.b        loc_02983E                                    ; $029802
        btst.b       #$0, rPreviousControllerState(a6)             ; $029804
        bne.b        loc_029814                                    ; $02980A
        move.b       #$14, -$6fa8(a6)                              ; $02980C
        bra.b        loc_029826                                    ; $029812

loc_029814:
        subq.b       #$1, -$6fa8(a6)                               ; $029814
        cmpi.b       #$1, -$6fa8(a6)                               ; $029818
        bne.b        loc_029842                                    ; $02981E
        move.b       #$8, -$6fa8(a6)                               ; $029820

loc_029826:
        subq.w       #$1, -$791c(a6)                               ; $029826
        bpl.b        loc_029832                                    ; $02982A
        addi.w       #$9, -$791c(a6)                               ; $02982C

loc_029832:
        move.w       #$62, d0                                      ; $029832
        jsr          SoundRoutine_00DF84.l                         ; $029836
        bra.b        loc_029842                                    ; $02983C

loc_02983E:
        clr.b        -$6fa8(a6)                                    ; $02983E

loc_029842:
        btst.b       #$1, rControllerState(a6)                     ; $029842
        beq.b        loc_029888                                    ; $029848
        btst.b       #$1, rPreviousControllerState(a6)             ; $02984A
        bne.b        loc_02985A                                    ; $029850
        move.b       #$14, -$6fa7(a6)                              ; $029852
        bra.b        loc_02986C                                    ; $029858

loc_02985A:
        subq.b       #$1, -$6fa7(a6)                               ; $02985A
        cmpi.b       #$1, -$6fa7(a6)                               ; $02985E
        bne.b        loc_02988C                                    ; $029864
        move.b       #$8, -$6fa7(a6)                               ; $029866

loc_02986C:
        addq.w       #$1, -$791c(a6)                               ; $02986C
        cmpi.w       #$9, -$791c(a6)                               ; $029870
        bne.b        loc_02987C                                    ; $029876
        clr.w        -$791c(a6)                                    ; $029878

loc_02987C:
        move.w       #$62, d0                                      ; $02987C
        jsr          SoundRoutine_00DF84.l                         ; $029880
        bra.b        loc_02988C                                    ; $029886

loc_029888:
        clr.b        -$6fa7(a6)                                    ; $029888

loc_02988C:
        move.b       rControllerState(a6), d0                      ; $02988C
        andi.w       #$f0, d0                                      ; $029890
        beq.w        loc_02992A                                    ; $029894
        move.b       rPreviousControllerState(a6), d1              ; $029898
        and.b        d0, d1                                        ; $02989C
        cmp.b        d0, d1                                        ; $02989E
        beq.w        loc_02992A                                    ; $0298A0
        move.w       -$791c(a6), d0                                ; $0298A4
        lsl.w        #$3, d0                                       ; $0298A8
        add.w        -$791e(a6), d0                                ; $0298AA
        lea.l        PasswordKeyboardAlphabet(pc), a0              ; $0298AE
        move.b       (a0, d0.w), d0                                ; $0298B2
        beq.w        loc_02992E                                    ; $0298B6
        cmpi.b       #$d, d0                                       ; $0298BA
        beq.w        loc_029930                                    ; $0298BE
        cmpi.b       #$7f, d0                                      ; $0298C2
        beq.b        loc_0298FA                                    ; $0298C6
        cmpi.w       #$9, -$791a(a6)                               ; $0298C8
        beq.b        loc_02992A                                    ; $0298CE
        lea.l        -$7918(a6), a0                                ; $0298D0
        move.w       -$791a(a6), d1                                ; $0298D4
        move.b       d0, (a0, d1.w)                                ; $0298D8
        addq.w       #$1, d1                                       ; $0298DC
        move.w       d1, -$791a(a6)                                ; $0298DE
        move.w       #$60, d0                                      ; $0298E2
        jsr          SoundRoutine_00DF84.l                         ; $0298E6
        lea.l        -$7918(a6), a0                                ; $0298EC
        move.w       #$eb80, d0                                    ; $0298F0
        jsr          PrintCenteredText(pc)                         ; $0298F4
        bra.b        loc_02992A                                    ; $0298F8

loc_0298FA:
        tst.w        -$791a(a6)                                    ; $0298FA
        beq.b        loc_02992A                                    ; $0298FE
        lea.l        -$7918(a6), a0                                ; $029900
        move.w       -$791a(a6), d1                                ; $029904
        subq.w       #$1, d1                                       ; $029908
        move.b       #$5f, (a0, d1.w)                              ; $02990A
        move.w       d1, -$791a(a6)                                ; $029910
        move.w       #$60, d0                                      ; $029914
        jsr          SoundRoutine_00DF84.l                         ; $029918
        lea.l        -$7918(a6), a0                                ; $02991E
        move.w       #$eb80, d0                                    ; $029922
        jsr          PrintCenteredText(pc)                         ; $029926

loc_02992A:
        bra.w        loc_02968C                                    ; $02992A

loc_02992E:
        rts                                                        ; $02992E

loc_029930:
        tst.w        -$791a(a6)                                    ; $029930
        beq.b        loc_02996C                                    ; $029934
        cmpi.w       #$9, -$791a(a6)                               ; $029936
        bne.w        loc_029984                                    ; $02993C
        lea.l        -$7918(a6), a0                                ; $029940
        jsr          ValidatePasswordAndCheats.l                   ; $029944
        cmpi.w       #$ffff, d7                                    ; $02994A
        beq.b        loc_029984                                    ; $02994E
        lea.l        -$7918(a6), a0                                ; $029950
        lea.l        -$7ff6(a6), a1                                ; $029954
        move.b       (a0)+, (a1)+                                  ; $029958
        move.b       (a0)+, (a1)+                                  ; $02995A
        move.b       (a0)+, (a1)+                                  ; $02995C
        move.b       (a0)+, (a1)+                                  ; $02995E
        move.b       (a0)+, (a1)+                                  ; $029960
        move.b       (a0)+, (a1)+                                  ; $029962
        move.b       (a0)+, (a1)+                                  ; $029964
        move.b       (a0)+, (a1)+                                  ; $029966
        move.b       (a0)+, (a1)+                                  ; $029968
        rts                                                        ; $02996A

loc_02996C:
        lea.l        -$7ff6(a6), a1                                ; $02996C
        move.l       #$5f5f5f5f, (a1)+                             ; $029970
        move.l       #$5f5f5f5f, (a1)+                             ; $029976
        move.b       #$5f, (a1)+                                   ; $02997C
        clr.b        (a1)+                                         ; $029980
        rts                                                        ; $029982

loc_029984:
        lea.l        PasswordMenuStrings(pc), a0                   ; $029984
        move.w       #$eb80, d0                                    ; $029988
        jsr          PrintCenteredText(pc)                         ; $02998C
        move.w       #$28, d6                                      ; $029990

loc_029994:
        jsr          WaitForVBlank.w                               ; $029994
        dbra         d6, loc_029994                                ; $029998
        lea.l        -$7918(a6), a0                                ; $02999C
        move.w       #$eb80, d0                                    ; $0299A0
        jsr          PrintCenteredText(pc)                         ; $0299A4
        bra.w        loc_02968C                                    ; $0299A8
        ifne *-$299AC
        fail "ROM end moved"
        endif
