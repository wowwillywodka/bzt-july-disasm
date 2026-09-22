; $000BCE..$000BF1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка палитры в CRAM: busy-wait по кадровому флагу (-0x7ffe,A6), маскирует IRQ (#$2700,SR), ставит CRAM-write команду ($C0000000) в $C00004, цикл move.w (A0)+,$C00000 dbf D0 — выгружает D0+1 цветов из A0 в CRAM, restore SR
        ifne *-$BCE
        fail "ROM start moved"
        endif

UploadPalette:
        tst.w        -$7ffe(a6)                                    ; $000BCE
        bne.b        UploadPalette                                 ; $000BD2
        move.w       sr, -(a7)                                     ; $000BD4
        move.w       #$2700, sr                                    ; $000BD6
        move.l       #$c0000000, VDP_CONTROL.l                     ; $000BDA

loc_000BE4:
        move.w       (a0)+, VDP_DATA.l                             ; $000BE4
        dbra         d0, loc_000BE4                                ; $000BEA
        move.w       (a7)+, sr                                     ; $000BEE
        rts                                                        ; $000BF0
        ifne *-$BF2
        fail "ROM end moved"
        endif
