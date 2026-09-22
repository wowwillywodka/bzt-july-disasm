; $022022..$0220E9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Палитра fade-in к целевой: загружает целевые цвета из таблицы 0x223b0, обнуляет рабочий буфер (-0x7908,A6), покадрово инкрементит R/G/B нибблы каждого из 64 цветов к цели и грузит в CRAM, пока не совпадёт
        ifne *-$22022
        fail "ROM start moved"
        endif

FadePaletteFromBlack:
        movem.l      d0-d1/d5/a0, -(a7)                            ; $022022
        movea.l      a0, a5                                        ; $022026
        moveq        #$0, d0                                       ; $022028
        lea.l        IntroPaletteA.l, a0                           ; $02202A
        jsr          LoadPaletteLine(pc)                           ; $022030
        lea.l        -$7908(a6), a0                                ; $022034
        moveq        #$1f, d0                                      ; $022038

loc_02203A:
        move.l       #$0, (a0)+                                    ; $02203A
        dbra         d0, loc_02203A                                ; $022040
        movem.l      (a7)+, d0-d1/d5/a0                            ; $022044

loc_022048:
        move.b       #$1, d7                                       ; $022048
        move.l       a0, -(a7)                                     ; $02204C
        move.l       d1, d0                                        ; $02204E
        jsr          WaitVBlankFrames(pc)                          ; $022050
        lea.l        -$7908(a6), a1                                ; $022054
        move.w       d5, d2                                        ; $022058

loc_02205A:
        move.w       (a0), d3                                      ; $02205A
        move.w       (a1), d4                                      ; $02205C
        andi.w       #$e00, d3                                     ; $02205E
        andi.w       #$e00, d4                                     ; $022062
        cmp.w        d3, d4                                        ; $022066
        beq.w        loc_022070                                    ; $022068
        addi.w       #$200, (a1)                                   ; $02206C

loc_022070:
        move.w       (a0), d3                                      ; $022070
        move.w       (a1), d4                                      ; $022072
        andi.w       #$e0, d3                                      ; $022074
        andi.w       #$e0, d4                                      ; $022078
        cmp.w        d3, d4                                        ; $02207C
        beq.w        loc_022086                                    ; $02207E
        addi.w       #$20, (a1)                                    ; $022082

loc_022086:
        move.w       (a0), d3                                      ; $022086
        move.w       (a1), d4                                      ; $022088
        andi.w       #$e, d3                                       ; $02208A
        andi.w       #$e, d4                                       ; $02208E
        cmp.w        d3, d4                                        ; $022092
        beq.w        loc_02209A                                    ; $022094
        addq.w       #$2, (a1)                                     ; $022098

loc_02209A:
        cmpm.w       (a0)+, (a1)+                                  ; $02209A
        beq.w        loc_0220A4                                    ; $02209C
        move.b       #$0, d7                                       ; $0220A0

loc_0220A4:
        dbra         d2, loc_02205A                                ; $0220A4
        cmpi.b       #$1, d7                                       ; $0220A8
        beq.w        loc_0220E6                                    ; $0220AC
        movem.l      d0-d1/d5-d7/a0, -(a7)                         ; $0220B0
        moveq        #$0, d6                                       ; $0220B4
        move.w       d6, d4                                        ; $0220B6

loc_0220B8:
        lea.l        -$7908(a6), a0                                ; $0220B8
        adda.l       d6, a0                                        ; $0220BC
        move.w       d4, d0                                        ; $0220BE
        movem.l      d4-d6, -(a7)                                  ; $0220C0
        jsr          LoadPaletteLine(pc)                           ; $0220C4
        movem.l      (a7)+, d4-d6                                  ; $0220C8
        subi.w       #$10, d5                                      ; $0220CC
        bmi.w        loc_0220DC                                    ; $0220D0
        addi.w       #$20, d6                                      ; $0220D4
        addq.w       #$1, d4                                       ; $0220D8
        bra.b        loc_0220B8                                    ; $0220DA

loc_0220DC:
        movem.l      (a7)+, d0-d1/d5-d7/a0                         ; $0220DC
        movea.l      (a7)+, a0                                     ; $0220E0
        bra.w        loc_022048                                    ; $0220E2

loc_0220E6:
        movea.l      (a7)+, a0                                     ; $0220E6
        rts                                                        ; $0220E8
        ifne *-$220EA
        fail "ROM end moved"
        endif
