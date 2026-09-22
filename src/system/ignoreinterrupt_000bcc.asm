; $000BCC..$000BCD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0xB03] Часть VBLANK: настройка VDP-автоинкремента/регистров через A0=$C00004 и DMA (jsr $7A79A/$7A7D8), запись уровня затемнения/фейда $FF10A8 в $C00000 с шагами по $FF0DF0
        ifne *-$BCC
        fail "ROM start moved"
        endif

IgnoreInterrupt:
        rte                                                        ; $000BCC
        ifne *-$BCE
        fail "ROM end moved"
        endif
