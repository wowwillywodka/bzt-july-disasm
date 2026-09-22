; $07AEC8..$07AED1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обёртка GEMS-команды 0xc (стоп/пауза музыки): вызывает API-точку 0x7a974 драйвера GEMS
        ifne *-$7AEC8
        fail "ROM start moved"
        endif

PauseGemsSequences:
        move.l       a6, -(a7)                                     ; $07AEC8
        jsr          SoundRoutine_07A974(pc)                       ; $07AECA
        movea.l      (a7)+, a6                                     ; $07AECE
        rts                                                        ; $07AED0
        ifne *-$7AED2
        fail "ROM end moved"
        endif
