; $0221A8..$0221AF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Палитра fade-out из белого к целевой (0x223d0): инициализирует буфер цветом 0x0EEE (белый), покадрово сводит R/G/B нибблы вниз к целевым значениям с записью в CRAM
        ifne *-$221A8
        fail "ROM start moved"
        endif

FadePaletteFromWhite:
        moveq        #$0, d0                                       ; $0221A8
        moveq        #$3f, d5                                      ; $0221AA
        bra.w        loc_0221B2                                    ; $0221AC
        ifne *-$221B0
        fail "ROM end moved"
        endif
