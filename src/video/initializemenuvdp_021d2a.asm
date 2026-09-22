; $021D2A..$021D87 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация регистров VDP: серия move.w командных слов 0x80xx-0x92xx в порт управления $C00004 (A0), с region-проверкой ($FF2C66) для регистра режима, затем jsr FUN_021d88
        ifne *-$21D2A
        fail "ROM start moved"
        endif

InitializeMenuVdp:
        movea.l      #VDP_CONTROL, a0                              ; $021D2A
        move.w       #$8004, (a0)                                  ; $021D30
        move.w       #$8164, (a0)                                  ; $021D34
        move.w       #$8230, (a0)                                  ; $021D38
        move.w       #$8330, (a0)                                  ; $021D3C
        move.w       #$8407, (a0)                                  ; $021D40
        move.w       #$855c, (a0)                                  ; $021D44
        move.w       #$8700, (a0)                                  ; $021D48
        move.w       #$8a00, (a0)                                  ; $021D4C
        cmpi.w       #$2100, $ff2c66.l                             ; $021D50
        bne.w        loc_021D64                                    ; $021D58
        move.w       #$8b08, (a0)                                  ; $021D5C
        bra.w        loc_021D68                                    ; $021D60

loc_021D64:
        move.w       #$8b00, (a0)                                  ; $021D64

loc_021D68:
        move.w       #$8c81, (a0)                                  ; $021D68
        move.w       #$8d2f, (a0)                                  ; $021D6C
        move.w       #$8f02, (a0)                                  ; $021D70
        move.w       #$9011, (a0)                                  ; $021D74
        move.w       #$9100, (a0)                                  ; $021D78
        move.w       #$9200, (a0)                                  ; $021D7C
        jsr          SetMenuVramWriteAddress.l                     ; $021D80
        rts                                                        ; $021D86
        ifne *-$21D88
        fail "ROM end moved"
        endif
