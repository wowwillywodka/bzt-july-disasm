; $07AC28..$07AC31 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация музыки уровня: загрузка GEMS-драйвера, команды $0F/$1C, выбор трека из PC-таблицы, сброс канала $FF2A54 и заполнение голосов $0D..$1C через цикл
        ifne *-$7AC28
        fail "ROM start moved"
        endif

InitializeSoundState:
        move.l       a6, -(a7)                                     ; $07AC28
        jsr          InitializeGems(pc)                            ; $07AC2A
        bra.w        loc_07AC50                                    ; $07AC2E
        ifne *-$7AC32
        fail "ROM end moved"
        endif
