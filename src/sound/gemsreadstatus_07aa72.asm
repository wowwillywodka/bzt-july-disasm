; $07AA72..$07AA8D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Маскирует IRQ ($700 в SR), запрашивает шину Z80 (0x7a7f6: $A11100=$100), читает байт из таблицы $A01B22 по индексу D0, освобождает шину Z80 (0x7a80a: $A11100=0), восстанавливает SR
        ifne *-$7AA72
        fail "ROM start moved"
        endif

GemsReadStatus:
        move.w       sr, -(a7)                                     ; $07AA72
        ori.w        #$700, sr                                     ; $07AA74
        jsr          AcquireZ80Bus(pc)                             ; $07AA78
        lea.l        $a01b22.l, a0                                 ; $07AA7C
        move.b       (a0, d0.w), d0                                ; $07AA82
        jsr          ReleaseZ80Bus(pc)                             ; $07AA86
        move.w       (a7)+, sr                                     ; $07AA8A
        rts                                                        ; $07AA8C
        ifne *-$7AA8E
        fail "ROM end moved"
        endif
