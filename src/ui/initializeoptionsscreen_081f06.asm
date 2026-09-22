; $081F06..$081FE1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация экрана опций: сброс VDP (0x21dc2/0x21dde/0x21d2a), загрузка палитр (0x836dc/0x227d2) и тайлов фона (0x8367c, 0x14d038 через byte-pair 0x98b98), установка селектора $FF2A4C=5, отрисовка заголовков-меток (0x82210..0x82266 через 0x7b552), сброс $FF2A4E/$FF1056 и вывод значений 0x82008
        ifne *-$81F06
        fail "ROM start moved"
        endif

InitializeOptionsScreen:
        jsr          ClearCram.l                                   ; $081F06
        jsr          ClearAllVram.l                                ; $081F0C
        jsr          InitializeMenuVdp.l                           ; $081F12
        move.w       #$0, d0                                       ; $081F18
        lea.l        OptionsPalettes.l, a0                         ; $081F1C
        jsr          LoadPaletteLine.l                             ; $081F22
        lea.l        InterfacePalettes.l, a0                       ; $081F28
        move.w       #$3, d0                                       ; $081F2E
        jsr          LoadPaletteLine.l                             ; $081F32
        move.l       #$55c00002, VDP_CONTROL.l                     ; $081F38
        lea.l        OptionsWindowTilePatterns.l, a0               ; $081F42
        move.w       #$f, d7                                       ; $081F48

loc_081F4C:
        move.l       (a0)+, VDP_DATA.l                             ; $081F4C
        dbra         d7, loc_081F4C                                ; $081F52
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $081F56
        move.w       #$4b0, d0                                     ; $081F5C
        jsr          DecompressBytePairToVramLong.l                ; $081F60
        move.w       #$5, d3                                       ; $081F66
        move.w       d3, $ff2a4c.l                                 ; $081F6A
        jsr          DrawOptionsCursor.l                           ; $081F70
        move.w       #$c314, d0                                    ; $081F76
        lea.l        OptionsStrings.l, a0                          ; $081F7A
        jsr          PrintCharacterMenuText(pc)                    ; $081F80
        move.w       #$c414, d0                                    ; $081F84
        lea.l        Data_08221A.l, a0                             ; $081F88
        jsr          PrintCharacterMenuText(pc)                    ; $081F8E
        move.w       #$c514, d0                                    ; $081F92
        lea.l        Data_082223.l, a0                             ; $081F96
        jsr          PrintCharacterMenuText(pc)                    ; $081F9C
        move.w       #$c614, d0                                    ; $081FA0
        lea.l        Data_08222A.l, a0                             ; $081FA4
        jsr          PrintCharacterMenuText(pc)                    ; $081FAA
        move.w       #$c714, d0                                    ; $081FAE
        lea.l        Data_082231.l, a0                             ; $081FB2
        jsr          PrintCharacterMenuText(pc)                    ; $081FB8
        move.w       #$c914, d0                                    ; $081FBC
        lea.l        Data_082266.l, a0                             ; $081FC0
        jsr          PrintCharacterMenuText(pc)                    ; $081FC6
        move.w       #$0, $ff2a4e.l                                ; $081FCA
        move.w       #$0, $ff1056.l                                ; $081FD2
        jsr          DrawOptionValues.l                            ; $081FDA
        rts                                                        ; $081FE0
        ifne *-$81FE2
        fail "ROM end moved"
        endif
