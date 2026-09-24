; $07ACE4..$07ACE7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x7AC28] Инициализация музыки уровня: загрузка GEMS-драйвера, команды $0F/$1C, выбор трека из PC-таблицы, сброс канала $FF2A54 и заполнение голосов $0D..$1C через цикл
        ifne *-$7ACE4
        fail "ROM start moved"
        endif

; Reviewed call entry (fallthrough-wrapper): Stores D0 in rCurrentSoundSequenceId, then enters PlaySoundEvent.
StoreCurrentSoundSequenceAndPlayEvent:
        move.w       d0, rCurrentSoundSequenceId(a6)                                ; $07ACE4
        ifne *-$7ACE8
        fail "ROM end moved"
        endif
