; $029F62..$02A40F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Декодер ввода пароля/чит-фраз: сверяет ASCII-строку (A0) с 'Highrise!'/'Basement!'/'Boxing!!!' (даёт уровень/оружие), иначе декодирует 0x2A450+0x29BD6, проверяет чек-сумму, распаковывает поля статуса в (-0x53CA..,A6) и масштабирует по таблице 0x11F24; D7=0 ок, -1 ошибка
        ifne *-$29F62
        fail "ROM start moved"
        endif

ValidatePasswordAndCheats:
        cmpi.b       #$48, (a0)                                    ; $029F62
        bne.b        loc_029FB6                                    ; $029F66
        cmpi.b       #$69, $1(a0)                                  ; $029F68
        bne.b        loc_029FB6                                    ; $029F6E
        cmpi.b       #$67, $2(a0)                                  ; $029F70
        bne.b        loc_029FB6                                    ; $029F76
        cmpi.b       #$68, $3(a0)                                  ; $029F78
        bne.b        loc_029FB6                                    ; $029F7E
        cmpi.b       #$72, $4(a0)                                  ; $029F80
        bne.b        loc_029FB6                                    ; $029F86
        cmpi.b       #$69, $5(a0)                                  ; $029F88
        bne.b        loc_029FB6                                    ; $029F8E
        cmpi.b       #$73, $6(a0)                                  ; $029F90
        bne.b        loc_029FB6                                    ; $029F96
        cmpi.b       #$65, $7(a0)                                  ; $029F98
        bne.b        loc_029FB6                                    ; $029F9E
        cmpi.b       #$21, $8(a0)                                  ; $029FA0
        bne.b        loc_029FB6                                    ; $029FA6
        bsr.w        InitializeDefaultProgress                     ; $029FA8
        move.b       #$10, rLevelSelection(a6)                     ; $029FAC
        clr.w        d7                                            ; $029FB2
        rts                                                        ; $029FB4

loc_029FB6:
        cmpi.b       #$42, (a0)                                    ; $029FB6
        bne.b        loc_02A00A                                    ; $029FBA
        cmpi.b       #$61, $1(a0)                                  ; $029FBC
        bne.b        loc_02A00A                                    ; $029FC2
        cmpi.b       #$73, $2(a0)                                  ; $029FC4
        bne.b        loc_02A00A                                    ; $029FCA
        cmpi.b       #$65, $3(a0)                                  ; $029FCC
        bne.b        loc_02A00A                                    ; $029FD2
        cmpi.b       #$6d, $4(a0)                                  ; $029FD4
        bne.b        loc_02A00A                                    ; $029FDA
        cmpi.b       #$65, $5(a0)                                  ; $029FDC
        bne.b        loc_02A00A                                    ; $029FE2
        cmpi.b       #$6e, $6(a0)                                  ; $029FE4
        bne.b        loc_02A00A                                    ; $029FEA
        cmpi.b       #$74, $7(a0)                                  ; $029FEC
        bne.b        loc_02A00A                                    ; $029FF2
        cmpi.b       #$21, $8(a0)                                  ; $029FF4
        bne.b        loc_02A00A                                    ; $029FFA
        bsr.w        InitializeDefaultProgress                     ; $029FFC
        move.b       #$20, rLevelSelection(a6)                     ; $02A000
        clr.w        d7                                            ; $02A006
        rts                                                        ; $02A008

loc_02A00A:
        cmpi.b       #$42, (a0)                                    ; $02A00A
        bne.w        loc_02A098                                    ; $02A00E
        cmpi.b       #$6f, $1(a0)                                  ; $02A012
        bne.w        loc_02A098                                    ; $02A018
        cmpi.b       #$78, $2(a0)                                  ; $02A01C
        bne.w        loc_02A098                                    ; $02A022
        cmpi.b       #$69, $3(a0)                                  ; $02A026
        bne.b        loc_02A098                                    ; $02A02C
        cmpi.b       #$6e, $4(a0)                                  ; $02A02E
        bne.b        loc_02A098                                    ; $02A034
        cmpi.b       #$67, $5(a0)                                  ; $02A036
        bne.b        loc_02A098                                    ; $02A03C
        cmpi.b       #$21, $6(a0)                                  ; $02A03E
        bne.b        loc_02A098                                    ; $02A044
        cmpi.b       #$21, $7(a0)                                  ; $02A046
        bne.b        loc_02A098                                    ; $02A04C
        cmpi.b       #$21, $8(a0)                                  ; $02A04E
        bne.b        loc_02A098                                    ; $02A054
        clr.b        rSavedInventoryItem0(a6)                      ; $02A056
        clr.b        rSavedInventoryItem1(a6)                      ; $02A05A
        clr.b        rSavedInventoryItem2(a6)                      ; $02A05E
        clr.b        rSavedInventoryItem3(a6)                      ; $02A062
        clr.b        rSavedInventoryItem4(a6)                      ; $02A066
        move.b       #$1, rCharacterAvailable0(a6)                 ; $02A06A
        move.b       #$1, rCharacterAvailable1(a6)                 ; $02A070
        move.b       #$1, rCharacterAvailable2(a6)                 ; $02A076
        move.b       #$1, rCharacterAvailable3(a6)                 ; $02A07C
        move.b       #$1, rCharacterAvailable4(a6)                 ; $02A082
        move.b       #$63, rSavedHealth(a6)                        ; $02A088
        move.b       #$1f, rLevelSelection(a6)                     ; $02A08E
        clr.w        d7                                            ; $02A094
        rts                                                        ; $02A096

