; $008DD8..$008DDD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x8B50] Диспетчер команд очереди: маскирует D3, при коде $25 пишет байт в (A0)+вызовом, затем по индексу D3*4 из таблицы @0x8B84 берёт обработчик и jsr(A4)
        ifne *-$8DD8
        fail "ROM start moved"
        endif

loc_008DD8:
        jsr          QueueProjectedWorldObject.l                   ; $008DD8
        ifne *-$8DDE
        fail "ROM end moved"
        endif
