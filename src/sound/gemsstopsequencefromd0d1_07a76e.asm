; $07A76E..$07A785 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$7A76E
        fail "ROM start moved"
        endif

GemsStopSequenceFromD0D1:
; The wrapper pushes both D1 and D0, but GemsStopSequence reads only the
; first stack argument (D0 low byte). The D1 argument is ignored.
        andi.l       #$ffff, d1                                    ; $07A76E
        move.l       d1, -(a7)                                     ; $07A774
        andi.l       #$ffff, d0                                    ; $07A776
        move.l       d0, -(a7)                                     ; $07A77C
        bsr.w        GemsStopSequence                           ; $07A77E
        addq.w       #$8, a7                                       ; $07A782
        rts                                                        ; $07A784
        ifne *-$7A786
        fail "ROM end moved"
        endif
