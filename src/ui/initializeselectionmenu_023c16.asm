; $023C16..$023CDB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация экрана меню: сброс VDP-подсистемы (jsr $21dc2/$21dde/$21d2a), загрузка тайлов фона DMA из $8367c и $14d038 (0x4b0) и $245d4 в VRAM ($98b98), настройка плейна/спрайтов ($21efa), копирование 2 таблиц объектов в $FF0778/$FF07d8 ($22000), загрузка палитры из $836dc, обнуление $FF2A4E/$FF1056
        ifne *-$23C16
        fail "ROM start moved"
        endif

InitializeSelectionMenu:
        jsr          ClearCram(pc)                                 ; $023C16
        jsr          ClearAllVram(pc)                              ; $023C1A
        jsr          InitializeMenuVdp(pc)                         ; $023C1E
        move.w       #$0, d0                                       ; $023C22
        jsr          WriteVerticalScrollToVsram(pc)                       ; $023C26
        move.w       #$0, d0                                       ; $023C2A
        jsr          WriteScreenTile(pc)                           ; $023C2E
        move.l       #$55c00002, VDP_CONTROL.l                     ; $023C32
        lea.l        OptionsCursorSpriteTiles.l, a0               ; $023C3C
        move.w       #$f, d7                                       ; $023C42

loc_023C46:
        move.l       (a0)+, VDP_DATA.l                             ; $023C46
        dbra         d7, loc_023C46                                ; $023C4C
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $023C50
        move.w       #$4b0, d0                                     ; $023C56
        jsr          DecompressBytePairToVramLong.l                ; $023C5A
        lea.l        JulyTitleCompressedTiles.l, a3                ; $023C60
        move.w       #$1, d0                                       ; $023C66
        jsr          DecompressBytePairToVramLong.l                ; $023C6A
        lea.l        JulyTitleTilemap.l, a0                        ; $023C70
        movea.w      #$0, a1                                       ; $023C76
        move.w       #$28, d0                                      ; $023C7A
        move.w       #$1c, d1                                      ; $023C7E
        move.w       #$40, d2                                      ; $023C82
        move.w       #$1, d3                                       ; $023C86
        jsr          UploadAttributedTilemapAtE000Offset(pc)                                ; $023C8A
        lea.l        JulyTitlePalette.l, a0                        ; $023C8E
        lea.l        $ff0778.l, a1                                 ; $023C94
        jsr          CopyOneTile(pc)                               ; $023C9A
        lea.l        BriefingTextPalette.l, a0                     ; $023C9E
        lea.l        $ff07d8.l, a1                                 ; $023CA4
        jsr          CopyOneTile(pc)                               ; $023CAA
        lea.l        $ff0778.l, a0                                 ; $023CAE
        move.w       #$4, d1                                       ; $023CB4
        jsr          FadeAll64PaletteColorsFromBlack(pc)                                ; $023CB8
        move.w       #$1, d0                                       ; $023CBC
        lea.l        OptionsPalettes.l, a0                         ; $023CC0
        jsr          LoadPaletteLine(pc)                           ; $023CC6
        move.w       #$0, $ff2a4e.l                                ; $023CCA
        move.w       #$0, $ff1056.l                                ; $023CD2
        rts                                                        ; $023CDA
        ifne *-$23CDC
        fail "ROM end moved"
        endif
