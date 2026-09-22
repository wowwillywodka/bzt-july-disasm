; $001A78..$001A83 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Vblank-wait: крутится на чтении кадрового счётчика (-0x8000,A6)=$FF8000, пока значение не изменится (cmp/beq самопетля), затем rts — синхронизация с обратным ходом луча
        ifne *-$1A78
        fail "ROM start moved"
        endif

WaitForVBlank:
        move.w       rVBlankCounter(a6), d0                        ; $001A78

loc_001A7C:
        cmp.w        rVBlankCounter(a6), d0                        ; $001A7C
        beq.b        loc_001A7C                                    ; $001A80
        rts                                                        ; $001A82
        ifne *-$1A84
        fail "ROM end moved"
        endif
