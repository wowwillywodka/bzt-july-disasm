; $002132..$002137 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 2100] Хвост двойного column-writer: пишет адрес в $C00004, вложенные циклы (dbra d6/d7) шлют слова (a1)++D4 в порт данных $C00000
        ifne *-$2132
        fail "ROM start moved"
        endif

WriteTilemapColumnsVdpAddress:
        move.l       d1, VDP_CONTROL.l                             ; $002132
        ifne *-$2138
        fail "ROM end moved"
        endif