loc_02A098:
        movea.l      a0, a2                                        ; $02A098
        lea.l        -$53ae(a6), a1                                ; $02A09A
        clr.w        d1                                            ; $02A09E
        move.w       #$8, d6                                       ; $02A0A0

loc_02A0A4:
        bsr.w        DecodePasswordCharacter                       ; $02A0A4
        bsr.w        WritePasswordBit                              ; $02A0A8
        bsr.w        WritePasswordBit                              ; $02A0AC
        bsr.w        WritePasswordBit                              ; $02A0B0
        bsr.w        WritePasswordBit                              ; $02A0B4
        bsr.w        WritePasswordBit                              ; $02A0B8
        bsr.w        WritePasswordBit                              ; $02A0BC
        dbra         d6, loc_02A0A4                                ; $02A0C0
        lea.l        -$53ae(a6), a2                                ; $02A0C4
        lea.l        -$53b8(a6), a1                                ; $02A0C8
        bsr.w        EncodePasswordBytes                           ; $02A0CC
        lea.l        -$53b8(a6), a2                                ; $02A0D0
        clr.w        d2                                            ; $02A0D4
        clr.w        d3                                            ; $02A0D6
        clr.w        d0                                            ; $02A0D8
        bsr.w        ReadPasswordBit                               ; $02A0DA
        bsr.w        ReadPasswordBit                               ; $02A0DE
        bsr.w        ReadPasswordBit                               ; $02A0E2
        bsr.w        ReadPasswordBit                               ; $02A0E6
        bsr.w        ReadPasswordBit                               ; $02A0EA
        bsr.w        ReadPasswordBit                               ; $02A0EE
        bsr.w        ReadPasswordBit                               ; $02A0F2
        bsr.w        ReadPasswordBit                               ; $02A0F6
        rol.w        #$7, d0                                       ; $02A0FA
        add.w        d0, d3                                        ; $02A0FC
        clr.w        d0                                            ; $02A0FE
        bsr.w        ReadPasswordBit                               ; $02A100
        bsr.w        ReadPasswordBit                               ; $02A104
        bsr.w        ReadPasswordBit                               ; $02A108
        bsr.w        ReadPasswordBit                               ; $02A10C
        bsr.w        ReadPasswordBit                               ; $02A110
        bsr.w        ReadPasswordBit                               ; $02A114
        bsr.w        ReadPasswordBit                               ; $02A118
        bsr.w        ReadPasswordBit                               ; $02A11C
        rol.w        #$7, d0                                       ; $02A120
        add.w        d0, d3                                        ; $02A122
        clr.w        d0                                            ; $02A124
        bsr.w        ReadPasswordBit                               ; $02A126
        bsr.w        ReadPasswordBit                               ; $02A12A
        bsr.w        ReadPasswordBit                               ; $02A12E
        bsr.w        ReadPasswordBit                               ; $02A132
        bsr.w        ReadPasswordBit                               ; $02A136
        bsr.w        ReadPasswordBit                               ; $02A13A
        bsr.w        ReadPasswordBit                               ; $02A13E
        bsr.w        ReadPasswordBit                               ; $02A142
        rol.w        #$7, d0                                       ; $02A146
        add.w        d0, d3                                        ; $02A148
        clr.w        d0                                            ; $02A14A
        bsr.w        ReadPasswordBit                               ; $02A14C
        bsr.w        ReadPasswordBit                               ; $02A150
        bsr.w        ReadPasswordBit                               ; $02A154
        bsr.w        ReadPasswordBit                               ; $02A158
        bsr.w        ReadPasswordBit                               ; $02A15C
        bsr.w        ReadPasswordBit                               ; $02A160
        bsr.w        ReadPasswordBit                               ; $02A164
        bsr.w        ReadPasswordBit                               ; $02A168
        rol.w        #$7, d0                                       ; $02A16C
        add.w        d0, d3                                        ; $02A16E
        clr.w        d0                                            ; $02A170
        bsr.w        ReadPasswordBit                               ; $02A172
        bsr.w        ReadPasswordBit                               ; $02A176
        bsr.w        ReadPasswordBit                               ; $02A17A
        bsr.w        ReadPasswordBit                               ; $02A17E
        bsr.w        ReadPasswordBit                               ; $02A182
        bsr.w        ReadPasswordBit                               ; $02A186
        bsr.w        ReadPasswordBit                               ; $02A18A
        bsr.w        ReadPasswordBit                               ; $02A18E
        rol.w        #$7, d0                                       ; $02A192
        add.w        d0, d3                                        ; $02A194
        clr.w        d0                                            ; $02A196
        bsr.w        ReadPasswordBit                               ; $02A198
        bsr.w        ReadPasswordBit                               ; $02A19C
        bsr.w        ReadPasswordBit                               ; $02A1A0
        bsr.w        ReadPasswordBit                               ; $02A1A4
        bsr.w        ReadPasswordBit                               ; $02A1A8
        bsr.w        ReadPasswordBit                               ; $02A1AC
        rol.w        #$5, d0                                       ; $02A1B0
        add.w        d0, d3                                        ; $02A1B2
        clr.w        d0                                            ; $02A1B4
        bsr.w        ReadPasswordBit                               ; $02A1B6
        bsr.w        ReadPasswordBit                               ; $02A1BA
        bsr.w        ReadPasswordBit                               ; $02A1BE
        bsr.w        ReadPasswordBit                               ; $02A1C2
        bsr.w        ReadPasswordBit                               ; $02A1C6
        bsr.w        ReadPasswordBit                               ; $02A1CA
        bsr.w        ReadPasswordBit                               ; $02A1CE
        bsr.w        ReadPasswordBit                               ; $02A1D2
        rol.w        #$7, d0                                       ; $02A1D6
        cmp.b        d0, d3                                        ; $02A1D8
        beq.b        loc_02A1E2                                    ; $02A1DA

