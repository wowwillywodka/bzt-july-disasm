; $07A7F6..$07A809 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Захват шины Z80: пишет $0100 в $A11100 (bus-request) и busy-wait по биту 0, пока Z80 не остановлен — синхронизация перед доступом к $A00000
        ifne *-$7A7F6
        fail "ROM start moved"
        endif

AcquireZ80Bus:
        move.w       #$100, Z80_BUS_REQUEST.l                      ; $07A7F6

loc_07A7FE:
        btst.b       #$0, Z80_BUS_REQUEST.l                        ; $07A7FE
        bne.b        loc_07A7FE                                    ; $07A806
        rts                                                        ; $07A808
        ifne *-$7A80A
        fail "ROM end moved"
        endif
