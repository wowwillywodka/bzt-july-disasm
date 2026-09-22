; $021F10..$021F4D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Очистка области тайлов в VRAM: считает адрес VRAM (FUN_21eb0, +0xC000), формирует команду записи в $C00004, затем заливает 0x1000 слов нулём через FUN_21f02
        ifne *-$21F10
        fail "ROM start moved"
        endif

ClearMenuTileRectangle:
        move.l       d0, -(a7)                                     ; $021F10
        move.w       #$0, d0                                       ; $021F12
        move.w       #$0, d1                                       ; $021F16
        move.w       #$40, d2                                      ; $021F1A
        jsr          CalculateTilemapAddress(pc)                   ; $021F1E
        adda.l       #$c000, a1                                    ; $021F22
        move.l       a1, d4                                        ; $021F28
        lsl.l        #$2, d4                                       ; $021F2A
        lsr.w        #$2, d4                                       ; $021F2C
        swap         d4                                            ; $021F2E
        bset.l       #$1e, d4                                      ; $021F30
        andi.l       #$7fff0003, d4                                ; $021F34
        move.l       d4, VDP_CONTROL.l                             ; $021F3A
        move.l       (a7)+, d0                                     ; $021F40
        move.l       #$1000, d1                                    ; $021F42
        jsr          FillVdpWords(pc)                              ; $021F48
        rts                                                        ; $021F4C
        ifne *-$21F4E
        fail "ROM end moved"
        endif
