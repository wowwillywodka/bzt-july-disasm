; $000A70..$000A71 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0xA46] LCG-генератор случайных чисел: seed (-0x7FFA,A6) * константы (mulu #-0x198D/#-0x44C0 со swap) +1, запись нового seed обратно
        ifne *-$A70
        fail "ROM start moved"
        endif

ReturnFromException:
        rte                                                        ; $000A70
        ifne *-$A72
        fail "ROM end moved"
        endif
