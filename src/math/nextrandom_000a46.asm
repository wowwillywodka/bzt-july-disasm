; $000A46..$000A6F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; LCG-генератор случайных чисел: seed (-0x7FFA,A6) * константы (mulu #-0x198D/#-0x44C0 со swap) +1, запись нового seed обратно
        ifne *-$A46
        fail "ROM start moved"
        endif

NextRandom:
        move.l       -$7ffa(a6), d0                                ; $000A46
        move.w       d0, d2                                        ; $000A4A
        mulu.w       #$e673, d2                                    ; $000A4C
        move.l       d0, d1                                        ; $000A50
        swap         d1                                            ; $000A52
        mulu.w       #$e673, d1                                    ; $000A54
        swap         d1                                            ; $000A58
        clr.w        d1                                            ; $000A5A
        add.l        d1, d2                                        ; $000A5C
        mulu.w       #$bb40, d0                                    ; $000A5E
        swap         d0                                            ; $000A62
        clr.w        d0                                            ; $000A64
        add.l        d0, d2                                        ; $000A66
        addq.l       #$1, d2                                       ; $000A68
        move.l       d2, -$7ffa(a6)                                ; $000A6A
        rts                                                        ; $000A6E
        ifne *-$A70
        fail "ROM end moved"
        endif
