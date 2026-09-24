; $07B4FE..$07B551 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Подготовка адреса VRAM для DMA-вывода фона/тайлмапа: по значению $FF2A4C задаёт смещение (D1=0/0x20), вычисляет адрес через 0x21eb0, +0xC000, формирует VDP-команду записи в $C00004 и заливает 0x800 слов через 0x21f02
        ifne *-$7B4FE
        fail "ROM start moved"
        endif

ClearCharacterMenuTilemapRegion:
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B4FE
        beq.w        loc_07B512                                    ; $07B506
        move.w       #$0, d1                                       ; $07B50A
        bra.w        loc_07B51E                                    ; $07B50E

loc_07B512:
        move.w       #$20, d1                                      ; $07B512
        move.w       #$0, d0                                       ; $07B516
        move.w       #$40, d2                                      ; $07B51A

loc_07B51E:
        jsr          CalculateTilemapAddress.l                     ; $07B51E
        adda.l       #$c000, a1                                    ; $07B524
        move.l       a1, d4                                        ; $07B52A
        lsl.l        #$2, d4                                       ; $07B52C
        lsr.w        #$2, d4                                       ; $07B52E
        swap         d4                                            ; $07B530
        bset.l       #$1e, d4                                      ; $07B532
        andi.l       #$7fff0003, d4                                ; $07B536
        move.l       d4, VDP_CONTROL.l                             ; $07B53C
        moveq        #$0, d0                                       ; $07B542
        move.l       #$800, d1                                     ; $07B544
        jsr          FillVdpWords.l                                ; $07B54A
        rts                                                        ; $07B550
        ifne *-$7B552
        fail "ROM end moved"
        endif