loc_02A1DC:
        move.w       #$ffff, d7                                    ; $02A1DC
        rts                                                        ; $02A1E0

loc_02A1E2:
        lea.l        -$53b8(a6), a2                                ; $02A1E2
        clr.w        d2                                            ; $02A1E6
        clr.w        d0                                            ; $02A1E8
        bsr.w        ReadPasswordBit                               ; $02A1EA
        move.b       d0, rCharacterAvailable0(a6)                  ; $02A1EE
        clr.w        d0                                            ; $02A1F2
        bsr.w        ReadPasswordBit                               ; $02A1F4
        move.b       d0, rCharacterAvailable1(a6)                  ; $02A1F8
        clr.w        d0                                            ; $02A1FC
        bsr.w        ReadPasswordBit                               ; $02A1FE
        move.b       d0, rCharacterAvailable2(a6)                  ; $02A202
        clr.w        d0                                            ; $02A206
        bsr.w        ReadPasswordBit                               ; $02A208
        move.b       d0, rCharacterAvailable3(a6)                  ; $02A20C
        clr.w        d0                                            ; $02A210
        bsr.w        ReadPasswordBit                               ; $02A212
        move.b       d0, rCharacterAvailable4(a6)                  ; $02A216
        clr.w        d0                                            ; $02A21A
        bsr.w        ReadPasswordBit                               ; $02A21C
        bsr.w        ReadPasswordBit                               ; $02A220
        bsr.w        ReadPasswordBit                               ; $02A224
        bsr.w        ReadPasswordBit                               ; $02A228
        bsr.w        ReadPasswordBit                               ; $02A22C
        bsr.w        ReadPasswordBit                               ; $02A230
        bsr.w        ReadPasswordBit                               ; $02A234
        bsr.w        ReadPasswordBit                               ; $02A238
        bsr.w        ReadPasswordBit                               ; $02A23C
        bsr.w        ReadPasswordBit                               ; $02A240
        bsr.w        ReadPasswordBit                               ; $02A244
        bsr.w        ReadPasswordBit                               ; $02A248
        bsr.w        ReadPasswordBit                               ; $02A24C
        bsr.w        ReadPasswordBit                               ; $02A250
        rol.w        #$8, d0                                       ; $02A254
        rol.w        #$5, d0                                       ; $02A256
        lea.l        rSavedInventoryItem0(a6), a3                  ; $02A258
        move.w       #$1, d1                                       ; $02A25C
        move.w       #$d, d6                                       ; $02A260

