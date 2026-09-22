; $0021A2..$002265 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Отрисовка пары тайлов спрайта: байт $1(a0)→смещение a1, слово $2(a0)+( a0) and #$3f индекс в PC-таблицу $2266, добавки к a1/d3/d4; сборка 2 VDP-команд записи (d4,d3 через swap/lsr/ori #$4000) и move.l (a1),$C00000 — вывод тайла в две точки VRAM
        ifne *-$21A2
        fail "ROM start moved"
        endif

ComposeTileSpritePair:
        subq.b       #$1, -$7222(a6)                               ; $0021A2
        bmi.b        loc_0021D2                                    ; $0021A6
        beq.b        loc_0021BE                                    ; $0021A8
        movea.l      #$15d158, a1                                  ; $0021AA
        move.w       #$2960, d4                                    ; $0021B0
        move.w       #$2980, d3                                    ; $0021B4
        lea.l        -$7218(a6), a0                                ; $0021B8
        bra.b        loc_0021EA                                    ; $0021BC

loc_0021BE:
        movea.l      #$15d258, a1                                  ; $0021BE
        move.w       #$2e40, d4                                    ; $0021C4
        move.w       #$2e60, d3                                    ; $0021C8
        lea.l        -$721c(a6), a0                                ; $0021CC
        bra.b        loc_0021EA                                    ; $0021D0

loc_0021D2:
        movea.l      #$15d358, a1                                  ; $0021D2
        move.w       #$3040, d4                                    ; $0021D8
        move.w       #$3d00, d3                                    ; $0021DC
        lea.l        -$7220(a6), a0                                ; $0021E0
        move.b       #$2, -$7222(a6)                               ; $0021E4

loc_0021EA:
        subq.b       #$1, (a0)                                     ; $0021EA
        bpl.b        loc_002206                                    ; $0021EC
        addq.b       #$8, (a0)                                     ; $0021EE
        addi.b       #$40, $1(a0)                                  ; $0021F0
        jsr          NextRandom.l                                  ; $0021F6
        swap         d2                                            ; $0021FC
        andi.w       #$38, d2                                      ; $0021FE
        move.w       d2, $2(a0)                                    ; $002202

loc_002206:
        clr.w        d0                                            ; $002206
        move.b       $1(a0), d0                                    ; $002208
        adda.w       d0, a1                                        ; $00220C
        move.w       $2(a0), d2                                    ; $00220E
        add.b        (a0), d2                                      ; $002212
        andi.w       #$3f, d2                                      ; $002214
        move.b       PanoramaAnimationOffsets(pc, d2.w), d0        ; $002218
        adda.w       d0, a1                                        ; $00221C
        add.w        d0, d3                                        ; $00221E
        add.w        d0, d4                                        ; $002220
        move.w       d4, d0                                        ; $002222
        move.w       d0, d1                                        ; $002224
        andi.w       #$3fff, d1                                    ; $002226
        ori.w        #$4000, d1                                    ; $00222A
        swap         d1                                            ; $00222E
        lsr.w        #$8, d0                                       ; $002230
        lsr.w        #$6, d0                                       ; $002232
        move.w       d0, d1                                        ; $002234
        move.l       d1, VDP_CONTROL.l                             ; $002236
        move.l       (a1), VDP_DATA.l                              ; $00223C
        move.w       d3, d0                                        ; $002242
        move.w       d0, d1                                        ; $002244
        andi.w       #$3fff, d1                                    ; $002246
        ori.w        #$4000, d1                                    ; $00224A
        swap         d1                                            ; $00224E
        lsr.w        #$8, d0                                       ; $002250
        lsr.w        #$6, d0                                       ; $002252
        move.w       d0, d1                                        ; $002254
        move.l       d1, VDP_CONTROL.l                             ; $002256
        move.l       $20(a1), VDP_DATA.l                           ; $00225C
        rts                                                        ; $002264
        ifne *-$2266
        fail "ROM end moved"
        endif
