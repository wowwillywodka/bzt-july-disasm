; $021D88..$021DAF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Предвычисление VDP-команды записи в VRAM по адресу 0xb800: разбивает адрес ((addr&0x3fff)<<16)|((addr>>14)) + флаг 0x40000000, сохраняет в (-0x790c,A6) для последующих DMA-записей
        ifne *-$21D88
        fail "ROM start moved"
        endif

SetMenuVramWriteAddress:
        move.l       #$40000000, d0                                ; $021D88
        move.l       #$b800, d1                                    ; $021D8E
        move.l       d1, d2                                        ; $021D94
        andi.w       #$3fff, d1                                    ; $021D96
        andi.w       #$cc00, d2                                    ; $021D9A
        swap         d1                                            ; $021D9E
        clr.w        d1                                            ; $021DA0
        moveq        #$e, d3                                       ; $021DA2
        asr.l        d3, d2                                        ; $021DA4
        add.l        d1, d0                                        ; $021DA6
        add.l        d2, d0                                        ; $021DA8
        move.l       d0, rMenuVramWriteAddressOffset(a6)                                ; $021DAA
        rts                                                        ; $021DAE
        ifne *-$21DB0
        fail "ROM end moved"
        endif
