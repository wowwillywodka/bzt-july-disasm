; $009626..$009635 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обёртка: сохраняет A0/A1 и jsr $df84 — ставит в кольцевую очередь команд (FUN_0x1ffcc) типизированный пакет события/отрисовки
        ifne *-$9626
        fail "ROM start moved"
        endif

RendererRoutine_009626:
        movem.l      a0-a1, -(a7)                                  ; $009626
        jsr          SoundRoutine_00DF84.l                         ; $00962A
        movem.l      (a7)+, a0-a1                                  ; $009630
        rts                                                        ; $009634
        ifne *-$9636
        fail "ROM end moved"
        endif
