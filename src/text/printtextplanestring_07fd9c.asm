; $07FD9C..$07FE09 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=NUL-terminated ASCII; D0=VRAM byte address. Glyph (char-$20)*4 gives upper/lower 8x8 tiles. Second row is +$100 bytes (128-cell plane stride); no range or width check.
        ifne *-$7FD9C
        fail "ROM start moved"
        endif

PrintTextPlaneString:
; A0=NUL-terminated ASCII; D0=VRAM byte address. Glyph (char-$20)*4 gives upper/lower 8x8 tiles. Second row is +$100 bytes (128-cell plane stride); no range or width check.
        movea.l      #VDP_DATA, a4                                 ; $07FD9C
        lea.l        BriefingGlyphPairs(pc), a1                    ; $07FDA2
        move.w       d0, -(a7)                                     ; $07FDA6
        move.l       a0, -(a7)                                     ; $07FDA8
        move.w       d0, d1                                        ; $07FDAA
        andi.w       #$3fff, d1                                    ; $07FDAC
        ori.w        #$4000, d1                                    ; $07FDB0
        swap         d1                                            ; $07FDB4
        lsr.w        #$8, d0                                       ; $07FDB6
        lsr.w        #$6, d0                                       ; $07FDB8
        move.w       d0, d1                                        ; $07FDBA
        move.l       d1, VDP_CONTROL.l                             ; $07FDBC

loc_07FDC2:
        clr.w        d0                                            ; $07FDC2
        move.b       (a0)+, d0                                     ; $07FDC4
        beq.b        loc_07FDD4                                    ; $07FDC6
        subi.w       #$20, d0                                      ; $07FDC8
        lsl.w        #$2, d0                                       ; $07FDCC
        move.w       (a1, d0.w), (a4)                              ; $07FDCE
        bra.b        loc_07FDC2                                    ; $07FDD2

loc_07FDD4:
        addq.w       #$2, a1                                       ; $07FDD4
        movea.l      (a7)+, a0                                     ; $07FDD6
        move.w       (a7)+, d0                                     ; $07FDD8
        addi.w       #$100, d0                                     ; $07FDDA
        move.w       d0, d1                                        ; $07FDDE
        andi.w       #$3fff, d1                                    ; $07FDE0
        ori.w        #$4000, d1                                    ; $07FDE4
        swap         d1                                            ; $07FDE8
        lsr.w        #$8, d0                                       ; $07FDEA
        lsr.w        #$6, d0                                       ; $07FDEC
        move.w       d0, d1                                        ; $07FDEE
        move.l       d1, VDP_CONTROL.l                             ; $07FDF0

loc_07FDF6:
        clr.w        d0                                            ; $07FDF6
        move.b       (a0)+, d0                                     ; $07FDF8
        beq.b        loc_07FE08                                    ; $07FDFA
        subi.w       #$20, d0                                      ; $07FDFC
        lsl.w        #$2, d0                                       ; $07FE00
        move.w       (a1, d0.w), (a4)                              ; $07FE02
        bra.b        loc_07FDF6                                    ; $07FE06

loc_07FE08:
        rts                                                        ; $07FE08
        ifne *-$7FE0A
        fail "ROM end moved"
        endif
