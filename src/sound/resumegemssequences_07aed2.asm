; $07AED2..$07AEDB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обёртка GEMS-команды 0xd (стоп/возобновление звука): вызывает API-точку 0x7a982 драйвера GEMS
        ifne *-$7AED2
        fail "ROM start moved"
        endif

ResumeGemsSequences:
        move.l       a6, -(a7)                                     ; $07AED2
        jsr          GemsResumeAll(pc)                       ; $07AED4
        movea.l      (a7)+, a6                                     ; $07AED8
        rts                                                        ; $07AEDA
        ifne *-$7AEDC
        fail "ROM end moved"
        endif
