; $021728..$02173B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация VDP-экрана: очистка CRAM (0x21dc2, 64 слова), ПОЛНАЯ очистка VRAM (0x21dde, 32768 слов), затем загрузка таблицы VDP-регистров неймтейбла/скролла (0x21d2a)
        ifne *-$21728
        fail "ROM start moved"
        endif

InitializeRetainedScreenVideo:
        jsr          ClearCram.l                                   ; $021728
        jsr          ClearAllVram.l                                ; $02172E
        jsr          InitializeMenuVdp.l                           ; $021734
        rts                                                        ; $02173A
        ifne *-$2173C
        fail "ROM end moved"
        endif
