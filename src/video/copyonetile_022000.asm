; $022000..$022017 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Копирование 8 long'ов (32 байта = один тайл 8×8 4bpp) из (A0)+ в (A1)+
        ifne *-$22000
        fail "ROM start moved"
        endif

CopyOneTile:
        move.w       d0, -(a7)                                     ; $022000
        move.w       #$7, d0                                       ; $022002

loc_022006:
        move.l       (a0)+, (a1)+                                  ; $022006
        dbra         d0, loc_022006                                ; $022008
        move.w       (a7)+, d0                                     ; $02200C
        rts                                                        ; $02200E

; Reviewed call entry (wrapper): Sets D0=0 and D5=$3F, then branches to FadePaletteFromBlack.
FadeAll64PaletteColorsFromBlack:
        moveq        #$0, d0                                       ; $022010
        moveq        #$3f, d5                                      ; $022012
        bra.w        FadePaletteFromBlack                          ; $022014
        ifne *-$22018
        fail "ROM end moved"
        endif
