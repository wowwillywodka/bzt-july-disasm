; $0220EC..$0221A7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Палитра fade-out к чёрному: копирует исходную палитру из (A0) в буфер (-0x7908,A6), покадрово декрементит R/G/B нибблы всех 64 цветов к нулю с записью в CRAM, в конце очищает CRAM (FUN_21dc2)
        ifne *-$220EC
        fail "ROM start moved"
        endif

FadePaletteToBlack:
        movem.l      d0-d1/d5/a0, -(a7)                            ; $0220EC
        movea.l      a0, a5                                        ; $0220F0
        move.l       a0, -(a7)                                     ; $0220F2
        jsr          LoadPaletteLine(pc)                           ; $0220F4
        movea.l      (a7)+, a0                                     ; $0220F8
        lea.l        rPaletteFadeCurrentColors(a6), a1                                ; $0220FA
        moveq        #$20, d0                                      ; $0220FE
        subq.w       #$1, d0                                       ; $022100

loc_022102:
        move.l       (a0)+, (a1)+                                  ; $022102
        dbra         d0, loc_022102                                ; $022104
        movem.l      (a7)+, d0-d1/d5/a0                            ; $022108

loc_02210C:
        move.b       #$1, d7                                       ; $02210C
        move.l       a0, -(a7)                                     ; $022110
        move.l       d1, d0                                        ; $022112
        jsr          WaitVBlankFrames(pc)                          ; $022114
        lea.l        rPaletteFadeCurrentColors(a6), a1                                ; $022118
        move.w       d5, d2                                        ; $02211C

loc_02211E:
        move.w       (a1), d3                                      ; $02211E
        andi.w       #$e00, d3                                     ; $022120
        cmpi.w       #$0, d3                                       ; $022124
        beq.w        loc_022130                                    ; $022128
        subi.w       #$200, (a1)                                   ; $02212C

loc_022130:
        move.w       (a1), d3                                      ; $022130
        andi.w       #$e0, d3                                      ; $022132
        cmpi.w       #$0, d3                                       ; $022136
        beq.w        loc_022142                                    ; $02213A
        subi.w       #$20, (a1)                                    ; $02213E

loc_022142:
        move.w       (a1), d3                                      ; $022142
        andi.w       #$e, d3                                       ; $022144
        cmpi.w       #$0, d3                                       ; $022148
        beq.w        loc_022152                                    ; $02214C
        subq.w       #$2, (a1)                                     ; $022150

loc_022152:
        cmpi.w       #$0, (a1)+                                    ; $022152
        beq.w        loc_02215E                                    ; $022156
        move.b       #$0, d7                                       ; $02215A

loc_02215E:
        dbra         d2, loc_02211E                                ; $02215E
        cmpi.b       #$1, d7                                       ; $022162
        beq.w        loc_0221A0                                    ; $022166
        movem.l      d0-d1/d5-d7/a0, -(a7)                         ; $02216A
        moveq        #$0, d6                                       ; $02216E
        move.w       d6, d4                                        ; $022170

loc_022172:
        lea.l        rPaletteFadeCurrentColors(a6), a0                                ; $022172
        adda.l       d6, a0                                        ; $022176
        move.w       d4, d0                                        ; $022178
        movem.l      d4-d6, -(a7)                                  ; $02217A
        jsr          LoadPaletteLine(pc)                           ; $02217E
        movem.l      (a7)+, d4-d6                                  ; $022182
        subi.w       #$10, d5                                      ; $022186
        bmi.w        loc_022196                                    ; $02218A
        addi.w       #$20, d6                                      ; $02218E
        addq.w       #$1, d4                                       ; $022192
        bra.b        loc_022172                                    ; $022194

loc_022196:
        movem.l      (a7)+, d0-d1/d5-d7/a0                         ; $022196
        movea.l      (a7)+, a0                                     ; $02219A
        bra.w        loc_02210C                                    ; $02219C

loc_0221A0:
        jsr          ClearCram(pc)                                 ; $0221A0
        movea.l      (a7)+, a0                                     ; $0221A4
        rts                                                        ; $0221A6
        ifne *-$221A8
        fail "ROM end moved"
        endif
