; $0020BC..$002103 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Блит тайлов в VRAM: move.w (a7)+,d0 (адрес из стека), (a0)→d6 lsl#5 (×32) добавка к адресу, разворот цикла из 8× move.l (a0)+,$C00000 (порт данных VDP) с dbra d6 — выгрузка паттернов в видеопамять
        ifne *-$20BC
        fail "ROM start moved"
        endif

UploadColumnTilePatterns:
        move.w       (a7)+, d0                                     ; $0020BC
        move.w       (a0), d6                                      ; $0020BE
        lsl.w        #$5, d6                                       ; $0020C0
        add.w        d6, d0                                        ; $0020C2
        move.w       (a0), d6                                      ; $0020C4
        adda.w       $2(a0), a0                                    ; $0020C6
        subq.w       #$1, d6                                       ; $0020CA
        bmi.b        loc_002102                                    ; $0020CC

loc_0020CE:
        move.l       (a0)+, VDP_DATA.l                             ; $0020CE
        move.l       (a0)+, VDP_DATA.l                             ; $0020D4
        move.l       (a0)+, VDP_DATA.l                             ; $0020DA
        move.l       (a0)+, VDP_DATA.l                             ; $0020E0
        move.l       (a0)+, VDP_DATA.l                             ; $0020E6
        move.l       (a0)+, VDP_DATA.l                             ; $0020EC
        move.l       (a0)+, VDP_DATA.l                             ; $0020F2
        move.l       (a0)+, VDP_DATA.l                             ; $0020F8
        dbra         d6, loc_0020CE                                ; $0020FE

loc_002102:
        rts                                                        ; $002102
        ifne *-$2104
        fail "ROM end moved"
        endif
