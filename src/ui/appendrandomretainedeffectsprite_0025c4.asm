; $0025C4..$002605 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Подготовка координат/атрибута HUD-элемента: по dist в D1 выбирает базовый VDP-атрибут D3 ($c00c/+$1002/+2), задаёт D0=$400, смещает D1+=$b0, D2+=$e0 и rts — настройка позиции тайла перед сборкой буфера в $26d0
        ifne *-$25C4
        fail "ROM start moved"
        endif

AppendRandomRetainedEffectSprite:
        jsr          NextRandom.l                                  ; $0025C4
        move.l       d2, d1                                        ; $0025CA
        swap         d1                                            ; $0025CC
        lsr.l        #$8, d2                                       ; $0025CE
        andi.w       #$7f, d2                                      ; $0025D0
        andi.w       #$3f, d1                                      ; $0025D4
        move.w       rPlayerFacingAngle(a6), d0                                ; $0025D8
        andi.w       #$1ff, d0                                     ; $0025DC
        cmpi.w       #$40, d0                                      ; $0025E0
        bcs.b        loc_0025FC                                    ; $0025E4
        cmpi.w       #$c0, d0                                      ; $0025E6
        bcs.w        loc_002632                                    ; $0025EA
        cmpi.w       #$140, d0                                     ; $0025EE
        bcs.b        loc_00262C                                    ; $0025F2
        cmpi.w       #$1c0, d0                                     ; $0025F4
        bcs.w        loc_002656                                    ; $0025F8

loc_0025FC:
        bsr.b        PrepareRetainedEffectSpriteAttributes                          ; $0025FC
        ori.w        #$800, d3                                     ; $0025FE
        bra.w        AppendHardwareSprite                          ; $002602
        ifne *-$2606
        fail "ROM end moved"
        endif
