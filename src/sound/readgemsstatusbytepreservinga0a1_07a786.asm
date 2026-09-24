; $07A786..$07A799 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Обёртка чтения байта состояния GEMS: сохраняет A0/A1, маскирует индекс D0 до байта и вызывает GemsReadStatus ($07AA72), который читает Z80 RAM $A01B22[D0]
        ifne *-$7A786
        fail "ROM start moved"
        endif

ReadGemsStatusBytePreservingA0A1:
        movem.l      a0-a1, -(a7)                                  ; $07A786
        andi.l       #$ff, d0                                      ; $07A78A
        bsr.w        GemsReadStatus                                ; $07A790
        movem.l      (a7)+, a0-a1                                  ; $07A794
        rts                                                        ; $07A798
        ifne *-$7A79A
        fail "ROM end moved"
        endif
