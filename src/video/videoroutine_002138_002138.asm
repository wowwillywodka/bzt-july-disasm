; $002138..$002153 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Запись тайлмапа в VDP: movem.w (a7)+,d0-d1 (восстановление), цикл move.w (a1)+,d5; add.w d4,d5 (базовый аттрибут тайла); move.w d5,$C00000 — вывод слов карты тайлов в порт данных VDP
        ifne *-$2138
        fail "ROM start moved"
        endif

VideoRoutine_002138:
        movem.w      (a7)+, d0-d1                                  ; $002138
        addi.w       #$80, d1                                      ; $00213C

loc_002140:
        move.w       (a1)+, d5                                     ; $002140
        add.w        d4, d5                                        ; $002142
        move.w       d5, VDP_DATA.l                                ; $002144
        dbra         d6, loc_002140                                ; $00214A
        dbra         d7, UploadTilemapColumns                      ; $00214E
        rts                                                        ; $002152
        ifne *-$2154
        fail "ROM end moved"
        endif
