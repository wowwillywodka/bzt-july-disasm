; $07A786..$07A799 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обёртка постановки звука в очередь Z80: сохраняет A0/A1, маскирует D0 до байта (номер сэмпла/трека) и вызывает 0x7AA72 для записи команды в область связи Z80
        ifne *-$7A786
        fail "ROM start moved"
        endif

QueueGemsSound:
        movem.l      a0-a1, -(a7)                                  ; $07A786
        andi.l       #$ff, d0                                      ; $07A78A
        bsr.w        GemsReadStatus                                ; $07A790
        movem.l      (a7)+, a0-a1                                  ; $07A794
        rts                                                        ; $07A798
        ifne *-$7A79A
        fail "ROM end moved"
        endif
