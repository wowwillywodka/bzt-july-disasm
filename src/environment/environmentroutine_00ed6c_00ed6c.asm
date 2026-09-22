; $00ED6C..$00EDA9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Диспетчер celltype: чтение клетки, lookup типа (@0x24ea), индексация джамп-таблицы @0xeddc, jsr (A3) при совпадении адреса #0x126ae — триггер спец/анимированной стены
        ifne *-$ED6C
        fail "ROM start moved"
        endif

EnvironmentRoutine_00ED6C:
        clr.w        -$558e(a6)                                    ; $00ED6C
        lea.l        rCellTypeByIndex(a6), a5                      ; $00ED70
        clr.w        d3                                            ; $00ED74
        move.b       (a0), d3                                      ; $00ED76
        move.b       (a5, d3.w), d3                                ; $00ED78
        cmpi.b       #$5, d3                                       ; $00ED7C
        bls.b        loc_00EDA8                                    ; $00ED80
        cmpi.b       #$85, d3                                      ; $00ED82
        bne.b        loc_00ED8C                                    ; $00ED86
        move.b       #$25, d3                                      ; $00ED88

loc_00ED8C:
        cmpi.b       #$94, d3                                      ; $00ED8C
        bhi.b        loc_00EDA8                                    ; $00ED90
        lsl.w        #$2, d3                                       ; $00ED92
        movea.l      CellInteractionHandlers(pc, d3.w), a3         ; $00ED94
        lsr.w        #$2, d3                                       ; $00ED98
        cmpa.l       #$126ae, a3                                   ; $00ED9A
        bne.b        loc_00EDA8                                    ; $00EDA0
        move.l       a0, -(a7)                                     ; $00EDA2
        jsr          (a3)                                          ; $00EDA4
        movea.l      (a7)+, a0                                     ; $00EDA6

loc_00EDA8:
        rts                                                        ; $00EDA8
        ifne *-$EDAA
        fail "ROM end moved"
        endif
