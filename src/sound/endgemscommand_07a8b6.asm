; $07A8B6..$07A8C7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Конец чтения статуса Z80: снимает bus-request ($A11100=0), восстанавливает SR/регистры, unlk A6 — парный выход к 0x7A880
        ifne *-$7A8B6
        fail "ROM start moved"
        endif

EndGemsCommand:
        move.w       #$0, Z80_BUS_REQUEST.l                        ; $07A8B6
        move.w       (a7)+, sr                                     ; $07A8BE
        movem.l      (a7)+, d1/a1                                  ; $07A8C0
        unlk         a6                                            ; $07A8C4
        rts                                                        ; $07A8C6
        ifne *-$7A8C8
        fail "ROM end moved"
        endif
