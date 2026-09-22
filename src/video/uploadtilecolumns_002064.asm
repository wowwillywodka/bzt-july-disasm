; $002064..$0020BB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 2032] Запись столбца тайлов в VDP: из $4(a0) берёт счётчик, формирует адрес-команду VRAM (andi $3fff/ori $4000/swap/lsr) в порт $C00004
        ifne *-$2064
        fail "ROM start moved"
        endif

UploadTileColumns:
        move.w       $4(a0), d6                                    ; $002064
        subq.w       #$1, d6                                       ; $002068
        movem.w      d0-d1, -(a7)                                  ; $00206A
        move.w       d1, d0                                        ; $00206E
        move.w       d0, d1                                        ; $002070
        andi.w       #$3fff, d1                                    ; $002072
        ori.w        #$4000, d1                                    ; $002076
        swap         d1                                            ; $00207A
        lsr.w        #$8, d0                                       ; $00207C
        lsr.w        #$6, d0                                       ; $00207E
        move.w       d0, d1                                        ; $002080
        move.l       d1, VDP_CONTROL.l                             ; $002082
        movem.w      (a7)+, d0-d1                                  ; $002088
        addi.w       #$80, d1                                      ; $00208C

loc_002090:
        move.w       (a1)+, d5                                     ; $002090
        add.w        d4, d5                                        ; $002092
        move.w       d5, VDP_DATA.l                                ; $002094
        dbra         d6, loc_002090                                ; $00209A
        dbra         d7, UploadTileColumns                         ; $00209E
        move.w       d0, -(a7)                                     ; $0020A2
        move.w       d0, d1                                        ; $0020A4
        andi.w       #$3fff, d1                                    ; $0020A6
        ori.w        #$4000, d1                                    ; $0020AA
        swap         d1                                            ; $0020AE
        lsr.w        #$8, d0                                       ; $0020B0
        lsr.w        #$6, d0                                       ; $0020B2
        move.w       d0, d1                                        ; $0020B4
        move.l       d1, VDP_CONTROL.l                             ; $0020B6
        ifne *-$20BC
        fail "ROM end moved"
        endif
