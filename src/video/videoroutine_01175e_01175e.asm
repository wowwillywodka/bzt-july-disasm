; $01175E..$0117AB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Блит одной HUD-иконки в VRAM: по коду из (A0) либо заливает 0x80 длинных нулями в порт данных $C00000 (пустой слот), либо стримит тайлсет иконки (0x1a лонгов) из PC-таблицы, рисует числовой счётчик через jsr 0x20944 и дольёт 0x60 лонгов в $C00000
        ifne *-$1175E
        fail "ROM start moved"
        endif

VideoRoutine_01175E:
        movea.l      #VDP_DATA, a4                                 ; $01175E
        move.w       (a0), d0                                      ; $011764
        beq.b        loc_01179E                                    ; $011766
        subq.w       #$1, d0                                       ; $011768
        lsl.w        #$2, d0                                       ; $01176A
        lea.l        InventoryIconPointers(pc), a1                 ; $01176C
        movea.l      (a1, d0.w), a1                                ; $011770
        move.w       #$19, d6                                      ; $011774

loc_011778:
        move.l       (a1)+, (a4)                                   ; $011778
        dbra         d6, loc_011778                                ; $01177A
        move.w       $2(a0), d0                                    ; $01177E
        subq.w       #$1, d0                                       ; $011782
        lsr.w        #$8, d0                                       ; $011784
        addq.w       #$1, d0                                       ; $011786
        jsr          UiRoutine_020944.l                            ; $011788
        adda.w       #$18, a1                                      ; $01178E
        move.w       #$5f, d6                                      ; $011792

loc_011796:
        move.l       (a1)+, (a4)                                   ; $011796
        dbra         d6, loc_011796                                ; $011798
        rts                                                        ; $01179C

loc_01179E:
        move.w       #$7f, d6                                      ; $01179E
        moveq        #$0, d7                                       ; $0117A2

loc_0117A4:
        move.l       d7, (a4)                                      ; $0117A4
        dbra         d6, loc_0117A4                                ; $0117A6
        rts                                                        ; $0117AA
        ifne *-$117AC
        fail "ROM end moved"
        endif