loc_02A264:
        btst.l       #$0, d0                                       ; $02A264
        beq.b        loc_02A276                                    ; $02A268
        cmpa.l       #$ff2c40, a3                                  ; $02A26A
        beq.w        loc_02A1DC                                    ; $02A270
        move.b       d1, (a3)+                                     ; $02A274

loc_02A276:
        ror.w        #$1, d0                                       ; $02A276
        addq.w       #$1, d1                                       ; $02A278
        dbra         d6, loc_02A264                                ; $02A27A

loc_02A27E:
        cmpa.l       #$ff2c40, a3                                  ; $02A27E
        beq.b        loc_02A28A                                    ; $02A284
        clr.b        (a3)+                                         ; $02A286
        bra.b        loc_02A27E                                    ; $02A288

loc_02A28A:
        clr.w        d0                                            ; $02A28A
        bsr.w        ReadPasswordBit                               ; $02A28C
        bsr.w        ReadPasswordBit                               ; $02A290
        bsr.w        ReadPasswordBit                               ; $02A294
        rol.w        #$2, d0                                       ; $02A298
        move.b       d0, rSavedInventoryAmount0(a6)                ; $02A29A
        clr.w        d0                                            ; $02A29E
        bsr.w        ReadPasswordBit                               ; $02A2A0
        bsr.w        ReadPasswordBit                               ; $02A2A4
        bsr.w        ReadPasswordBit                               ; $02A2A8
        rol.w        #$2, d0                                       ; $02A2AC
        move.b       d0, rSavedInventoryAmount1(a6)                ; $02A2AE
        clr.w        d0                                            ; $02A2B2
        bsr.w        ReadPasswordBit                               ; $02A2B4
        bsr.w        ReadPasswordBit                               ; $02A2B8
        bsr.w        ReadPasswordBit                               ; $02A2BC
        rol.w        #$2, d0                                       ; $02A2C0
        move.b       d0, rSavedInventoryAmount2(a6)                ; $02A2C2
        clr.w        d0                                            ; $02A2C6
        bsr.w        ReadPasswordBit                               ; $02A2C8
        bsr.w        ReadPasswordBit                               ; $02A2CC
        bsr.w        ReadPasswordBit                               ; $02A2D0
        rol.w        #$2, d0                                       ; $02A2D4
        move.b       d0, rSavedInventoryAmount3(a6)                ; $02A2D6
        clr.w        d0                                            ; $02A2DA
        bsr.w        ReadPasswordBit                               ; $02A2DC
        bsr.w        ReadPasswordBit                               ; $02A2E0
        bsr.w        ReadPasswordBit                               ; $02A2E4
        rol.w        #$2, d0                                       ; $02A2E8
        move.b       d0, rSavedInventoryAmount4(a6)                ; $02A2EA
        clr.w        d0                                            ; $02A2EE
        bsr.w        ReadPasswordBit                               ; $02A2F0
        bsr.w        ReadPasswordBit                               ; $02A2F4
        bsr.w        ReadPasswordBit                               ; $02A2F8
        bsr.w        ReadPasswordBit                               ; $02A2FC
        bsr.w        ReadPasswordBit                               ; $02A300
        bsr.w        ReadPasswordBit                               ; $02A304
        rol.w        #$5, d0                                       ; $02A308
        move.b       d0, rSavedHealth(a6)                          ; $02A30A
        clr.w        d0                                            ; $02A30E
        bsr.w        ReadPasswordBit                               ; $02A310
        bsr.w        ReadPasswordBit                               ; $02A314
        bsr.w        ReadPasswordBit                               ; $02A318
        bsr.w        ReadPasswordBit                               ; $02A31C
        bsr.w        ReadPasswordBit                               ; $02A320
        bsr.w        ReadPasswordBit                               ; $02A324
        rol.w        #$5, d0                                       ; $02A328
