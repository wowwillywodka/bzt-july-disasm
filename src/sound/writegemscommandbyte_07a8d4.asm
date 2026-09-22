; $07A8D4..$07A8E1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Кладёт байт D0 в Z80-кольцо GEMS-команд (A1) по индексу D1, инкремент индекса mod 64, запись индекса в $A00036
        ifne *-$7A8D4
        fail "ROM start moved"
        endif

WriteGemsCommandByte:
        move.b       d0, (a1, d1.w)                                ; $07A8D4
        addq.b       #$1, d1                                       ; $07A8D8
        andi.b       #$3f, d1                                      ; $07A8DA
        move.b       d1, (a0)                                      ; $07A8DE
        rts                                                        ; $07A8E0
        ifne *-$7A8E2
        fail "ROM end moved"
        endif
