; $02227A..$022281 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Палитра fade к белому: копирует текущую палитру в буфер, покадрово инкрементит R/G/B нибблы всех 64 цветов до максимума 0xE (белый) с записью в CRAM
        ifne *-$2227A
        fail "ROM start moved"
        endif

FadePaletteToWhite:
        moveq        #$0, d0                                       ; $02227A
        moveq        #$3f, d5                                      ; $02227C
        bra.w        loc_022284                                    ; $02227E
        ifne *-$22282
        fail "ROM end moved"
        endif
