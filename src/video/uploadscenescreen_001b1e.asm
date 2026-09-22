; $001B1E..$001B93 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка экрана в VRAM: ставит автоинкремент VDP ($40000000→$C00004), обнуляет 8 лонгов через A4=$C00000, льёт таблицу тайлов из $14D038 (0x4B0 лонгов) в порт данных $C00000, bsr $CC0/$C70
        ifne *-$1B1E
        fail "ROM start moved"
        endif

UploadSceneScreen:
        move.l       #$40000000, VDP_CONTROL.l                     ; $001B1E
        moveq        #$0, d6                                       ; $001B28
        movea.l      #VDP_DATA, a4                                 ; $001B2A
        move.l       d6, (a4)                                      ; $001B30
        move.l       d6, (a4)                                      ; $001B32
        move.l       d6, (a4)                                      ; $001B34
        move.l       d6, (a4)                                      ; $001B36
        move.l       d6, (a4)                                      ; $001B38
        move.l       d6, (a4)                                      ; $001B3A
        move.l       d6, (a4)                                      ; $001B3C
        move.l       d6, (a4)                                      ; $001B3E
        lea.l        CommonInterfaceCompressedTiles.l, a0          ; $001B40
        move.w       #$4af, d7                                     ; $001B46

loc_001B4A:
        move.l       (a0)+, VDP_DATA.l                             ; $001B4A
        dbra         d7, loc_001B4A                                ; $001B50
        bsr.w        ClearVramLongs                                ; $001B54
        bsr.w        ClearVideoMemory                              ; $001B58
        lea.l        WaitingForPartnerSceneText(pc), a0            ; $001B5C
        move.w       #$e680, d0                                    ; $001B60
        jsr          PrintHudString.l                              ; $001B64
        move.l       #$c0000000, VDP_CONTROL.l                     ; $001B6A
        movea.l      #InterfacePalettes, a0                        ; $001B74
        movea.l      #VDP_DATA, a4                                 ; $001B7A
        move.l       (a0)+, (a4)                                   ; $001B80
        move.l       (a0)+, (a4)                                   ; $001B82
        move.l       (a0)+, (a4)                                   ; $001B84
        move.l       (a0)+, (a4)                                   ; $001B86
        move.l       (a0)+, (a4)                                   ; $001B88
        move.l       (a0)+, (a4)                                   ; $001B8A
        move.l       (a0)+, (a4)                                   ; $001B8C
        move.l       (a0)+, (a4)                                   ; $001B8E
        bra.w        InitializeVdpRegisters                        ; $001B90
        ifne *-$1B94
        fail "ROM end moved"
        endif