; Normal password decode forces LevelSelection=0, masks decoded progress with $F into GeometryEpisode, later increments LevelSelection to 1. Retained cheats bypass these writes.
        move.b       #$0, rLevelSelection(a6)                      ; $02A32A
        andi.w       #$f, d0                                       ; $02A330
        move.w       d0, rGeometryEpisode(a6)                      ; $02A334
        clr.w        d0                                            ; $02A338
        move.b       rSavedInventoryItem0(a6), d0                  ; $02A33A
        movea.l      #ItemCapacityLimits, a0                       ; $02A33E
        adda.w       d0, a0                                        ; $02A344
        adda.w       d0, a0                                        ; $02A346
        move.b       rSavedInventoryAmount0(a6), d0                ; $02A348
        add.w        d0, d0                                        ; $02A34C
        addq.w       #$1, d0                                       ; $02A34E
        mulu.w       (a0), d0                                      ; $02A350
        asr.l        #$4, d0                                       ; $02A352
        asr.w        #$8, d0                                       ; $02A354
        move.b       d0, rSavedInventoryAmount0(a6)                ; $02A356
        clr.w        d0                                            ; $02A35A
        move.b       rSavedInventoryItem1(a6), d0                  ; $02A35C
        movea.l      #ItemCapacityLimits, a0                       ; $02A360
        adda.w       d0, a0                                        ; $02A366
        adda.w       d0, a0                                        ; $02A368
        move.b       rSavedInventoryAmount1(a6), d0                ; $02A36A
        add.w        d0, d0                                        ; $02A36E
        addq.w       #$1, d0                                       ; $02A370
        mulu.w       (a0), d0                                      ; $02A372
        asr.l        #$4, d0                                       ; $02A374
        asr.w        #$8, d0                                       ; $02A376
        move.b       d0, rSavedInventoryAmount1(a6)                ; $02A378
        clr.w        d0                                            ; $02A37C
        move.b       rSavedInventoryItem2(a6), d0                  ; $02A37E
        movea.l      #ItemCapacityLimits, a0                       ; $02A382
        adda.w       d0, a0                                        ; $02A388
        adda.w       d0, a0                                        ; $02A38A
        move.b       rSavedInventoryAmount2(a6), d0                ; $02A38C
        add.w        d0, d0                                        ; $02A390
        addq.w       #$1, d0                                       ; $02A392
        mulu.w       (a0), d0                                      ; $02A394
        asr.l        #$4, d0                                       ; $02A396
        asr.w        #$8, d0                                       ; $02A398
        move.b       d0, rSavedInventoryAmount2(a6)                ; $02A39A
        clr.w        d0                                            ; $02A39E
        move.b       rSavedInventoryItem3(a6), d0                  ; $02A3A0
        movea.l      #ItemCapacityLimits, a0                       ; $02A3A4
        adda.w       d0, a0                                        ; $02A3AA
        adda.w       d0, a0                                        ; $02A3AC
        move.b       rSavedInventoryAmount3(a6), d0                ; $02A3AE
        add.w        d0, d0                                        ; $02A3B2
        addq.w       #$1, d0                                       ; $02A3B4
        mulu.w       (a0), d0                                      ; $02A3B6
        asr.l        #$4, d0                                       ; $02A3B8
        asr.w        #$8, d0                                       ; $02A3BA
        move.b       d0, rSavedInventoryAmount3(a6)                ; $02A3BC
        clr.w        d0                                            ; $02A3C0
        move.b       rSavedInventoryItem4(a6), d0                  ; $02A3C2
        movea.l      #ItemCapacityLimits, a0                       ; $02A3C6
        adda.w       d0, a0                                        ; $02A3CC
        adda.w       d0, a0                                        ; $02A3CE
        move.b       rSavedInventoryAmount4(a6), d0                ; $02A3D0
        add.w        d0, d0                                        ; $02A3D4
        addq.w       #$1, d0                                       ; $02A3D6
        mulu.w       (a0), d0                                      ; $02A3D8
        asr.l        #$4, d0                                       ; $02A3DA
        asr.w        #$8, d0                                       ; $02A3DC
        move.b       d0, rSavedInventoryAmount4(a6)                ; $02A3DE
        clr.w        d0                                            ; $02A3E2
        move.b       rSavedHealth(a6), d0                          ; $02A3E4
        add.w        d0, d0                                        ; $02A3E8
        addq.w       #$1, d0                                       ; $02A3EA
        mulu.w       #$64, d0                                      ; $02A3EC
        lsr.l        #$7, d0                                       ; $02A3F0
        move.b       d0, rSavedHealth(a6)                          ; $02A3F2
        addq.b       #$1, rLevelSelection(a6)                      ; $02A3F6
        clr.w        d0                                            ; $02A3FA
        move.b       rLevelSelection(a6), d0                       ; $02A3FC
        andi.w       #$3f, d0                                      ; $02A400
        move.b       PasswordDecoderTable(pc, d0.w), d0            ; $02A404
        beq.w        loc_02A1DC                                    ; $02A408
        clr.w        d7                                            ; $02A40C
        rts                                                        ; $02A40E
        ifne *-$2A410
        fail "ROM end moved"
        endif
