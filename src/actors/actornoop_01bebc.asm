; $01BEBC..$01BEBD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x1BE0C] Главный цикл обновления актёров: заполняет шаблон (-0x6e1e,A6) позицией/углами камеры, обходит список актёров (счётчик -0x57c6, ptr -0x57c4), валидирует позицию (0x24/0x26 в [0,0x2000), тайл 0x36 в [0,0xf]) и по таймеру 
        ifne *-$1BEBC
        fail "ROM start moved"
        endif

ActorNoOp:
        rts                                                        ; $01BEBC
        ifne *-$1BEBE
        fail "ROM end moved"
        endif
