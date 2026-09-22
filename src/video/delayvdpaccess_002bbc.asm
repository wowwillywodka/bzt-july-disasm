; $002BBC..$002BCB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; VDP-таймаут-задержка: сохраняет D7, грузит #0x3c и крутит пустой dbf-цикл (nop), восстанавливает D7, rts — пауза между записью в VDP-control ($C00004) и чтением VDP-data ($C00000) у вызывающих (0x2972/0x298e/0xe1fe)
        ifne *-$2BBC
        fail "ROM start moved"
        endif

DelayVdpAccess:
        move.w       d7, -(a7)                                     ; $002BBC
        move.w       #$3c, d7                                      ; $002BBE

loc_002BC2:
        nop                                                        ; $002BC2
        dbra         d7, loc_002BC2                                ; $002BC4
        move.w       (a7)+, d7                                     ; $002BC8
        rts                                                        ; $002BCA
        ifne *-$2BCC
        fail "ROM end moved"
        endif
